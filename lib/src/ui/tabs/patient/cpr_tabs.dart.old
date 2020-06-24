import 'package:flutter/material.dart';

const RHYTHM = ["VF", "Pulseless VT"];
const INTERV = ["Defibrillation"];

class CPRTabs extends StatefulWidget {
  _CPRTabs createState() => _CPRTabs();
}

class _CPRTabs extends State<CPRTabs> {
  List<String> selectedRhythm = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
                // title: Text("CPR Detail"),
                bottom: TabBar(tabs: [
              Tab(
                text: "SHOCKABLE",
              ),
              Tab(
                text: "NON SHOCKABLE",
              ),
              Tab(
                text: "OTHER",
              ),
            ])),
            body: TabBarView(children: <Widget>[
              _buildShockable(),
              Icon(Icons.ac_unit),
              Icon(Icons.ac_unit)
            ])));
  }

  _buildChoiceChip(labelText, data, selectedList) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelText),
            Wrap(
                children: List<Widget>.generate(data.length, (index) {
              return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(data[index]),
                    selected: selectedList.contains(data[index]),
                    onSelected: (bool selected) {
                      (selected == true)
                          ? setState(() {
                              selectedList.add(data[index]);
                            })
                          : setState(() {
                              selectedList.remove(data[index]);
                            });
                    },
                    selectedColor: Theme.of(context).accentColor,
                  ));
            }))
          ],
        ));
  }

  _buildShockable() {
    return Center(
      child: Column(
        children: <Widget>[
          _buildChoiceChip("Rhythm", RHYTHM, selectedRhythm),
          // _buildChoiceChip("Bystander CPR", WITNESS, selectedBystander),
          // _buildChoiceChip("CPR Start", WITNESS, selectedCpr),
          // _buildChoiceChip("ROSC", WITNESS, selectedRosc),
          // _buildChoiceChip("CPR Stop", WITNESS, selectedCprStop)
        ],
      ),
    );
  }
}
