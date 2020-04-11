import 'package:flutter/widgets.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/label.dart';
import 'package:phcapp/custom/input.dart';
import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
              child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      HeaderSection("Patient Information"),
                      _textInput("Name", context),
                      _textInput("ID No.", context),
                      _textInput("Document Type", context),
                      _textInput("Date of Birth", context),
                      _textInput("Age", context),
                      _textInput("Gender", context),
                    ],
                  )))),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   label: Text('EDIT'),
      //   icon: Icon(Icons.edit),
      //   // backgroundColor: Colors.purple,
      // )
    );
  }
}

Widget _textInput(labelText, context) {
  return Container(
      // width: 500,
      width: 500,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
              decoration: InputDecoration(
                  labelText: labelText,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  )))));
}
