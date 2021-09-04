import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:make_ten_billion/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'views.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authController = AuthController.to;

    return GetBuilder<AuthController>(
      builder: (_) =>
      authController.firebaseUser.value == null
          ? Center(child: CircularProgressIndicator())
          :
      WillPopScope(
        onWillPop: () => _onBackPressed(context),
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('매일 읽는 100억 부자 되기 습관', style: TextStyle(color: Colors.black),),
              bottom: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: '부자되는 방법', ),
                  Tab(text: '부자 동기부여',),
                  Tab(text: '투자에 대한 생각',),
                ],
              ),
              // elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: TabBarView(
              children: [
                HowToBeRichScreen(),
                MotivationScreen(),
                ThinkAboutRichScreen(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
              onPressed: () {
                Get.toNamed('add_notice');
              },
            ),
          ),
        ),
      ),
    );
  }

  // back 버튼 클릭시 종료할건지 물어보는
  _onBackPressed(context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("종료하시겠습니까?",
            style: TextStyle(fontFamily: 'Nanum', fontSize: 18)),
        actions: <Widget>[
          TextButton(
            child: Text(
              "확인",
              style: TextStyle(
                  fontFamily: 'Nanum', fontSize: 18, color: Colors.redAccent),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          TextButton(
            child: Text(
              "취소",
              style: TextStyle(
                  fontFamily: 'Nanum', fontSize: 18, color: Colors.grey),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
  }
}
