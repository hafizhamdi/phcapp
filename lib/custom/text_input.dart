import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  CustomTextInput({this.labelText, this.textController});
  final TextEditingController textController;
  final String labelText;
  _textInput createState() => _textInput();
}

class _textInput extends State<CustomTextInput> {
  // _textInput(this.labelText, this.context);

  // final BuildContext context;
  // final String labelText;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
                controller: widget.textController,
                decoration: InputDecoration(
                    labelText: widget.labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
    ;
  }
}
