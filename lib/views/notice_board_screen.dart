import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/models/models.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/views/views.dart';

import '../main.dart';

class NoticeBoardScreen extends StatefulWidget {
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> with AutomaticKeepAliveClientMixin<NoticeBoardScreen> {
  var _lastRow = 0;
  final FETCH_ROW = 5;
  var stream;
  var randomGenerator = Random();
  var weekDayList = ['일', '월', '화', '수', '목', '금', '토', '일'];

  ScrollController _scrollController = new ScrollController();
  var noticeDbRef = FirebaseFirestore.instance.collection('NoticeBoard');
  final authController = AuthController.to;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  var bannerId;

  BannerAd? banner;
  InterstitialAd? interstitial;

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // final FlutterNotifications _notifications = Notifications();
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
    if(banner != null) {
      banner!.dispose();
    }
    if(interstitial != null) {
      interstitial!.dispose();
    }
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

    if(authController.firestoreUser.value == null || (authController.firestoreUser.value != null && authController.firestoreUser.value!.role != 'admin')) {
      banner = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isIOS ? iOSBannerId : androidBannerId, //iOSTestId : androidTestId,
        listener: BannerAdListener(),
        request: AdRequest(),
      )
        ..load();

      InterstitialAd.load(
          adUnitId: iOSInterstitialId, //iOSInterstitialTestId,
          request: AdRequest(),
          adLoadCallback: InterstitialAdLoadCallback(
            onAdLoaded: (InterstitialAd ad) {
              // Keep a reference to the ad so you can show it later.
              this.interstitial = ad;

              if (DateTime
                  .now()
                  .second % 5 == 0) {
                interstitial!.show();
              }
            },
            onAdFailedToLoad: (LoadAdError error) {
              print('InterstitialAd failed to load: $error');
            },
          ));
    }

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
                      // TextButton(
                      //   onPressed: () {
                      //     _firebaseMessaging.sendMessage(to: tmpToken, data: {
                      //       'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                      //       'id': '1',
                      //       'status': 'done'
                      //     }, );
                      //   },
                      //   child: Text('Send Message'),
                      // ),
                      authController.firestoreUser.value == null || (authController.firestoreUser.value != null && authController.firestoreUser.value!.role != 'admin') ?
                      Container(
                        height: 50.0,
                        child: AdWidget(
                          ad: banner!,
                        ),
                      )
                          : SizedBox(),
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
                    builder: (context) => NoticeBoardDetail(notice)));
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
        margin: EdgeInsets.symmetric(vertical: 5),
        // height: 200,
        child: notice.title != null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   width: Get.width * 0.25,
                  //   height: Get.width * 0.25,
                  //   decoration: BoxDecoration(boxShadow: [
                  //     BoxShadow(blurRadius: 5, color: Colors.black54)
                  //   ]),
                  //   child: notice.imgUrl == ''
                  //       ? Placeholder()
                  //       : CachedNetworkImage(
                  //           imageUrl: notice.imgUrl, fit: BoxFit.fill),
                  // ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  Expanded(
                    child: Container(
                      height: Get.width * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                notice.title.length > 20
                                    ? notice.title.toString().substring(0, 18) +
                                        '...'
                                    : notice.title,
                                softWrap: true,
                                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Binggrae', fontSize: 18,),
                              ),
                              Spacer(),
                            ],
                          ),

                          /// 조회수
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              children: [
                                Text(
                                  notice.createdAt.toString().substring(0, 16),
                                  softWrap: true,
                                  style: TextStyle(fontFamily: 'Binggrae', fontSize: 18),
                                ),
                                // SizedBox(width: 3),
                                Spacer(),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '${notice.like.toString()}',
                                  softWrap: true,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Binggrae', fontSize: 16,),
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
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Binggrae', fontSize: 16,),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.share,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 3),
                                Text(
                                  '${notice.share.toString()}',
                                  softWrap: true,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Binggrae', fontSize: 16,),
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
        .collection('NoticeBoard')
        .doc(notice.id)
        .update(({'read': notice.read + 1}));
    setState(() {
      notice.read++;
    });
  }

  @override
  bool get wantKeepAlive => true;

  // String? tmpToken;
  // void getToken() async {
  //   _firebaseMessaging.getToken().then((value) {
  //     print('>>>> token: $value');
  //     tmpToken = value;
  //     // sendAndRetrieveMessage(value!);
  //   });
  // }
  //
  // final String serverToken = 'AAAAxoH4z9Q:APA91bGY_5STcywZSPqKI7jfjtKnXnDHT6_uCSDqQe17UGRM8iD1WJQYZGQyJVLX2TiTJ_drXGRBM-BabcM_RqbrhHrtaMQwMMW_LIHmB6_HjdqMAIHsFzsA9706yUi8okSeNES34koy';
  // Future<Map<String, dynamic>> sendAndRetrieveMessage(String token) async {
  //   await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       'Authorization': 'key=$serverToken',
  //     },
  //     body: jsonEncode(
  //       <String, dynamic>{
  //         'notification': <String, dynamic>{
  //           'body': 'hello_world',
  //           'title': 'FlutterCloudMessage'
  //         },
  //         'priority': 'high',
  //         'data': <String, dynamic>{
  //           'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //           'id': '1',
  //           'status': 'done'
  //         },
  //         'to': token,
  //       }
  //     )
  //   );
  //
  //   final Completer<Map<String, dynamic>> completer = Completer<Map<String, dynamic>>();
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print('Message data: ${message.data}');
  //     completer.complete(message.data);
  //   });
  //   return completer.future;
  // }
}
