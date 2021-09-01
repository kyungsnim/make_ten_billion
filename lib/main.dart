import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_routes.dart';
import 'controller/controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
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
        // Get.put(AuthController());
        Get.put(ChatController());
        Get.put(NoticeController());
        Get.put(GeoController());
      }),
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}

getCurrentTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if(prefs.getString('theme') == 'Dark') {
    Get.changeTheme(ThemeData.dark());
  } else {
    Get.changeTheme(ThemeData.light());
  }
}
