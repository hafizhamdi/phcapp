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
  Color bgColor = Colors.grey[300];
  bool normalIsSelected = false;
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
          if (widget.listDataset[index].contains("Normal") ||
              widget.listDataset[index].contains("Oriented") ||
              widget.listDataset[index].contains("Adequate airway") ||
              widget.listDataset[index].contains("Sinus Rhythm") ||
              widget.listDataset[index].contains("Soft & non-tender")) {
            return Container(
              // padding: EdgeInsets.only(right: 10),
              child: _buildChoiceChipWidget(index),
            );
          } else {
            if (listSelected.contains("Normal") ||
                listSelected.contains("Oriented") ||
                listSelected.contains("Adequate airway") ||
                listSelected.contains("Sinus Rhythm") ||
                listSelected.contains("Soft & non-tender")) {
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
          style: TextStyle(color: Colors.black87),
        ),
        selected: listSelected.contains(widget.listDataset[index]),
        backgroundColor: bgColor,
        selectedColor: Colors.pink[200],
        selectedShadowColor: Colors.grey,
        pressElevation: 10,
        elevation: 4,
        onSelected: (bool selected) {
          setState(() {
            if (widget.listDataset[index].contains("Normal") ||
                widget.listDataset[index].contains("Oriented") ||
                widget.listDataset[index].contains("Adequate airway") ||
                widget.listDataset[index].contains("Sinus Rhythm") ||
                widget.listDataset[index].contains("Soft & non-tender")) {
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

                if (widget.listDataset.contains("Normal")) {
                  listSelected.add("Normal");
                } else if (widget.listDataset.contains("Oriented")) {
                  listSelected.add("Oriented");
                } else if (widget.listDataset.contains("Adequate airway")) {
                  listSelected.add("Adequate airway");
                } else if (widget.listDataset.contains("Sinus Rhythm")) {
                  listSelected.add("Sinus Rhythm");
                } else if (widget.listDataset.contains("Soft & non-tender")) {
                  listSelected.add("Soft & non-tender");
                }
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
