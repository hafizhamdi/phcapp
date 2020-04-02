import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  HeaderSection(this.headerTitle);

  final String headerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      
      // margin: EdgeInsets.only(top: 5),
      // padding: EdgeInsets.all(10),
      // transform: Matrix4.rotationZ(50.0),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.grey, width: 0.5),
        
      //   // color: Colors.white
      // ),
      child: Text(
        headerTitle,
        style: TextStyle(
          fontSize: 30,
          fontFamily: "Raleway",
        ),
      ),
    );
  }
}
