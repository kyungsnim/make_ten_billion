import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/models/models.dart';
import 'package:make_ten_billion/views/views.dart';
import 'package:make_ten_billion/widgets/widgets.dart';
import 'package:get/get.dart';

class UpdateNotice extends StatefulWidget {
  NoticeModel detailNotice;
  String collectionName;

  UpdateNotice(this.detailNotice, this.collectionName);

  @override
  _UpdateNoticeState createState() => _UpdateNoticeState();
}

class _UpdateNoticeState extends State<UpdateNotice> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = '';
    _description = '';

    if(widget.detailNotice != null) {
      noticeController.titleController.text = widget.detailNotice.title;
      noticeController.descriptionController.text = widget.detailNotice.description;
      _title = widget.detailNotice.title;
      _description = widget.detailNotice.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return GetBuilder<NoticeController>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("게시글 수정", style: TextStyle(fontFamily: 'Binggrae', fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0,
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
                                  style: TextStyle(
                                    fontFamily: 'Binggrae', fontSize: 18,),
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
                                      fontFamily: 'Binggrae', fontSize: 18,
                                      fontWeight:
                                      FontWeight.bold)),
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
                                    style: TextStyle(
                                        fontFamily: 'Binggrae', fontSize: 18,),
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
                                      fontFamily: 'Binggrae', fontSize: 18,
                                      fontWeight:
                                      FontWeight.bold)),
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
                    noticeController.imgUrl != '' ? Padding(
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
                    widget.detailNotice != null && widget.detailNotice.imgUrl != '' ?
                        CachedNetworkImage(
                          imageUrl: widget.detailNotice.imgUrl,
                        ) :
                    _croppedFile == null ? noticeController.imgUrl != '' ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey, // background
                          onPrimary: Colors.white, // foreground
                        ),child: Text('사진 선택', style: TextStyle(
                        fontFamily: 'Binggrae', fontSize: 18,
                        fontWeight:
                        FontWeight.bold)), onPressed: () {
                      selectGalleryImage();
                    },) : SizedBox() : InkWell(
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
                    ),
                    FormVerticalSpace(),
                    _isLoading ? Center(child: LoadingIndicator(
                                indicatorType: Indicator.ballSpinFadeLoader,
                                colors: [Colors.black],
                              )) : PrimaryButton(
                      labelText: '게시글 수정',
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

  uploadNotice({addImage: true}) {
    var id = DateTime.now()
        .millisecondsSinceEpoch
        .toString();

    Map<String, dynamic> noticeData = {
      'id': widget.detailNotice != null ? widget.detailNotice.id : id,
      'title': _title,
      'description': _description,
      'writer':
      authController.firestoreUser.value!.email,
      'imgUrl': addImage ? noticeController.imgUrl : widget.detailNotice.imgUrl,
      'read': widget.detailNotice.read,
      'like': widget.detailNotice.like,
      'likeList': widget.detailNotice.likeList,
      'createdAt': widget.detailNotice.createdAt,
    };

    setState(() {
      _isLoading = false;
    });

    switch(widget.collectionName) {
      case 'HowToBeRich':
        noticeController.updateHowToBeRichNotice(widget.detailNotice.id, noticeData);
        break;
      case 'Motivation':
        noticeController.updateMotivationNotice(widget.detailNotice.id, noticeData);
        break;
      case 'ThinkAboutRich':
        noticeController.updateThinkAboutRichNotice(widget.detailNotice.id, noticeData);
        break;
      case 'NoticeBoard':
        noticeController.updateNoticeBoard(widget.detailNotice.id, noticeData);
        break;
    }

    Get.offAll(() => Home());
    Get.snackbar('게시글 수정', '수정이 완료되었습니다.',backgroundColor: Colors.redAccent.withOpacity(0.8), colorText: Colors.white);
  }
}