import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  Label(this.label, this.label2);

  // Fields in a Widget subclass are always marked "final".

  // final Widget title;
  final String label;
  final String label2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: Row(
        // <Widget> is the type of items in the list.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          Expanded(
              child: Text(
            label,
            style: TextStyle(fontSize: 16),
          )),
          Expanded(child: Text(label2, style: TextStyle(fontSize: 16)))
        ],
      ),
    );
  }
}
