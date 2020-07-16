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
  bool normalIsSelected = false;
  Color bgColor = Colors.grey[300];
  double opac = 1;

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
          if (widget.listDataset[index].contains("Normal")) {
            return Container(
              child: _buildSingleChoiceChip(index),
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
                child: _buildSingleChoiceChip(index),
                opacity: opac,
              ),
            );
          }
        },
      ).toList(),
    );
  }

  Widget _buildSingleChoiceChip(int index) {
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
            if (widget.listDataset[index].contains("Normal")) {
              if(normalIsSelected){
                listSelected.remove(widget.listDataset[index]);
                normalIsSelected = false;
                bgColor = Colors.grey[300];
                opac = 1.0;
              }else{
                listSelected.clear();
                bgColor = Colors.grey[100];
                listSelected.add(widget.listDataset[index]);
                normalIsSelected = true;
                opac = .4;
              }
            }else{
              if (normalIsSelected) {
                listSelected.clear();
                bgColor = Colors.grey[100];
                listSelected.add("Normal");
                opac = .4;
              }else{
                if (listSelected.length < 1) {
                  listSelected.contains(widget.listDataset[index])
                      ? listSelected.remove(widget.listDataset[index])
                      : listSelected.add(widget.listDataset[index]);
                } else {
                  if (selected) {
                    listSelected.removeLast();
                    listSelected.add(widget.listDataset[index]);
                  } else {
                    listSelected.remove(widget.listDataset[index]);
                  }
            }

              }
            }

            widget.callback(widget.id, listSelected);
            // _value = selected ? widget.listDataset[index] : null;
          });
        },
      ),
    );
  }
}
