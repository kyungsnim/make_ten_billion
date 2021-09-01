import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  static ChatController to = Get.find();
  RxInt count = 0.obs;
  Stream? chatRoomsStream;
  String? roomId = '';
  Stream? chatMessageStream;
  TextEditingController messageTextEditingController = TextEditingController();

  increment() {
    count++;
    update();
  }

  getChatRooms(String username) async {
    chatRoomsStream = await FirebaseFirestore.instance
        .collection('ChatRoom')
        .where('users', arrayContains: username)
        .snapshots();
    update();
  }

  getConversationMessages(String roomId) async {
    chatMessageStream = await FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(roomId)
        .collection('Chats')
        .orderBy('sendDt', descending: true) /// 채팅창 최신이 가장 아래로 오도록
        .snapshots();
    update();
  }

  addConversationMessages(String roomId, messageMap) {
    FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(roomId)
        .collection('Chats')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
    update();
  }

  void setRoomId(String roomId) {
    this.roomId = roomId;
    update();
  }

  void clearMessageTextController() {
    messageTextEditingController.text = '';
    update();
  }
}