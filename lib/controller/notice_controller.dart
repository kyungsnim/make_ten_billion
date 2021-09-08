import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/models/models.dart';

class NoticeController extends GetxController {
  static NoticeController to = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String imgUrl = '';
  WriteBatch writeBatch = FirebaseFirestore.instance.batch();
  DateTime _createdAt = DateTime.now();
  DateTime picked = DateTime.now();
  Rxn<NoticeModel> notice = Rxn<NoticeModel>();
  var count = 0;
  var lastRow = 0;
  final FETCH_ROW = 5;
  var stream;
  ScrollController scrollController = new ScrollController();
  var noticeDbRef = FirebaseFirestore.instance.collection('HowToBeRich');

  bool isLoading = false;

  @override
  void onReady() async {
    //run every time auth state changes
    // await FlutterSecureStorage().deleteAll();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels ==
    //       scrollController.position.maxScrollExtent) {
    //     stream = newStream();
    //   }
    // });
    super.onReady();
  }

  Stream<QuerySnapshot> newStream() {
    return noticeDbRef
        .orderBy("createdAt", descending: true)
        .limit(FETCH_ROW * (lastRow + 1))
        .snapshots();
  }

  void addHowToBeRichNotice(String noticeId, Map<String, dynamic> noticeData) {
    FirebaseFirestore.instance.collection('HowToBeRich').doc(noticeId).set(noticeData);
    update();
  }

  void addMotivationNotice(String noticeId, Map<String, dynamic> noticeData) {
    FirebaseFirestore.instance.collection('Motivation').doc(noticeId).set(noticeData);
    update();
  }

  void addThinkAboutRichNotice(String noticeId, Map<String, dynamic> noticeData) {
    FirebaseFirestore.instance.collection('ThinkAboutRich').doc(noticeId).set(noticeData);
    update();
  }

  void updateHowToBeRichNotice(String noticeId, Map<String, dynamic> noticeData) {
    FirebaseFirestore.instance.collection('HowToBeRich').doc(noticeId).update(noticeData);
    update();
  }

  void updateMotivationNotice(String noticeId, Map<String, dynamic> noticeData) {
    FirebaseFirestore.instance.collection('Motivation').doc(noticeId).update(noticeData);
    update();
  }

  void updateThinkAboutRichNotice(String noticeId, Map<String, dynamic> noticeData) {
    FirebaseFirestore.instance.collection('ThinkAboutRich').doc(noticeId).update(noticeData);
    update();
  }

  // void addViewCount() {
  //   // 조회수 1 증가
  //   FirebaseFirestore.instance
  //       .collection('HowToBeRich')
  //       .doc(notice.value!.id)
  //       .update(({'read': notice.value!.read + 1}));
  //   notice.value!.read += 1;
  //   update();
  // }

  // void addLikeCount() {
  //   // 좋아요 1 증가
  //   FirebaseFirestore.instance
  //       .collection('HowToBeRich')
  //       .doc(notice.value!.id)
  //       .update(({'like': notice.value!.like + 1}));
  //   notice.value!.like += 1;
  //   update();
  // }

  void setCreatedAt(context) async {
    picked = (await showDatePicker(
      context: context,
      initialDate: _createdAt,
      firstDate: DateTime(_createdAt.year - 5),
      lastDate: DateTime(_createdAt.year + 5),
      builder:
          (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
            ColorScheme.light().copyWith(
              primary: Colors.lightBlue,
            ),
            buttonTheme: ButtonThemeData(
                textTheme:
                ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    )
    )!;
    update();
  }
}
