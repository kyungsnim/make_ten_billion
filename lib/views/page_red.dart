import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class PageRed extends StatefulWidget {
  final String title;
  final String id;

  const PageRed({Key? key, required this.title, required this.id}) : super(key: key);
  @override
  _PageRedState createState() => _PageRedState();
}

class _PageRedState extends State<PageRed> {
  String link = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                Text('Red Page'),
                SizedBox(height: 10),
                Text(widget.title),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      final DynamicLinkParameters parameters = DynamicLinkParameters(
                          uriPrefix: 'https://maketenbillion.page.link',
                          link: Uri.parse(
                              'https://maketenbillion.page.link/?route=blue?id=2020'),
                          androidParameters: AndroidParameters(
                              packageName: 'com.kyungsnim.make_ten_billion'
                          ),
                          iosParameters: IosParameters(
                              bundleId: 'com.kyungsnim.makeTenBillion'
                          ));
                      setState(() {
                        link = parameters.toString();
                      });
                    },
                    child: Text('tab')),
                SizedBox(height: 50),
                Text(link),
              ],
            )
        )
    );
  }
}
