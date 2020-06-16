import 'package:flutter/material.dart';

class MyCardFreeText extends StatelessWidget {
  final id;
  final name;
  final controller;
  // final listData;
  final value;
  // final Function mycallback;

  MyCardFreeText({this.id, this.name, this.value, this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                name,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: TextField(
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
