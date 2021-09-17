import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';
import 'package:make_ten_billion/models/models.dart';
import 'package:make_ten_billion/views/views.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './constants.dart';
import './notification_model.dart';
import './notifications.dart';
import './next_screen.dart';
import './notification_dialog.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

import 'package:http/http.dart' as http;

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final String subscriptionTopic = 'all';
  String? _token = '';

  Future<String?> getToken() async {
    return _token == '' ? await _fcm.getToken() : _token;
  }

  Future<String?> sendMessage(String title, bodyMessage,
      {required String imgUrl}) async {
    String url = 'https://fcm.googleapis.com/fcm/send';
    var body = {
      // "registration_ids": [await _fcm.getToken()],
      "to": "/topics/all",
      "notification": {
        "title": "$title",
        "body": "$bodyMessage",
      },
      "data": {"msgId": "msg_12342"}
    };

    print('Send Push Message ========================================');
    print(jsonEncode(body));
    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAxoH4z9Q:APA91bGY_5STcywZSPqKI7jfjtKnXnDHT6_uCSDqQe17UGRM8iD1WJQYZGQyJVLX2TiTJ_drXGRBM-BabcM_RqbrhHrtaMQwMMW_LIHmB6_HjdqMAIHsFzsA9706yUi8okSeNES34koy',
      },
      body: jsonEncode(body),
    );
    return response.body;
  }

  Future _handleIosNotificationPermissaion() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future initFirebasePushNotification(context) async {
    /// iOS의 경우 권한 얻어야 함
    if (Platform.isIOS) {
      _handleIosNotificationPermissaion();
    }

    /// 최초 실행시 토큰 값 얻기
    _token = await _fcm.getToken();
    print('User FCM Token : $_token');

    /// ????
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    print('inittal message : $initialMessage');
    if (initialMessage != null) {
      var noticeId;

      if (Platform.isIOS) {
        noticeId = initialMessage.data['aps']['alert']['body'];
      } else if (Platform.isAndroid) {
        noticeId = initialMessage.notification!.body;
      }
      await saveNotificationData(initialMessage).then((value) {
        print('>>>> ${initialMessage.notification!.body}');

        /// 알림 누르면 해당 게시글로 이동
        FirebaseFirestore.instance
            .collection('HowToBeRich')
            .doc(noticeId!)
            .get()
            .then((data) {
          NoticeModel detailNotice = NoticeModel.fromSnapshot(data);
          Navigator.pop(context);
          Get.to(() => HowToBeRichDetail(detailNotice));
        });
      });
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Vibrate.vibrate();

      print('onMessage');
      await saveNotificationData(message)
          .then((value) => _handleOpenNotificationDialog(context, message));
    });

    /// 알림을 눌러서 앱 실행하는 경우
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      var noticeId;

      if (Platform.isIOS) {
        noticeId = message.data['aps']['alert']['body'];
      } else if (Platform.isAndroid) {
        noticeId = message.notification!.body;
      }
      await saveNotificationData(message).then((value) {
        print('>>>> ${message.notification!.body}');

        /// 알림 누르면 해당 게시글로 이동
        FirebaseFirestore.instance
            .collection('HowToBeRich')
            .doc(noticeId!)
            .get()
            .then((data) {
          NoticeModel detailNotice = NoticeModel.fromSnapshot(data);
          Navigator.pop(context);
          Get.to(() => HowToBeRichDetail(detailNotice));
        });
      });
    });
  }

  Future _handleOpenNotificationDialog(context, RemoteMessage message) async {
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    NotificationModel notificationModel = NotificationModel(
        timestamp: _timestamp,
        date: message.sentTime,
        title: message.notification!.title,
        body: message.notification!.body);
    openNotificationDialog(context, notificationModel);
  }

  Future saveNotificationData(RemoteMessage message) async {
    /// 알림메시지 저장하기
    final list = Hive.box(Constants.notificationTag);
    DateTime now = DateTime.now();
    String _timestamp = DateFormat('yyyyMMddHHmmss').format(now);
    Map<String, dynamic> _notificationData = {
      'timestamp': _timestamp,
      'date': message.sentTime,
      'title': message.notification!.title,
      'body': message.notification!.body
    };

    await list.put(_timestamp, _notificationData);
  }

  Future deleteNotificationData(key) async {
    final bookmarkedList = Hive.box(Constants.notificationTag);
    await bookmarkedList.delete(key);
  }

  Future deleteAllNotificationData() async {
    final bookmarkedList = Hive.box(Constants.notificationTag);
    await bookmarkedList.clear();
  }

  Future<bool> handleFcmSubscribtion() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    bool _subscription = sp.getBool('subscribed') ?? true;
    if (_subscription == true) {
      _fcm.subscribeToTopic(subscriptionTopic);
      print('subscribed');
    } else {
      _fcm.unsubscribeFromTopic(subscriptionTopic);
      print('unsubscribed');
    }

    return _subscription;
  }

  void turnOnFcmSubscribtion() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('subscribed', true);
    _fcm.subscribeToTopic(subscriptionTopic);
    print('subscribed');
  }

  void turnOffFcmSubscribtion() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('subscribed', false);
    _fcm.unsubscribeFromTopic(subscriptionTopic);
    print('unsubscribed');
  }
}
