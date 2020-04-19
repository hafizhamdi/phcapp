import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TextEditLabel extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String value;

  TextEditLabel({this.labelText, this.controller, this.value});

  _TextEditLabel createState() => _TextEditLabel();
}

class _TextEditLabel extends State<TextEditLabel> {
  String mytext = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mytext = widget.controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: 400,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textLabel(widget.labelText),
                        Text(mytext, style: TextStyle(fontSize: 18)),
                      ]),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: mainContent(
                                widget.labelText, widget.controller),
                            actions: <Widget>[
                              buttonSave(context, "SAVE CHANGES")
                            ],
                          );
                        },
                      );
                    },
                  )
                ])));
  }

  Widget mainContent(String labelText, TextEditingController controller) {
    return TextFormField(
        onChanged: (text) {
          // onChanged: (text) {
          setState(() {
            mytext = text;
          });
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ));
  }
}

Widget textLabel(String labelText) {
  return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Text(labelText,
          style: TextStyle(color: Colors.grey[600], fontSize: 12)));
}

Widget buttonSave(BuildContext context, String labelText) {
  return FlatButton.icon(
    icon: Icon(Icons.check),
    onPressed: () {
      Navigator.pop(context);
    },
    label: Text(labelText),
    color: Colors.green,
  );
}
