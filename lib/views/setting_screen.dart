import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/notification/notification_service.dart';
import 'package:make_ten_billion/views/views.dart';
import 'package:make_ten_billion/widgets/primary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<bool> _selections = List.generate(1, (_) => false);

  bool _subscription = false;

  @override
  void initState() {
    getMySubscription();
    super.initState();
  }

  getMySubscription() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _selections[0] = sp.getBool('subscribed') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authController = AuthController.to;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('설정',
              style: TextStyle(fontFamily: 'Binggrae', fontSize: 26)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: Get.height,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    authController.firestoreUser.value != null ? Text(
                      '알림설정',
                      style: TextStyle(fontFamily: 'Binggrae', fontSize: 26),
                    ) : SizedBox(),
                    Spacer(),
                    authController.firestoreUser.value != null ? ToggleButtons(
                      children: [
                        _selections[0]
                            ? Icon(
                                Icons.notifications_active,
                                color: Colors.redAccent,
                              )
                            : Icon(
                                Icons.notifications_none,
                                color: Colors.grey,
                              )
                      ],
                      isSelected: _selections,
                      onPressed: (int index) async {
                        setState(() {
                          _selections[index] = !_selections[index];
                        });

                        if ((_selections[index])) {
                          /// true => turn on the notification
                          NotificationService().turnOnFcmSubscribtion();
                        } else {
                          /// false => turn off
                          NotificationService().turnOffFcmSubscribtion();
                        }
                      },
                      color: _selections[0] ? Colors.white : Colors.black12,
                      selectedColor: Colors.redAccent.withOpacity(0.6),
                      fillColor: Colors.white,
                    ) : SizedBox()
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              authController.firestoreUser.value != null
                  ? PrimaryButton(
                      labelText: '로그아웃',
                      buttonColor: Colors.redAccent,
                      onPressed: () {
                        authController.signOut();
                      })
                  : PrimaryButton(
                      labelText: '로그인',
                      buttonColor: Colors.green,
                      onPressed: () {
                        Get.offAll(() => SignIn());
                      }),
              Spacer(),
            ]),
          ),
        ));
  }
}
