import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'constants/app_routes.dart';
import 'controller/controllers.dart';

final String androidBannerId = 'ca-app-pub-2486335313636346/9631263349';
final String androidInterstitialId = 'ca-app-pub-2486335313636346/2479531634';
final String iOSBannerId = 'ca-app-pub-2486335313636346/1698230176';
final String iOSInterstitialId = 'ca-app-pub-2486335313636346/6227204951';

final String androidTestId = 'ca-app-pub-3940256099942544/6300978111';
final String iOSTestId = 'ca-app-pub-3940256099942544/2934735716';
final String iOSInterstitialTestId = 'ca-app-pub-3940256099942544/4411468910';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  // Get.put<ThemeController>(ThemeController());
  // Get.put<LanguageController>(LanguageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /// 테마 셋팅 : 기본적으로 시스템테마를 적용하나 임의로 테마변경을 한 경우 그 데이터로 테마적용
    getCurrentTheme();

    return GetMaterialApp(
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
    );
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
