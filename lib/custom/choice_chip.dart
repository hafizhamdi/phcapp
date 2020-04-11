import 'package:flutter/material.dart';

class SingleOption extends StatefulWidget {
  SingleOption({this.header, this.stateList, this.callback, this.multiple});

  final String header;
  final List<String> stateList;
  final Function callback;
  bool multiple;

  @override
  SingleChoiceChip createState() =>
      SingleChoiceChip(header, stateList, callback, multiple);
}

class SingleChoiceChip extends State<SingleOption> {
  final String header;
  final List<String> list;

  final Function(String, List<String>) callback;
  bool multiple;
  // final VoidCallback onSelectedChip;
  List<String> selectedItems = new List();
  // String _value = ""; // so that selected be false

  // final Function(String) onChoiceSelected;

  SingleChoiceChip(this.header, this.list, this.callback, this.multiple);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: Wrap(
          spacing: 10,
          children: List<Widget>.generate(
            list.length,
            (int index) {
              // var len = list.length;
              // if (index == len) {
              //   return IconButton(
              //     icon: Icon(Icons.replay),
              //     onPressed: () {
              //       // setState(() {
              //       // if(multiple == true){
              //       //   selectedItems.add()
              //       // }

              //       // _value = 10;
              //       // selectedItems[0] = _value;
              //       // callback(header, selectedItems);
              //       // });
              //     },
              //   );
              // } else {
              String item = list[index];
              return ChoiceChip(
                elevation: 2.0,
                label: Text(item),
                selected: selectedItems.contains(list[index]),
                onSelected: (selected) {
                  setState(() {
                    if (multiple == true) {
                      selectedItems.contains(list[index])
                          ? selectedItems.remove(item)
                          : selectedItems.add(list[index]);
                    } else {
                      selectedItems = new List();
                      selected
                          ? selectedItems.add(list[index])
                          : selectedItems.remove(list[index]);
                    }
                    // _value = selected ? index : null;

                    // print("multiple");
                    // print(multiple);
                    // if (multiple == true) {
                    // (_value != null)
                    // ?
                    // selectedItems.add(index);
                    // print(selectedItems.length);
                    // : selectedItems.removeAt(index);
                    // } else {
                    // selectedItems[0] = _value;
                    // }

                    callback(header, selectedItems);
                    // Callback cb =
                    //     callback(item: list[index], index: index);

                    // callback(cb);
                  });
                },
              );
              // }
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
