import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:make_ten_billion/models/user_model.dart';
import 'package:make_ten_billion/views/home.dart';
import 'package:make_ten_billion/views/sign_in.dart';
import 'package:make_ten_billion/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController1 = TextEditingController();
  TextEditingController phoneNumberController2 = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool authOk = false;
  String verificationId = '';
  bool requestedAuth = false;

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final userReference =
  FirebaseFirestore.instance.collection('Users'); // 사용자 정보 저장을 위한 ref
  final firestoreReference = FirebaseFirestore.instance; // batch 사용을 위한 선언
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onReady() async {
    //run every time auth state changes
    // await FlutterSecureStorage().deleteAll();
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);
    update();
    super.onReady();
  }

  handleAuthChanged(_firebaseUser) async {
    // get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      /// 최종 로그인 시간 변경
      // updateWhenLoggedIn(_firebaseUser);
      // await isAdmin();
    }

    /// 앱 시작시 기존 로그인했던 사용자라면 바로 HomeUI로, 로그인 필요한 사용자라면 SignInUI 페이지로 이동
    if (_firebaseUser == null) {
      print('Send to signin');
      Get.offAll(() => SignIn());
    } else {
      Get.offAll(() => Home());
    }
  }

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/Users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  /// user data 불러오기
  void fetchUserModel() async {
    // _userData =
  }

  // User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      await _auth
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((result) async {
        print('uID: ' + result.user!.uid.toString());
        print('email: ' + result.user!.email.toString());
        //get photo url from gravatar if user has one
        // Gravatar gravatar = Gravatar(emailController.text);
        // String gravatarUrl = gravatar.imageUrl(
        //   size: 200,
        //   defaultImage: GravatarImage.retro,
        //   rating: GravatarRating.pg,
        //   fileExtension: true,
        // );

        /// 추가정보 입력받기
        /// final String company;
        /// final String nickName;
        /// final String whatToDo;
        /// final int age;
        /// final int height;
        /// final String bodyStyle;
        /// final String address;
        /// final String married;
        /// final String religion;
        /// final String smoking;
        /// final String drinking;
        /// final String greetings;
        /// final List<String> favoriteListen;
        /// final List<String> introduceMyself;
        /// final List<String> favoriteThings;
        // final info = await Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => RegisterExtraInfoUI()));

        //create the new user object
        UserModel _newUser = UserModel(
          uid: result.user!.uid,
          profileName: nameController.text,
          email: emailController.text,
        );
        // create the user in firestore
        _createUserFirestore(_newUser, result.user!);
        emailController.clear();
        passwordController.clear();
        hideLoadingIndicator();
      });
    } on FirebaseAuthException catch (error) {
      hideLoadingIndicator();
      print(error);
      Get.snackbar('회원가입 오류', '메일주소 혹은 비밀번호를 확인해주세요.',
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //create the firestore user in users collection
  void _createUserFirestore(user, User _firebaseUser) {
    _db.doc('/Users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  //Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('로그인 오류', '메일주소 혹은 비밀번호를 확인해주세요.',
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //handles updating the user when updating profile
  Future<void> updateUser(BuildContext context, UserModel user, String oldEmail,
      String password) async {
    String _authUpdateUserNoticeTitle = 'auth.updateUserSuccessNoticeTitle'.tr;
    String _authUpdateUserNotice = 'auth.updateUserSuccessNotice'.tr;

    try {
      showLoadingIndicator();
      try {
        await _auth
            .signInWithEmailAndPassword(email: oldEmail, password: password)
            .then((_firebaseUser) {
          _firebaseUser.user!
              .updateEmail(user.email)
              .then((value) => _updateUserFirestore(user, _firebaseUser.user!));
        });
      } catch (err) {
        print('Caught error: $err');
        //not yet working, see this issue https://github.com/delay/make_destiny/issues/21
        if (err ==
            "Error: [firebase_auth/email-already-in-use] The email address is already in use by another account.") {
          _authUpdateUserNoticeTitle = 'auth.updateUserEmailInUse'.tr;
          _authUpdateUserNotice = 'auth.updateUserEmailInUse'.tr;
        } else {
          _authUpdateUserNoticeTitle = 'auth.wrongPasswordNotice'.tr;
          _authUpdateUserNotice = 'auth.wrongPasswordNotice'.tr;
        }
      }
      hideLoadingIndicator();
      Get.snackbar(_authUpdateUserNoticeTitle, _authUpdateUserNotice,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on PlatformException catch (error) {
      //List<String> errors = error.toString().split(',');
      // print("Error: " + errors[1]);
      hideLoadingIndicator();
      print(error.code);
      String authError;
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          authError = 'auth.wrongPasswordNotice'.tr;
          break;
        default:
          authError = 'auth.unknownError'.tr;
          break;
      }
      Get.snackbar('auth.wrongPasswordNoticeTitle'.tr, authError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //updates the firestore user in users collection
  void _updateUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/Users/${_firebaseUser.uid}').update(user.toJson());
    update();
  }

  signInWithGoogle() async {
    try {
      // final GoogleSignInAccount? account = await googleSignIn.signIn();
      /// 구글 로그인 수행
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();

      /// 로그인 요청의 인증 관련 세부 정보 얻기
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      /// 자격 증명 생성하기
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      /// FirebaseAuth의 signInWithCredential을 통해 UserCredential을 얻는다.
      /// SNS로그인의 경우 최종 과정에서 해당 UserCredential을 얻어 사용자 정보를 획득해야 한다.
      _auth.signInWithCredential(credential).then((authResult) async {
        // firebaseUser = authResult.user as Rxn<User>;
        /// 해당 사용자 정보를 통해 기존 DB에 저장된 정보를 확인
        DocumentSnapshot documentSnapshot =
        await userReference.doc(authResult.user!.uid).get();

        /// 해당 유저의 db정보가 없다면
        if (!documentSnapshot.exists) {
          /// 유저정보 셋팅된 값으로 db에 set
          userReference.doc(authResult.user!.uid).set({
            'uid': authResult.user!.uid,
            'profileName': authResult.user!.displayName,
            //gCurrentUser!.displayName,
            'url': authResult.user!.photoURL,
            //gCurrentUser.photoUrl,
            'email': authResult.user!.email,
            //gCurrentUser.email
            'createdAt': DateTime.now(),
            'loginType': "Google",
            "phoneAuthOk": false,
          });
        } else {
          /// 기존에 저장된 값이 있다면 로그인 시간만 갱신
          userReference
              .doc(authResult.user!.uid)
              .update({'loginType': "Google", 'loggedInAt': DateTime.now()});
        }
      });
      await FlutterSecureStorage().write(key: "loginType", value: 'Google');
    } catch (e) {
      print(e.toString());
    }
  }

  void verifyWithPhoneNumber({required phoneNumber, required verificationCompleted, required codeAutoRetrievalTimeout, required verificationFailed, required codeSent, required Duration timeout}) async {
    _auth.verifyPhoneNumber(phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    // showLoadingIndicator();
    try {
      final authCredential = await _auth.signInWithCredential(
          phoneAuthCredential);
      // hideLoadingIndicator();

      if (authCredential.user != null) {
        authOk = true;
        userReference
            .doc(firestoreUser.value!.uid)
            .update({'phoneAuthOk': true,});
        // await _auth.currentUser!.delete();
        // _auth.signOut();
      } else {
        print('올바른 인증코드가 아닙니다.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateWhenLoggedIn(User _firebaseUser) async {
    await userReference
        .doc(_firebaseUser.uid)
        .update({'loggedInAt': DateTime.now()});
  }

  // Sign out
  Future<void> signOut() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }

  // UserModel get userData => _userData.value;
  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();
}
