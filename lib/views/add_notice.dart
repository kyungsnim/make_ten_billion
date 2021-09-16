import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/notification/notification_service.dart';
import 'package:make_ten_billion/widgets/widgets.dart';
import 'package:get/get.dart';

class AddNotice extends StatefulWidget {
  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice> {
  TextStyle style = TextStyle(fontFamily: 'SLEIGothic', fontSize: 20.0);
  NoticeController noticeController = NoticeController.to;
  AuthController authController = AuthController.to;
  String _title = '';
  String _description = '';
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing = false;

  var _croppedFile;
  var _category;
  final _categoryList = [
    '부자되는 방법',
    '부자 동기부여',
    '투자에 대한 생각',
    '공지사항'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = '';
    _description = '';

    noticeController.titleController.text = '';
    noticeController.descriptionController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return GetBuilder<NoticeController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("새 게시글 작성", style: TextStyle(color: Colors.black, fontFamily: 'Binggrae', fontSize: 26, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: _isLoading ? SizedBox() : InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
          ),
          key: _key,
          body: !_isLoading
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Form(
              key: _formKey,
              child: Container(
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    child: Text('카테고리',
                                        style: TextStyle(
                                            fontFamily: 'Binggrae', fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold))),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: DropdownButton(
                                    hint: Text('카테고리를 선택해주세요', style: TextStyle(
                                        fontFamily: 'Binggrae', fontSize: 18,)),
                                      value: _category,
                                      icon: Icon(Icons.arrow_downward),
                                      underline: Container(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      items: _categoryList.map((value) {
                                        return DropdownMenuItem(
                                          value: value,
                                          child: Text("$value",
                                              style: TextStyle(
                                                fontFamily: 'Binggrae', fontSize: 18,)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _category = value;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    child: Text('제목',
                                        style: TextStyle(
                                            fontFamily: 'Binggrae', fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold))),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 1,
                            height:
                            MediaQuery.of(context).size.height * 0.08,
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.symmetric(
                                        horizontal: BorderSide(
                                            color: Colors.black54,
                                            width: 0.5))),
                                width:
                                MediaQuery.of(context).size.width * 1,
                                height:
                                MediaQuery.of(context).size.height *
                                    1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  // expands: true,
                                  controller:
                                  noticeController.titleController,
                                  cursorColor: Colors.black,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return '제목을 입력하세요';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '제목 입력',
                                      hintStyle: TextStyle(
                                          fontFamily: 'Binggrae', fontSize: 18,),),
                                  onChanged: (val) {
                                    _title = val;
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    child: Text('내용',
                                        style: TextStyle(
                                            fontFamily: 'Binggrae',
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold))),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 1,
                            height:
                            MediaQuery.of(context).size.height * 0.2,
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.symmetric(
                                        horizontal: BorderSide(
                                            color: Colors.black54,
                                            width: 0.5))),
                                width:
                                MediaQuery.of(context).size.width * 1,
                                height:
                                MediaQuery.of(context).size.height *
                                    1,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  // expands: true,
                                  controller: noticeController
                                      .descriptionController,
                                  cursorColor: Colors.black,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return '내용을 입력하세요';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '내용 입력',
                                      hintStyle: TextStyle(
                                          fontFamily: 'Binggrae', fontSize: 18,),),
                                  onChanged: (val) {
                                    // noticeController.setDescription();
                                    _description = noticeController
                                        .descriptionController.text;
                                    // setState(() {
                                    //   _content = val;
                                    // });
                                  },
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    _category != '공지사항' ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text('사진 등록',
                                        style: TextStyle(
                                            fontFamily: 'Binggrae', fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold))),
                              ],
                            ),
                          ],
                        )) : SizedBox(),
                    _category != '공지사항' ? _croppedFile == null ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey, // background
                          onPrimary: Colors.white, // foreground
                        ),child: Text('사진 선택', style: TextStyle(
                        fontFamily: 'Binggrae', fontSize: 18,
                        fontWeight:
                        FontWeight.bold)), onPressed: () {
                      selectGalleryImage();
                    },) : InkWell(
                      onTap: () {
                        selectGalleryImage();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 1,
                        height:
                        MediaQuery.of(context).size.height * 0.3,
                        child: Image.file(
                          _croppedFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ) : SizedBox(),
                    FormVerticalSpace(),
                    _isLoading ? Center(child: LoadingIndicator(
                                indicatorType: Indicator.ballSpinFadeLoader,
                                colors: [Colors.black],
                              )) : PrimaryButton(
                      labelText: '게시글 등록',
                      buttonColor: Colors.redAccent,
                      onPressed: () {
                        uploadImageToFirebase(context, _croppedFile);
                      },
                    ),
                    FormVerticalSpace(),
                  ],
                ),
              ),
            ),
          )
              : Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  child: CircularProgressIndicator())),
        );
      });
    });
  }

  selectGalleryImage() {
    ImageController.instance.cropImageFromFile().then((croppedFile) {
      if (croppedFile != null) {
        // setState(() { messageType = 'image'; });
        setState(() {
          _croppedFile = croppedFile;
        });
      }else {
        Get.snackbar('사진 선택', '사진 선택을 취소하였습니다.',backgroundColor: Colors.redAccent.withOpacity(0.8), colorText: Colors.white);
      }
    });
  }

  Future uploadImageToFirebase(BuildContext context, croppedFile) async {
    var todayMonth = DateTime.now().month < 10
        ? '0' + DateTime.now().month.toString()
        : DateTime.now().month;
    var todayDay = DateTime.now().day < 10
        ? '0' + DateTime.now().day.toString()
        : DateTime.now().day;
    var todayHour = DateTime.now().hour < 10
        ? '0' + DateTime.now().hour.toString()
        : DateTime.now().hour;
    var todayMinute = DateTime.now().minute < 10
        ? '0' + DateTime.now().minute.toString()
        : DateTime.now().minute;
    var todaySecond = DateTime.now().second < 10
        ? '0' + DateTime.now().second.toString()
        : DateTime.now().second;

    if(croppedFile != null) {
      try {
        // upload file 제목
        String fileName = 'image_${DateTime
            .now()
            .year}$todayMonth$todayDay$todayHour$todayMinute$todaySecond';
        // upload 위치 지정
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child(
            'uploads/${authController.firestoreUser.value!.email}/$fileName');
        // upload 시작
        UploadTask uploadTask = firebaseStorageRef.putFile(croppedFile);

        setState(() {
          _isLoading = true;
        });
        // upload 중 state 체크
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {

        }, onError: (Object e) {
          print(e); // FirebaseException
        });

        // upload 완료된 경우 url 경로 저장해두기
        uploadTask.then((TaskSnapshot taskSnapshot) {
          taskSnapshot.ref.getDownloadURL().then((value) {
            noticeController.imgUrl = value;

            // 게시글 업로드 (url 경로를 얻은 후에 업로드 해야 함)
            uploadNotice();
          });
        });
      } catch (e) {
        print(e);
      }
    } else {
      uploadNotice(addImage: false);
    }
  }

  uploadNotice({addImage: true}) async {
    var id = DateTime.now()
        .millisecondsSinceEpoch
        .toString();

    Map<String, dynamic> noticeData = {
      'id': id,
      'title': _title,
      'description': _description,
      'writer':
      authController.firestoreUser.value!.email,
      'imgUrl': addImage && _category != '공지사항' ? noticeController.imgUrl : '',
      'read': 0,
      'like': 0,
      'createdAt': DateTime.now()
    };

    setState(() {
      _isLoading = false;
    });

    switch(_category) {
      case '부자되는 방법':
      noticeController.addHowToBeRichNotice(id, noticeData);
        NotificationService().sendMessage(_title, id).then((value) {
          print(value);
        });
      break;
      case '부자 동기부여':
        noticeController.addMotivationNotice(id, noticeData);
        break;
      case '투자에 대한 생각':
        noticeController.addThinkAboutRichNotice(id, noticeData);
        break;
      case '공지사항':
        noticeController.addNoticeBoard(id, noticeData);
        break;
    }
    Get.back();
    Get.snackbar('게시글 작성', '작성이 완료되었습니다.',backgroundColor: Colors.redAccent.withOpacity(0.8), colorText: Colors.white);
  }
}