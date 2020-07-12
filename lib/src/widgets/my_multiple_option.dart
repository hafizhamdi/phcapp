import 'package:flutter/material.dart';

class MyMultipleOptions extends StatefulWidget {
  final listDataset;
  final id;
  final List<String> initialData;
  Function callback;

  MyMultipleOptions(
      {this.listDataset, this.initialData, this.callback, this.id});

  @override
  _MyMultipleOptions createState() => _MyMultipleOptions();
}

class _MyMultipleOptions extends State<MyMultipleOptions> {
  List<String> listSelected = new List();

  List<String> valueSelected;
  bool normalIsSelected = false;
  Color bgColor = Colors.grey[300];
  double opac = 1;

  @override
  void didChangeDependencies() {
    // valueSelected = ;
    if (widget.initialData != null) {
      listSelected = widget.initialData;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<Widget>.generate(
        widget.listDataset.length,
        (int index) {
          if (widget.listDataset[index].contains("Normal")) {
            return Container(
              // padding: EdgeInsets.only(right: 10),
              child: _buildChoiceChipWidget(index),
            );
          } else {
            if (listSelected.contains("Normal")) {
              opac = .4;
              bgColor = Colors.grey[100];
              normalIsSelected = true;
            } else {
              opac = 1.0;
            }
            return Container(
              // padding: EdgeInsets.only(right: 10),
              child: Opacity(
                child: _buildChoiceChipWidget(index),
                opacity: opac,
              ),
            );
          }
        },
      ).toList(),
    );
  }

  Widget _buildChoiceChipWidget(int index) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(
          widget.listDataset[index],
          // style: TextStyle(fontSize: 18),
          style: TextStyle(),
        ),
        selected: listSelected.contains(widget.listDataset[index]),
        backgroundColor: bgColor,
        selectedColor: Colors.pink[200],
        selectedShadowColor: Colors.grey,
        pressElevation: 10,
        elevation: 4,
        onSelected: (bool selected) {
          setState(() {
            if (widget.listDataset[index].contains("Normal")) {
              if (normalIsSelected) {
                listSelected.remove(widget.listDataset[index]);
                normalIsSelected = false;
                bgColor = Colors.grey[300];
                opac = 1.0;
              } else {
                listSelected.clear();
                bgColor = Colors.grey[100];
                listSelected.add(widget.listDataset[index]);
                normalIsSelected = true;
                opac = .4;
              }
            } else {
              if (normalIsSelected) {
                listSelected.clear();
                bgColor = Colors.grey[100];
                listSelected.add("Normal");
                opac = .4;
              } else {
                listSelected.contains(widget.listDataset[index])
                    ? listSelected.remove(widget.listDataset[index])
                    : listSelected.add(widget.listDataset[index]);
              }
            }

            widget.callback(widget.id, listSelected);
          });
        },
      ),
    );
  }
}
