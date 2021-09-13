import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:make_ten_billion/views/how_to_be_rich_detail.dart';
import 'package:make_ten_billion/views/page_blue.dart';
import 'package:make_ten_billion/views/page_red.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  _CoreScreenState createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {

  String link = '';

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      if (widget.data.length > 0) {
        isThereLink();
      }
    });
  }

  isThereLink() async {
    Timer(Duration(milliseconds: 700), () async {
      /// do something
      switch (widget.data['route']) {
        case 'red':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageRed(
                      title: widget.data['route'], id: widget.data['id'])));
          break;
        case 'blue':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PageBlue(
                      title: widget.data['route'], id: widget.data['id'])));
          break;
        case 'HowToBeRichDetail':
          FirebaseFirestore.instance.collection('HowToBeRich').doc(widget.data['id']).get().then((notice) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HowToBeRichDetail(notice)));
          });

          break;
        // case 'detailNotice':
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => HowToBeRichDetail()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: 100),
        GestureDetector(
            onTap: () {
              final DynamicLinkParameters parameters = DynamicLinkParameters(
                  uriPrefix: 'https://maketenbillion.page.link',
                  link: Uri.parse(
                      'https://maketenbillion.page.link/?route=blue?/id=2020'),
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
    ));
  }
}
