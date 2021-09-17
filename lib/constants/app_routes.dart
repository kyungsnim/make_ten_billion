import 'package:make_ten_billion/models/notice_model.dart';
import 'package:make_ten_billion/views/sign_up.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/views/views.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => Home(0)),
    GetPage(name: '/signin', page: () => SignIn()),
    GetPage(name: '/signup', page: () => SignUp()),
    GetPage(name: '/notice', page: () => HowToBeRichScreen()),
    GetPage(name: '/add_notice', page: () => AddNotice(),),
    GetPage(name: '/update_notice', page: () => UpdateNotice(detailNotice, collectionName),),
    GetPage(name: '/how_to_be_rich_screen', page: () => HowToBeRichScreen()),
    GetPage(name: '/how_to_be_rich_detail', page: () => HowToBeRichDetail(detailNotice)),
    GetPage(name: '/motivation_screen', page: () => MotivationScreen()),
    GetPage(name: '/think_about_rich_screen', page: () => ThinkAboutRichScreen()),
    GetPage(name: '/setting_screen', page: () => SettingScreen()),
    GetPage(name: '/think_about_rich_screen', page: () => ThinkAboutRichScreen()),
  ];

  static get detailNotice => null;
  static get collectionName => null;

  static int? get index => null;
}