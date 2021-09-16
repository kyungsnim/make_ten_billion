import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jiffy/jiffy.dart';
import './notification_model.dart';
import './next_screen.dart';

class NotificationDeatils extends StatelessWidget {
  const NotificationDeatils({Key? key, required this.notificationModel})
      : super(key: key);

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    final String dateTime = Jiffy(notificationModel.date).fromNow();
    return Scaffold(
      appBar: AppBar(
        title: Text('notification details'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_alarm_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  dateTime,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            HtmlWidget(
              notificationModel.title!,
              textStyle: TextStyle(
                  fontFamily: 'Manrope',
                  wordSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              thickness: 2,
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Html(
              data: notificationModel.body,
              onLinkTap: (String? url, RenderContext context1,
                  Map<String, String> attributes, _) {
                print(url!);
              },
              onImageTap: (String? url, RenderContext context1,
                  Map<String, String> attributes, _) {
                //nextScreen(context, FullScreenImage(imageUrl: url!, heroTag: url));
              },
              style: {
                "body": Style(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  fontSize: FontSize(16.0),
                  lineHeight: LineHeight(1.4),
                ),
                "figure":
                    Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
              },
            ),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
