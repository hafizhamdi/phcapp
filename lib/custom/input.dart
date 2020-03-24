import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input(this.label, this.label2);

  // Fields in a Widget subclass are always marked "final".

  // final Widget title;
  final String label;
  final String label2;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 56.0, // in logical pixels
      padding: const EdgeInsets.only(left: 20, top: 10),
      // decoration: BoxDecoration(color: Colors.blue[500]),
      // // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          Expanded(
              child: Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )),
          Expanded(
              child: Text(label2,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
