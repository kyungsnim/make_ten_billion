import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:make_ten_billion/models/models.dart';
import 'package:make_ten_billion/views/views.dart';
import './notification_model.dart';
import './notification_details.dart';
import './next_screen.dart';

void openNotificationDialog(context, NotificationModel notificationModel) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            scrollable: false,
            contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.redAccent,
                        child: Icon(Icons.notifications_none, size: 16, color: Colors.white),
                      ),
                      SizedBox(width: 10,),
                      Text(
                        '신규 게시글 알림',
                        style: TextStyle(fontSize: 13, color: Colors.redAccent),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(height: 15,),
                  Text(
                        notificationModel.title!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                  // Text(
                  //     HtmlUnescape().convert(
                  //         parse(notificationModel.body).documentElement!.text),
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 3,
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: Theme.of(context).colorScheme.secondary
                  //     )
                  //   ),
                ],
              ),
            actions: [
              TextButton(
                child: Text('열기'),
                onPressed: () {
                  /// 게시글 ID로 해당 문서를 조회한 후 해당 게시글로 이동
                  FirebaseFirestore.instance
                      .collection('HowToBeRich')
                      .doc(HtmlUnescape().convert(
                            parse(notificationModel.body).documentElement!.text))
                      .get()
                      .then((data) {
                    NoticeModel detailNotice = NoticeModel.fromSnapshot(data);
                    Navigator.pop(context);
                    Get.to(() => HowToBeRichDetail(detailNotice));
                  });
                  // Navigator.pop(context);
                  // nextScreen(context, NotificationDeatils(notificationModel: notificationModel,));
                },
              ),
              TextButton(
                child: Text('닫기'),
                onPressed: (){
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }