import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/models/models.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/views/views.dart';

class HowToBeRichScreen extends StatefulWidget {
  @override
  _HowToBeRichScreenState createState() => _HowToBeRichScreenState();
}

class _HowToBeRichScreenState extends State<HowToBeRichScreen> {
  var _lastRow = 0;
  final FETCH_ROW = 5;
  var stream;
  var randomGenerator = Random();
  var weekDayList = ['일', '월', '화', '수', '목', '금', '토', '일'];

  ScrollController _scrollController = new ScrollController();
  var noticeDbRef = FirebaseFirestore.instance.collection('HowToBeRich');
  final authController = AuthController.to;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  var bannerId;

  @override
  void initState() {
    super.initState();

    stream = newStream();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          mounted) {
        setState(() {
          stream = newStream();
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> newStream() {
    return noticeDbRef
        .orderBy("createdAt", descending: true)
        .limit(FETCH_ROW * (_lastRow + 1))
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(builder: (_) {
      return GetBuilder<AuthController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      _buildBody(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  Widget _buildBody(BuildContext context) {
    // print("warning");
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data!.docs);
        });
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.length,
        itemBuilder: (context, i) {
          // print("i : " + i.toString());
          final currentRow = (i + 1) ~/ FETCH_ROW;
          if (_lastRow != currentRow) {
            _lastRow = currentRow;
          }
          print("lastrow : " + _lastRow.toString());
          return _buildListItem(context, snapshot[i]);
        });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    NoticeModel notice = NoticeModel.fromSnapshot(data);
    return Padding(
      key: ValueKey(notice.id),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0), blurRadius: 5, color: Colors.white10)
          ],
        ),
        child: GestureDetector(
          onTap: () {
            addViewCount(notice);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HowToBeRichDetail(notice)));
          },
          child: _listItem(notice),
        ),
      ),
    );
  }

  _listItem(notice) {
    return ListTile(
      title: Container(
        width: Get.width,
        margin: EdgeInsets.symmetric(vertical: 10),
        // height: 200,
        child: notice.title != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width * 0.25,
                    height: Get.width * 0.25,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.black54)
                    ]),
                    child: notice.imgUrl == ''
                        ? Placeholder()
                        : CachedNetworkImage(
                            imageUrl: notice.imgUrl, fit: BoxFit.fill),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: Get.width * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notice.title.length > 20
                                ? notice.title.toString().substring(0, 18) +
                                    '...'
                                : notice.title,
                            softWrap: true,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          /// 조회수
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '${notice.like.toString()}',
                                  softWrap: true,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '${notice.read.toString()}',
                                  softWrap: true,
                                ),
                                Spacer(),
                                Icon(
                                  Icons.comment_rounded,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '${notice.read.toString()}',
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(),
      ),
    );
  }

  void addViewCount(notice) {
    // 조회수 1 증가
    FirebaseFirestore.instance
        .collection('HowToBeRich')
        .doc(notice.id)
        .update(({'read': notice.read + 1}));
    setState(() {
      notice.read++;
    });
  }
}
