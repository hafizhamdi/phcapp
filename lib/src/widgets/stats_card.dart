import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final labelText;
  final count;
  final color;

  StatsCard({this.labelText, this.count, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        // right: 10,
      ),
      // margin: EdgeInsets.all(10),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(labelText,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.w900)),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(count != null ? count.toString() : '0',
                style: TextStyle(
                    // fontFamily: "Poppins",
                    fontSize: 50,
                    fontWeight: FontWeight.w900)),
          )
        ],
      ),
    );
  }
}
