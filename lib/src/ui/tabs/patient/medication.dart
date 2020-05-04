import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/label.dart';
import 'package:phcapp/src/providers/medication_provider.dart';
import 'package:provider/provider.dart';

// const _rhythmChoices = ['Rhythm 1', 'Rhythm 2', 'Rhythm 3'];
// const _mainChoices = [
//   'Witness CPR',
//   'Bystander CPR',
//   'CPR Start',
//   'ROSC',
//   'CPR Stop'
// ];

// const _typeChoices = ['Shockable', "Non-shockable", "Other"];

// const _rhythmType = [
//   "VF",
//   "Pulseless VT",
//   "Asystole",
//   "PEA",
//   "Tachyarrythmias",
//   "Bradyarrythmias"
// ];

const _medication = [
  "D50%",
  "D10%",
  "Aspirin",
  "GTN",
  "adrenalin",
  "tramadol",
  "diclofenac",
  "morphine",
  "ketamine",
  "midazolam",
  "diazepam",
  "tranexemic acid",
  "hydrocortisone",
  "neb combivent",
  "neb salbutamol"
];

final GlobalKey<AnimatedListState> _listKey = GlobalKey();
final _formKey = GlobalKey<FormState>();

List<String> _data = ['CPR Start', 'Bystander', 'ROSC'];

class Medication extends StatelessWidget {
  String data;

  final commentController = TextEditingController();

  void setItem(String item) {
    data = item;
  }

  void chipCallback(String item, List<String> list) {
    // void chipCallback(String item) {
    print('mylist:$list');
    print('user tapped on $item');

    setItem(list[0]);
  }

  @override
  void dispose() {
    commentController.dispose();
  }

  String getItem() {
    return data;
  }

  @override
  build(BuildContext context) {
    Scaffold(
        appBar: AppBar(
          title: Text("Medication"),
        ),
        // backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
                child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
              // child: Container(
              //     // alignment: Alignment.center,
              //     width: 500,
              //     child: Column(
              //       children: <Widget>[
              //         SizedBox(
              //             // height: 500,
              //             child: AnimatedList(
              //                 // shrinkWrap: true,
              //                 // physics: NeverScrollableScrollPhysics(),

              //                 // // Give the Animated list the global key
              //                 // key: _listKey,
              //                 // initialItemCount: logs.items.length,
              //                 // itemBuilder: (context, index, animation) {
              //                 //   return _buildItem(
              //                 //       logs, index, logs.items[index], animation);
              //                 // },
              //                 ))
              //       ],
              //     ))
            )))

        // floatingActionButton: FloatingButton(
        //   commentController: commentController,
        //   logs: logs,
        // ));
        );
  }

  void onModalPressed(context) {}

  Widget _buildItem(logs, index, LogMeasurement data, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
            leading: Icon(Icons.local_drink),
            title: Text(
              data.item,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(
                data.measurement != null ? "Dose: " + data.measurement : "N/A"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(data.timestamp),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    logs.remove(index);

                    AnimatedListRemovedItemBuilder builder =
                        (context, animation) {
                      return _buildItem(logs, index, data, animation);
                    };
                    // Remove the item visually from the AnimatedList.
                    _listKey.currentState.removeItem(index, builder);
                  },
                )
              ],
            )),
      ),
    );
  }

  void _insertSingleItem(String newItem) {
    // var df = new DateFormat.jm();

    // String newItem = "Planet";
    // Arbitrary location for demonstration purposes
    int insertIndex = 2;
    // Add the item to the data list.
    _data.insert(insertIndex, newItem);
    // Add the item visually to the AnimatedList.
    _listKey.currentState.insertItem(insertIndex);
  }
}

Widget _todaysDate() {
  String currentDate =
      new DateFormat.yMMMMd("en_US").format(new DateTime.now());
  return Container(
    padding: EdgeInsets.only(left: 10),
    child: Text(
      currentDate,
    ),
  );
}

class FloatingButton extends StatelessWidget {
  final commentController;
  final logs;

  FloatingButton({this.commentController, this.logs});
  String data;

  String getItem() {
    return data;
  }

  void setItem(String item) {
    data = item;
  }

  void chipCallback(String item, List<String> list) {
    // void chipCallback(String item) {
    print('mylist:$list');
    print('user tapped on $item');

    setItem(list[0]);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
            context: context,
            // builder: (context, <LogModel> logs, child) {
            builder: (BuildContext context) {
              return AlertDialog(
                  content: SingleChildScrollView(
                      child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Add Medication')),
                  // Label("Select type", ""),
                  SingleOption(
                      header: "Add medication",
                      stateList: _medication,
                      callback: chipCallback),
                  // SingleOption(list, chipCallback),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                          // border: InputBorder.none,
                          hintText: "Enter dose here"),
                      controller: commentController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.lightGreen,
                      child: Text(
                        "ADD MEDICINE",
                      ),
                      onPressed: () {
                        String newItem = getItem();
                        // Arbitrary location for demonstration purposes
                        int insertIndex = 0;
                        LogMeasurement logItem = new LogMeasurement(
                            item: newItem,
                            measurement: commentController.text,
                            timestamp:
                                new DateFormat.jm().format(new DateTime.now()));

                        logs.add(logItem);
                        _listKey.currentState.insertItem(insertIndex);

                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              )));
              // )
              // });
            });
      },
      label: Text('ADD MEDICATION'),
      icon: Icon(Icons.add),
      // backgroundColor: Colors.purple,
    );
  }
}
