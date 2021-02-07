import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final labelText;
  final count;
  final color;
  final icon;

  StatsCard({this.labelText, this.count, this.color, this.icon});

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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
          // colors: [const Color(0xFF33ccff), const Color(0xFFff99cc)],
          colors: [Colors.white54, color],
        ), // whit
        // border: Border.all(color: Colors.grey),
      ),
      child: Stack(alignment: AlignmentDirectional.topCenter, children: [
        Positioned(
          child: Icon(
            icon,
            size: 100,
            color: Colors.white.withOpacity(0.5),
          ),
          right: -15,
          bottom: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(labelText,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18,
                      fontWeight: FontWeight.w900)),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(count != null ? count.toString() : '0',
                  style: TextStyle(
                      // color: Colors.white,
                      // fontFamily: "Poppins",
                      fontSize: 50,
                      fontWeight: FontWeight.w900)),
            )
          ],
        ),
      ]),
    );
  }
}
