import 'package:flutter/material.dart';

class PageBlue extends StatefulWidget {
  final String title;
  final String id;

  const PageBlue({Key? key, required this.title, required this.id}) : super(key: key);
  @override
  _PageBlueState createState() => _PageBlueState();
}

class _PageBlueState extends State<PageBlue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Blue Page'),
            SizedBox(height: 10),
            Text(widget.title),
          ],
        )
      )
    );
  }
}
