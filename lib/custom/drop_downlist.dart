import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown(
      {this.labelText, this.items, this.callback, this.itemSelected});
  final List<String> items;
  final String labelText;
  Function callback;
  String itemSelected;

  _CustomDropDownState createState() =>
      _CustomDropDownState(labelText, items, callback, itemSelected);
}

class _CustomDropDownState extends State<CustomDropDown> {
  _CustomDropDownState(this.labelText, this.items, callback, this.itemSelected);
  // labelText, List<String> list, Function callback, String selected
  final List<String> items;
  final String labelText;

  String itemSelected;

  Function callback(String item) {
    setState(() {
      itemSelected = item;
    });
  }

  // Function callback(String item) {
  //   itemSelected = item;
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField(
                isDense: true,
                items: items.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                      child: Text(dropDownStringItem),
                      value: dropDownStringItem);
                }).toList(),
                onChanged: (String newValueSelected) {
                  callback(newValueSelected);
                },
                value: itemSelected,
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
    ;
  }
}
