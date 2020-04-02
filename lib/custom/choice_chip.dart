import 'package:flutter/material.dart';

class SingleOption extends StatefulWidget {
  SingleOption({this.header, this.stateList, this.callback});

  final String header;
  final List<String> stateList;
  final Function callback;
  @override
  SingleChoiceChip createState() =>
      SingleChoiceChip(header, stateList, callback);
}

class SingleChoiceChip extends State<SingleOption> {
  final String header;
  final List<String> list;
  final Function(String, int) callback;
  // final VoidCallback onSelectedChip;

  int _value = 10; // so that selected be false

  // final Function(String) onChoiceSelected;

  SingleChoiceChip(this.header, this.list, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: Wrap(
          spacing: 10,
          children: List<Widget>.generate(
            list.length + 1,
            (int index) {
              var len = list.length;
              if (index == len) {
                return IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: () {
                    // setState(() {
                    _value = 10;
                    callback(header, _value);
                    // });
                  },
                );
              } else {
                return ChoiceChip(
                  elevation: 2.0,
                  label: Text(list[index]),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                      callback(header, _value);
                      // Callback cb =
                      //     callback(item: list[index], index: index);

                      // callback(cb);
                    });
                  },
                );
              }
            },
          ).toList(),
        ));
  }
}

class Callback {
  String item;
  int index;

  Callback({this.item, this.index});
}
