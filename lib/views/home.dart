import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_ten_billion/controller/auth_controller.dart';
import 'package:provider/src/provider.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/models/models.dart';
import 'package:make_ten_billion/notification/notification_bloc.dart';
import 'package:make_ten_billion/notification/notification_service.dart';
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

    NotificationService().getToken().then((value) {
      print('토큰값');
      print(value);
    });

    /// with WidgetsBindingObserver 과 함께 foreground 동적링크를 위한 추가
    WidgetsBinding.instance!.addObserver(this);

    initDynamicLinks();

    Future.delayed(Duration(milliseconds: 0)).then((_){
      NotificationService().initFirebasePushNotification(context)
          .then((_) => context.read<NotificationBloc>().checkSubscription())
          .then((_){
      });
    }).then((_){
    });

  }

  @override
  void dispose() {
    super.dispose();

    /// with WidgetsBindingObserver 과 함께 foreground 동적링크를 위한 추가
    WidgetsBinding.instance!.removeObserver(this);
  }

  void initDynamicLinks() async {
    /// 동적링크 확인
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    /// 딥링크가 있는 경우 체크 (딥링크는 단순히 앱만 실행하는 것이 아닌 특정 게시물로의 이동이 필요한 경우 사용)
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      /// 딥링크가 있는 경우 URL을 분석해서 어느 게시물로 이동할지 알아내야 함
      handleDynamicLink(deepLink);
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        handleDynamicLink(deepLink);
      }
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });
  }

  handleDynamicLink(Uri url) {
    /// 나의 경우 동적링크(+딥링크) 형식을 xxx.page.link/게시판이름/게시글ID 형태로 만들어 두었다.
    /// 때문에 separatedString[1] 에는 어떤 게시판으로 이동할지
    /// separatedString[2] 에는 어떤 게시글인지의 정보가 담겨져 있다.

    List<String> separatedString = [];
    separatedString.addAll(url.path.split('/'));

    /// ex) https://maketenbillion.page.link/HowToBeRichDetail/167812785917
    /// separatedString[0] => https://maketenbillion.page.link (동적링크 URL Prefix)
    /// separatedString[1] => HowToBeRichDetail (게시판 종류)
    /// separatedString[2] => 167812785917 (게시글 ID)

    Future.microtask(() async {
      Timer(Duration(milliseconds: 700), () async {
        /// 게시판 종류에 따라 분기처리
        switch (separatedString[1]) {
          case 'HowToBeRichDetail':
            /// 게시글 ID로 해당 문서를 조회한 후 해당 게시글로 이동
            FirebaseFirestore.instance
                .collection('HowToBeRich')
                .doc(separatedString[2])
                .get()
                .then((data) {
              NoticeModel detailNotice = NoticeModel.fromSnapshot(data);
              Get.to(() => HowToBeRichDetail(detailNotice));
            });
            break;
          case 'Motivation':
          /// 게시글 ID로 해당 문서를 조회한 후 해당 게시글로 이동
            FirebaseFirestore.instance
                .collection('Motivation')
                .doc(separatedString[2])
                .get()
                .then((data) {
              NoticeModel detailNotice = NoticeModel.fromSnapshot(data);
              Get.to(() => MotivationDetail(detailNotice));
            });
            break;
          case 'ThinkAboutRich':
          /// 게시글 ID로 해당 문서를 조회한 후 해당 게시글로 이동
            FirebaseFirestore.instance
                .collection('ThinkAboutRich')
                .doc(separatedString[2])
                .get()
                .then((data) {
              NoticeModel detailNotice = NoticeModel.fromSnapshot(data);
              Get.to(() => ThinkAboutRichDetail(detailNotice));
            });
            break;
        }
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      initDynamicLinks();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authController = AuthController.to;

    return GetBuilder<AuthController>(
      builder: (_) => WillPopScope(
        onWillPop: () => _onBackPressed(context),
        child: DefaultTabController(
          length: 4,
          initialIndex: currentIndex!,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '매일 읽는 100억 부자 되기 습관',
                style: TextStyle(
                    fontFamily: 'Binggrae',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 26),
              ),
              bottom: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                physics: NeverScrollableScrollPhysics(),
                tabs: [
                  Tab(
                    child: Text(
                      '부자되는\n방법',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Binggrae',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Tab(
                    child: Text('부자\n동기부여',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Binggrae',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                  Tab(
                    child: Text('투자에 대한\n생각',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Binggrae',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                  Tab(
                    child: Text('공지사항',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Binggrae',
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ),
                ],
              ),
              // elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(color: Colors.black),
              leading: InkWell(onTap: () {
                Get.to(() => NotificationScreen());
              },child: Icon(Icons.send, color: Colors.black,)),
              actions: [
                PopupMenuButton(
                    onSelected: (selectedValue) {
                      if (selectedValue == '1') {
                        authController.firestoreUser.value != null
                            ? authController.signOut()
                            : Get.offAll(() => SignIn());
                      }
                    },
                    itemBuilder: (BuildContext ctx) => [
                          authController.firestoreUser.value != null
                              ? PopupMenuItem(
                                  child: Text('로그아웃',
                                      style: TextStyle(fontFamily: 'Binggrae')),
                                  value: '1')
                              : PopupMenuItem(child: Text('로그인'), value: '1'),
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
            floatingActionButton:
            // FloatingActionButton(
            //   child: Icon(Icons.add),
            //   backgroundColor: Colors.blue,
            //   onPressed: () async {
            //     await NotificationService().sendMessage().then((value) {
            //       print(value);
            //     });
            //   },
            // )
            authController.firestoreUser.value != null &&
                    authController.firestoreUser.value!.role == 'admin'
                ? FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.redAccent,
                    onPressed: () {
                      Get.toNamed('add_notice');
                    },
                  )
                : SizedBox(),
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
                  fontFamily: 'Binggrae',
                  fontSize: 18,
                  color: Colors.redAccent),
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
