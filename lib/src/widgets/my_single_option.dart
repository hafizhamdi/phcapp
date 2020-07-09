import 'package:flutter/material.dart';

class MySingleOptions extends StatefulWidget {
  final listDataset;
  final id;
  final initialData;
  Function callback;

  MySingleOptions({this.listDataset, this.initialData, this.callback, this.id});

  @override
  _MySingleOptions createState() => _MySingleOptions();
}

class _MySingleOptions extends State<MySingleOptions>
    with AutomaticKeepAliveClientMixin<MySingleOptions> {
  @override
  bool get wantKeepAlive => true;

// {
  List<String> listSelected = new List();

  String strSelected;

  @override
  void didChangeDependencies() {
    strSelected = widget.initialData;
    if (strSelected != null) {
      listSelected.add(strSelected);
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
                // style: TextStyle(fontSize: 18),
              ),
              selected: listSelected.contains(widget.listDataset[index]),
              selectedColor: Colors.pink[200],
              onSelected: (bool selected) {
                setState(() {
                  if (listSelected.length < 1) {
                    listSelected.contains(widget.listDataset[index])
                        ? listSelected.remove(widget.listDataset[index])
                        : listSelected.add(widget.listDataset[index]);
                  } else {
                    listSelected.removeLast();
                    listSelected.add(widget.listDataset[index]);
                  }

                  widget.callback(widget.id, listSelected);
                  // _value = selected ? widget.listDataset[index] : null;
                });
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
