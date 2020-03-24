import 'package:flutter/material.dart';

class SingleOption extends StatefulWidget {
  SingleOption(this.stateList, this.callback);

  final List<String> stateList;
  final Function callback;
  @override
  SingleChoiceChip createState() => SingleChoiceChip(stateList, callback);
}

class SingleChoiceChip extends State<SingleOption> {
  final List<String> list;
  final Function callback;

  int _value = 0;

  // final Function(String) onChoiceSelected;

  SingleChoiceChip(this.list, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: Wrap(
          spacing: 10,
          children: List<Widget>.generate(
            list.length,
            (int index) {
              return ChoiceChip(
                elevation: 2.0,
                label: Text(list[index]),
                selected: _value == index,
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? index : null;
                    callback(list[_value]);
                  });
                },
              );
            },
          ).toList(),
        ));
  }
}
