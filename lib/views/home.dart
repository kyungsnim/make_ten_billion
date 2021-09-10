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
      WillPopScope(
        onWillPop: () => _onBackPressed(context),
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text('매일 읽는 100억 부자 되기 습관', style: TextStyle(color: Colors.black),),
              bottom: TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                physics: NeverScrollableScrollPhysics(),
                tabs: [
                  Tab(child: Text('부자되는\n방법', textAlign: TextAlign.center,), ),
                  Tab(child: Text('부자\n동기부여', textAlign: TextAlign.center,),),
                  Tab(child: Text('투자에 대한\n생각', textAlign: TextAlign.center,),),
                  Tab(child: Text('공지사항', textAlign: TextAlign.center,),),
                ],
              ),
              // elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.white,
              actionsIconTheme: IconThemeData(color: Colors.black),
              actions: [
                PopupMenuButton(
                    onSelected: (selectedValue) {
                      if (selectedValue == '1') {
                        authController.firestoreUser.value != null ? authController.signOut() : Get.offAll(() => SignIn());
                      }
                    },
                    itemBuilder: (BuildContext ctx) => [
                      authController.firestoreUser.value != null ? PopupMenuItem(child: Text('로그아웃'), value: '1') : PopupMenuItem(child: Text('로그인'), value: '1'),
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
            floatingActionButton: authController.firestoreUser.value != null && authController.firestoreUser.value!.role == 'admin' ? FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.redAccent,
              onPressed: () {
                Get.toNamed('add_notice');
              },
            ) : SizedBox(),
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
