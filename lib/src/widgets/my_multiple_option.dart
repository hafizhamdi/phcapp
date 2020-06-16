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
          return Container(
            padding: EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(
                widget.listDataset[index],
                style: TextStyle(fontSize: 18),
              ),
              selected: listSelected.contains(widget.listDataset[index]),
              onSelected: (bool selected) {
                setState(() {
                  listSelected.contains(widget.listDataset[index])
                      ? listSelected.remove(widget.listDataset[index])
                      : listSelected.add(widget.listDataset[index]);

                  widget.callback(widget.id, listSelected);
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
