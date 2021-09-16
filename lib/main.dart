import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_routes.dart';
import 'controller/controllers.dart';
import 'notification/notification_bloc.dart';

final String androidBannerId = 'ca-app-pub-2486335313636346/9631263349';
final String androidInterstitialId = 'ca-app-pub-2486335313636346/2479531634';
final String iOSBannerId = 'ca-app-pub-2486335313636346/1698230176';
final String iOSInterstitialId = 'ca-app-pub-2486335313636346/6227204951';

final String androidTestId = 'ca-app-pub-3940256099942544/6300978111';
final String iOSTestId = 'ca-app-pub-3940256099942544/2934735716';
final String iOSInterstitialTestId = 'ca-app-pub-3940256099942544/4411468910';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  KakaoContext.clientId = 'b6cb50231a2306a68657a2a6e07a13b';

  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox('notifications');

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    /// with WidgetsBindingObserver 과 함께 foreground 동적링크를 위한 추가
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    /// with WidgetsBindingObserver 과 함께 foreground 동적링크를 위한 추가
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// 테마 셋팅 : 기본적으로 시스템테마를 적용하나 임의로 테마변경을 한 경우 그 데이터로 테마적용
    getCurrentTheme();

    return MultiProvider(
        providers: [
        ChangeNotifierProvider<NotificationBloc>(create: (context) => NotificationBloc()),
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
        Get.put(NoticeController());
        // Get.put(NotificationController());
      }),
      title: '매일 부자 습관',
      theme: ThemeData.dark(),
      initialRoute: "/home",
      getPages: AppRoutes.routes,
    ));
  }
}

getCurrentTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('theme') == 'Dark') {
    Get.changeTheme(ThemeData.dark());
  } else {
    Get.changeTheme(ThemeData.light());
  }
}
