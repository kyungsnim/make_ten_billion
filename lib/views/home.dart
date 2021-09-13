import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_ten_billion/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../core_screen.dart';
import 'views.dart';

class Home extends StatefulWidget {
  int index;

  Home(this.index);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {


  int? currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    /// with WidgetsBindingObserver 과 함께 foreground 동적링크를 위한 추가
    WidgetsBinding.instance!.addObserver(this);
    getDynamicLink();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed) {
      FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
        var deepLink = dynamicLink?.link;

        String realLink = deepLink.toString().replaceAll('%3D', '=');

        int lastIdx = realLink.lastIndexOf('/'); // 링크 뒷부분만 떼어 내기
        String firstEdit = realLink.substring(lastIdx + 2);

        List<dynamic> splitList = firstEdit.split("?");
        Map<String, dynamic> _newMaps = {};

        for (var i = 0; i < splitList.length; i++) {
          _newMaps[splitList[i].split("=")[0]] = splitList[i].split("=")[1];
        }

        // Get.offAll(() => Home(3));
        Get.offAll(() => CoreScreen(data: _newMaps));
        // Navigator.push(context, MaterialPageRoute(builder: (context) => CoreScreen(data: _newMaps)));
        // navigatorKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CoreScreen(data: _newMaps)), (route) => false);

      });
    }
  }

  void getDynamicLink() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? initialLink = data?.link;

    String realLink = initialLink.toString().replaceAll('%3D', '=');

    int lastIdx = realLink.lastIndexOf('/'); // 링크 뒷부분만 떼어 내기
    String firstEdit = realLink.substring(lastIdx + 2);

    if(initialLink != null) {
      /// do something
      List<dynamic> splitList = firstEdit.split("?");
      Map<String, dynamic> _newMaps = {};

      for(var i = 0; i < splitList.length; i++) {
        _newMaps[splitList[i].split("=")[0]] = splitList[i].split("=")[1];
      }
      Get.offAll(() => CoreScreen(data: _newMaps));
    } else {
      FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
        var deepLink = dynamicLink?.link;

        String realLink = deepLink.toString().replaceAll('%3D', '=');

        int lastIdx = realLink.lastIndexOf('/'); // 링크 뒷부분만 떼어 내기
        String firstEdit = realLink.substring(lastIdx + 2);

        List<dynamic> splitList = firstEdit.split("?");
        Map<String, dynamic> _newMaps = {};

        for(var i = 0; i < splitList.length; i++) {
          _newMaps[splitList[i].split("=")[0]] = splitList[i].split("=")[1];
        }
        Get.offAll(() => CoreScreen(data: _newMaps));
        /// do something

      });
    }

  }

  @override
  void dispose() {
    super.dispose();
    /// with WidgetsBindingObserver 과 함께 foreground 동적링크를 위한 추가
    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final authController = AuthController.to;

    return GetBuilder<AuthController>(
      builder: (_) =>
      WillPopScope(
        onWillPop: () => _onBackPressed(context),
        child: DefaultTabController(
          length: 4,
          initialIndex: currentIndex!,
          child: Scaffold(
            appBar: AppBar(
              title: Text('매일 읽는 100억 부자 되기 습관', style: TextStyle(fontFamily: 'Binggrae',
                  fontWeight: FontWeight.bold, color: Colors.black, fontSize: 26),),
              bottom: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                physics: NeverScrollableScrollPhysics(),
                tabs: [
                  Tab(child: Text('부자되는\n방법', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Binggrae',
                    fontWeight: FontWeight.bold, fontSize: 14),), ),
                  Tab(child: Text('부자\n동기부여', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Binggrae',
                    fontWeight: FontWeight.bold, fontSize: 14)),),
                  Tab(child: Text('투자에 대한\n생각', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Binggrae',
                    fontWeight: FontWeight.bold, fontSize: 14)),),
                  Tab(child: Text('공지사항', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Binggrae',
                    fontWeight: FontWeight.bold, fontSize: 14)),),
                ],
              ),
              // elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(color: Colors.black),
              actions: [
                PopupMenuButton(
                    onSelected: (selectedValue) {
                      if (selectedValue == '1') {
                        authController.firestoreUser.value != null ? authController.signOut() : Get.offAll(() => SignIn());
                      }
                    },
                    itemBuilder: (BuildContext ctx) => [
                      authController.firestoreUser.value != null ? PopupMenuItem(child: Text('로그아웃', style: TextStyle(fontFamily: 'Binggrae')), value: '1') : PopupMenuItem(child: Text('로그인'), value: '1'),
                    ])
              ],
            ),
            body: TabBarView(
              children: [
                HowToBeRichScreen(),
                MotivationScreen(),
                ThinkAboutRichScreen(),
                NoticeBoardScreen(),
              ],
            ),
            floatingActionButton: authController.firestoreUser.value != null && authController.firestoreUser.value!.role == 'admin' ? FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
              onPressed: () {
                Get.toNamed('add_notice');
              },
            ) : SizedBox(),
          ),
        ),
      ),
    );
  }

  _onBackPressed(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("종료하시겠습니까?",
            style: TextStyle(fontFamily: 'Binggrae', fontSize: 18)),
        actions: <Widget>[
          TextButton(
            child: Text(
              "확인",
              style: TextStyle(
                  fontFamily: 'Binggrae', fontSize: 18, color: Colors.redAccent),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          TextButton(
            child: Text(
              "취소",
              style: TextStyle(
                  fontFamily: 'Binggrae', fontSize: 18, color: Colors.grey),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
