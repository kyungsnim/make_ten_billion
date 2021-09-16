import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:html/parser.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:jiffy/jiffy.dart';
import './constants.dart';
import './notification_model.dart';
import './notification_details.dart';
import './notification_service.dart';
import './empty_image.dart';
import './next_screen.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationList = Hive.box(Constants.notificationTag);
    return Scaffold(
      appBar: AppBar(
        title: Text('알림메세지'),
        actions: [
          TextButton(
            onPressed: () => NotificationService().deleteAllNotificationData(),
            child: Text('clear all'),
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith(
                    (states) => EdgeInsets.only(right: 15, left: 15))),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
              valueListenable: notificationList.listenable(),
              builder: (BuildContext context, dynamic value, Widget? child) {
                List items = notificationList.values.toList();
                items.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
                if (items.isEmpty)
                  return EmptyPageWithImage(
                    image: 'assets/images/notification.svg',
                    title: 'no notification title',
                    description: 'no notification description',
                  );
                return _NotificationList(items: items);
              }),
        ],
      ),
    );
  }
}

class _NotificationList extends StatelessWidget {
  const _NotificationList({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: ListView.separated(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 30),
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(
          height: 15,
        ),
        itemBuilder: (BuildContext context, int index) {
          final NotificationModel notificationModel = NotificationModel(
            timestamp: items[index]['timestamp'],
            date: items[index]['date'],
            title: items[index]['title'],
            body: items[index]['body']

          );

          final String dateTime = Jiffy(notificationModel.date).fromNow();

          return InkWell(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary, borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Text(
                        notificationModel.title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary),
                      )),
                      IconButton(
                          constraints: BoxConstraints(minHeight: 40),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.close,
                            size: 20,
                          ),
                          onPressed: () => NotificationService()
                              .deleteNotificationData(notificationModel.timestamp))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.time, size: 18, color: Colors.grey,),
                      SizedBox(width: 5,),
                      Text(
                        dateTime,
                        style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(HtmlUnescape().convert(parse(notificationModel.body).documentElement!.text),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary
                      )),
                ],
              ),
            ),
            onTap: (){
              nextScreen(context, NotificationDeatils(notificationModel: notificationModel));
            } 
          );
        },
      ),
    );
  }
}
