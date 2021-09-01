import 'package:flutter/material.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/widgets/widgets.dart';
import 'package:get/get.dart';

class AddNotice extends StatelessWidget {
  TextStyle style = TextStyle(fontFamily: 'SLEIGothic', fontSize: 20.0);
  NoticeController noticeController = NoticeController.to;
  AuthController authController = AuthController.to;
  String _title = '';
  String _description = '';
  var _isLoading = false;
  DateTime _createdAt = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    _title = '';
    _description = '';

    noticeController.titleController.text = '';
    noticeController.descriptionController.text = '';

    return GetBuilder<AuthController>(builder: (_) {
      return GetBuilder<NoticeController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("새 글 작성"),
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
                                                  fontFamily: 'SLEIGothic',
                                                  color: Colors.lightBlue,
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
                                                fontFamily: 'SLEIGothic',
                                                fontSize: 15)),
                                        onChanged: (val) {
                                          _title = val;
                                          // update();
                                          // setState(() {
                                          //   _title = val;
                                          // });
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
                                                  fontFamily: 'SLEIGothic',
                                                  color: Colors.lightBlue,
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
                                      MediaQuery.of(context).size.height * 0.15,
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
                                                fontFamily: 'SLEIGothic',
                                                fontSize: 15)),
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
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text('작성일',
                                              style: TextStyle(
                                                  fontFamily: 'SLEIGothic',
                                                  color: Colors.lightBlue,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                  ),
                                ],
                              )),
                          FormVerticalSpace(),
                          PrimaryButton(
                            labelText: '완료',
                            onPressed: () {
                              var id = DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString();

                              Map<String, dynamic> noticeData = {
                                'id': id,
                                'title': _title,
                                'description': _description,
                                'writer':
                                    authController.firestoreUser.value!.email,
                                'imgUrl': '',
                                'read': 0,
                                'like': 0,
                                'createdAt': DateTime.now()
                              };

                              noticeController.addNotice(id, noticeData);
                              Get.back();
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

  // Future<void> deleteImage(String imageFileUrl) async {
  //   var fileUrl =
  //       Uri.decodeFull(imageFileUrl.replaceAll(new RegExp(r'(\?alt).*'), ''));
  //   final Reference firebaseStorageRef =
  //       FirebaseStorage.instance.ref().child(fileUrl);
  //   await firebaseStorageRef.delete();
  // }

  // Future uploadImageToFirebase(BuildContext context) async {
  //   try {
  //     // 업로드된 일기의 사진을 변경할 때만 해당 로직 태우기
  //     if (_imageChanged) {
  //       var todayMonth = _createdAt.month < 10
  //           ? '0' + _createdAt.month.toString()
  //           : _createdAt.month;
  //       var todayDay = _createdAt.day < 10
  //           ? '0' + _createdAt.day.toString()
  //           : _createdAt.day;
  //
  //       // upload file 제목
  //       String fileName = 'image_${_createdAt.year}$todayMonth$todayDay';
  //       // upload 위치 지정
  //       Reference firebaseStorageRef = FirebaseStorage.instance
  //           .ref()
  //           .child('uploads/${currentUser.id}/$fileName');
  //       // upload 시작
  //       UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
  //
  //       // upload 중 state 체크
  //       uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
  //         print(
  //             'Snapshot state: ${snapshot.state}'); // paused, running, complete
  //         // print('Progress: ${snapshot.totalBytes / snapshot.bytesTransferred}');
  //       }, onError: (Object e) {
  //         print(e); // FirebaseException
  //       });
  //
  //       // upload 완료된 경우 url 경로 저장해두기
  //       uploadTask.then((TaskSnapshot taskSnapshot) {
  //         taskSnapshot.ref.getDownloadURL().then((value) {
  //           setState(() {
  //             _imageUrl = value;
  //           });
  //           // 다이어리 업로드 (url 경로를 얻은 후에 업로드 해야 함)
  //           _createdAt.weekday > 0 && _createdAt.weekday < 6
  //               ? uploadDiary()
  //               : weekendUploadDiary();
  //           // uploadDiary();
  //         });
  //       });
  //     } else {
  //       // 사진 변경 없는 수정일 경우 바로 uploadDiary
  //       _createdAt.weekday > 0 && _createdAt.weekday < 6
  //           ? uploadDiary()
  //           : weekendUploadDiary();
  //       // uploadDiary();
  //     }
  //   } catch(e) {
  //     print(e);
  //   }
  // }
  //
  // Future getCameraImage() async {
  //   final pickedFile = await ImagePicker.pickImage(
  //       source: ImageSource.camera, imageQuality: 20);
  //
  //   setState(() {
  //     _imageFile = File(pickedFile.path);
  //   });
  // }
  //
  // Future getGalleryImage() async {
  //   ImagePicker imagePicker = ImagePicker();
  //   final pickedFile = await imagePicker.getImage(
  //       source: ImageSource.gallery, imageQuality: 20);
  //
  //   setState(() {
  //     _imageFile = File(pickedFile.path);
  //     if (_imageUrl != null && _imageUrl != "" && _imageFile != null) {
  //       // 업로드된 이미지가 있었는데 변경하게 되는 경
  //       _imageChanged = true;
  //     } else if (_imageFile != null) {
  //       _imageChanged = true;
  //     }
  //   });
  // }
  //
  // weekendUploadDiary() {
  //   // batch 생성
  //   WriteBatch writeBatch = FirebaseFirestore.instance.batch();
  //
  //   var id = DateTime.now().microsecondsSinceEpoch.toString();
  //   // widget.diary => 기존에 작성한 일기를 수정하려는 경우 widget.diary 값이 존재할 것이다.
  //   writeBatch.set(
  //       userReference
  //           .doc(currentUser.id)
  //           .collection('diarys')
  //           .doc(widget.diary != null ? widget.diary.id : id),
  //       {
  //         "id": widget.diary != null ? widget.diary.id : id,
  //         "profileUrl": currentUser.url != ""
  //             ? currentUser.url
  //             : "",
  //         "babyCreatedAt": currentUser.babyCreatedAt != null ? currentUser.babyCreatedAt : 1950,
  //         "userName":
  //             currentUser.userName != null ? currentUser.userName : "name",
  //         "title": _title,
  //         "content": _content,
  //         "imageUrl": _imageUrl != null && _imageUrl != "" ? _imageUrl : "",
  //         "summitDate": _createdAt,
  //         "createdAt": DateTime.now(),
  //         "isCompleteToFeed":
  //             widget.diary != null ? widget.diary.isCompleteToFeed : false,
  //       });
  //
  //   if (widget.diary != null) {
  //     if (widget.diary.isCompleteToFeed)
  //       // Feed 게시글 생성
  //       writeBatch.update(
  //           FirebaseFirestore.instance.collection('feed').doc(widget.diary.id),
  //           {
  //             'firstAnswer': _firstAnswer,
  //             'imageUrl': _imageUrl != null ? _imageUrl : "",
  //             'updatedAt': DateTime.now()
  //           });
  //   }
  //
  //   // batch end
  //   writeBatch.commit();
  //
  //   showToast("일기 작성 완료");
  // }

  checkFeedPopup(context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('날짜 확인',
                style: TextStyle(
                    fontFamily: 'SLEIGothic', color: Colors.lightBlue)),
            content: Text(
                "${_createdAt.toString().substring(0, 10)} 이 맞습니까?\n확인을 누르시면 일기 작성이 완료됩니다.",
                style:
                    TextStyle(fontFamily: 'SLEIGothic', color: Colors.black54)),
            actions: [
              TextButton(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text('확인',
                      style: TextStyle(
                          fontFamily: 'SLEIGothic',
                          color: Colors.lightBlue,
                          fontSize: 20)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // setState(() {
                    //   processing = true;
                    // });
                    // processing = true;

                    // uploadImageToFirebase(context);

                    Get.offAllNamed('/notice');
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => MainPage(1)));
                    // processing = false;
                    // setState(() {
                    //   processing = false;
                    // });
                  }
                },
              ),
              TextButton(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text('취소',
                      style: TextStyle(
                          fontFamily: 'SLEIGothic',
                          color: Colors.grey,
                          fontSize: 20)),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  alertNotCheckFuturePopup(context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('날짜 확인',
                style:
                    TextStyle(fontFamily: 'SLEIGothic', color: Colors.black)),
            content: Text("미래의 날짜는 선택할 수 없습니다.",
                style:
                    TextStyle(fontFamily: 'SLEIGothic', color: Colors.black54)),
            actions: [
              TextButton(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text('닫기',
                      style: TextStyle(
                          fontFamily: 'SLEIGothic',
                          color: Colors.grey,
                          fontSize: 20)),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
//
// @override
// void dispose() {
//   _titleController.dispose();
//   super.dispose();
// }
//
// showToast(String msg, {int duration, int gravity}) {
//   Toast.show(msg, context, duration: duration, gravity: gravity);
// }
}
