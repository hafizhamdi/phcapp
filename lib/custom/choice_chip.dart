import 'package:flutter/material.dart';

enum Assessment {
  triage,
  appearance,
  responsiveness,
  airway,
  respiratory,
  airentry,
  breathSound,
  heartSound,
  skin,
  ecg,
  abdomenPalpation,
  abdomenAbnormal,
  faceStroke
}

class SingleOption extends StatefulWidget {
  SingleOption(
      {this.header,
      this.stateList,
      this.callback,
      this.multiple = true,
      this.initialData});

  final header;
  final List<String> stateList;
  final Function callback;
  bool multiple;
  final initialData;

  @override
  SingleChoiceChip createState() =>
      SingleChoiceChip(); //header, stateList, callback, multiple);
}

class SingleChoiceChip extends State<SingleOption> {
  // final String header;
  // final List<String> list;

  // final Function(String, List<String>) callback;
  // bool multiple;
  // final VoidCallback onSelectedChip;
  List<String> selectedItems = new List();
  // String _value = ""; // so that selected be false

  // final Function(String) onChoiceSelected;

  // SingleChoiceChip(this.header, this.list, this.callback, this.multiple);

  @override
  Widget build(BuildContext context) {
    if (widget.initialData != null) {
      selectedItems = widget.initialData;
    }
    return Container(
        padding: EdgeInsets.only(left: 10),
        child: Wrap(
          spacing: 10,
          children: List<Widget>.generate(
            widget.stateList.length,
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
              String item = widget.stateList[index];
              return ChoiceChip(
                elevation: 2.0,
                label: Text(item),
                selected: selectedItems.contains(widget.stateList[index]),
                selectedColor: Colors.pink[200],
                onSelected: (selected) {
                  setState(() {
                    // if (widget.multiple == true) {
                    selectedItems.contains(widget.stateList[index])
                        ? selectedItems.remove(item)
                        : selectedItems.add(widget.stateList[index]);
                    // } else {
                    //   print("multiple false this single");
                    //   if (selectedItems.length < 1) {
                    //     selectedItems.contains(widget.stateList[index])
                    //         ? selectedItems.remove(item)
                    //         : selectedItems.add(widget.stateList[index]);
                    //   } else {
                    //     selectedItems.remove(item);
                    //   }
                    // }
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

                    widget.callback(widget.header, selectedItems);
                    // Callback cb =
                    //     callback(item: stateList[index], index: index);

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
