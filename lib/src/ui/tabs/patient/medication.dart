import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/label.dart';
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

// const _interventionType = ["Defibrillation", "Sync-cardioversion", "Pacing"];

// const _airwayType = ["BVM", "LMA", "ETT"];

// const _rhythmChoice = ['Rhythm 1', 'Rhythm 2', 'Rhythm 3'];

final GlobalKey<AnimatedListState> _listKey = GlobalKey();
final _formKey = GlobalKey<FormState>();

List<String> _data = ['CPR Start', 'Bystander', 'ROSC'];

class Medication extends StatelessWidget {
  String data;

  // List<LogMeasurement> logs = new List<LogMeasurement>();

  LogModel logs_float = new LogModel();

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
    return ChangeNotifierProvider(
        create: (context) => LogModel(),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Medication"),
            ),
            // backgroundColor: Colors.grey[200],
            body: Consumer<LogModel>(
              builder: (context, logs, child) {
                logs_float = logs;
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Card(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 70),
                        child: Column(
                          // child: Scaffold(
                          //   // backgroundColor: Colors.grey[200],
                          //   body: Consumer<LogModel>(
                          //     builder: (context, logs, child) {
                          //       return ListView(
                          children: <Widget>[
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: <Widget>[
                            //     _buildIconData(context, logs, Icons.videocam,
                            //         _typeChoices, "Types"),
                            //     _buildIconData(context, logs, Icons.vibration,
                            //         _rhythmType, "Rhythm"),
                            //     _buildIconData(context, logs, Icons.donut_large,
                            //         _drugsType, "Drugs"),
                            //     _buildIconData(
                            //         context,
                            //         logs,
                            //         Icons.surround_sound,
                            //         _interventionType,
                            //         "Intervention"),
                            //   ],
                            // ),
                            // HeaderSection("Select rhythm"),
                            // SingleOption(_rhythmChoice),
                            // HeaderSection("CPR Logs"),
                            // _todaysDate(),

                            SizedBox(
                                // height: 500,
                                child: AnimatedList(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),

                              // Give the Animated list the global key
                              key: _listKey,
                              initialItemCount: logs.items.length,
                              // _data.length,
                              // Similar to ListView itemBuilder, but AnimatedList has
                              // an additional animation parameter.
                              itemBuilder: (context, index, animation) {
                                // Breaking the row widget out as a method so that we can
                                // share it with the _removeSingleItem() method.
                                return _buildItem(
                                    logs, index, logs.items[index], animation);
                              },
                            )),
                            // ),
                          ],
                        )));
              },
            ),
            floatingActionButton: FloatingActionButton.extended(
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
                                  // int lastItems = logs._item.length;
                                  // Add the item to the data list.
                                  LogMeasurement logItem = new LogMeasurement(
                                      item: newItem,
                                      measurement: commentController.text,
                                      timestamp: new DateFormat.jm()
                                          .format(new DateTime.now()));
                                  logs_float.add(logItem);
                                  // logs.add(title +
                                  //     " " +
                                  //     newItem +
                                  //     " " +
                                  //     commentController.text);
                                  // logs._items.insert(0, newItem);
                                  // _data.insert(insertIndex, newItem);
                                  // Add the item visually to the AnimatedList.
                                  _listKey.currentState.insertItem(insertIndex);
                                  // if (_formKey.currentState.validate()) {
                                  //   _formKey.currentState.save();
                                  // }
                                },
                              ),
                            )
                          ],
                        ),
                      ));
                    });
              },
              label: Text('ADD MEDICATION'),
              icon: Icon(Icons.add),
              // backgroundColor: Colors.purple,
            )));
    // return
  }

  void onModalPressed(context) {}

  Widget _buildItem(logs, index, LogMeasurement data, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
            title: Text(
              data.item,
              style: TextStyle(fontSize: 20),
            ),
            subtitle: Text(data.measurement != null ? data.measurement : ""),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(data.timestamp),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // int temp = index;
                    // temp -= 1;
                    // print(temp);
                    // print(index--);
                    logs.remove(index);

                    AnimatedListRemovedItemBuilder builder =
                        (context, animation) {
                      return _buildItem(logs, index, data, animation);
                    };
                    // Remove the item visually from the AnimatedList.
                    _listKey.currentState.removeItem(index, builder);

                    // This builder is just for showing the row while it is still
                    // animating away. The item is already gone from the data list.

                    // _listKey.currentStat
                    // _listKey.currentState.
                    // _listKey.currentState.removeItem(2);
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

Widget _buildIconData(BuildContext context, logs, IconData icon,
    List<String> list, String title) {
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

  return Column(
    children: <Widget>[
      IconButton(
        icon: Icon(icon),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text('Select $title:')),
                      // Label("Select type", ""),
                      SingleOption(
                          header: title,
                          stateList: list,
                          callback: chipCallback),
                      // SingleOption(list, chipCallback),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              // border: InputBorder.none,
                              hintText: "Put detail measurements"),
                          controller: commentController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          color: Colors.lightGreen,
                          child: Text(
                            "GENERATE LOG",
                          ),
                          onPressed: () {
                            String newItem = getItem();
                            // Arbitrary location for demonstration purposes
                            int insertIndex = 0;
                            // int lastItems = logs._item.length;
                            // Add the item to the data list.
                            LogMeasurement logItem = new LogMeasurement(
                                item: title + " " + newItem,
                                measurement: commentController.text,
                                timestamp:
                                    DateFormat.jm().format(DateTime.now()));
                            logs.add(logItem);
                            // logs.add(title +
                            //     " " +
                            //     newItem +
                            //     " " +
                            //     commentController.text);
                            // logs._items.insert(0, newItem);
                            // _data.insert(insertIndex, newItem);
                            // Add the item visually to the AnimatedList.
                            _listKey.currentState.insertItem(insertIndex);
                            // if (_formKey.currentState.validate()) {
                            //   _formKey.currentState.save();
                            // }
                          },
                        ),
                      )
                    ],
                  ),
                ));
              });
        },
      ),
      Text(
        title,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ],
  );

  void _insertSingleItem() {
    // var df = new DateFormat.jm();
  }
}

class LogModel extends ChangeNotifier {
  // final item;
  // final measurement;

  // LogModel({this.item, this.measurement});

  /// Internal, private state of the cart.
  final List<LogMeasurement> _items = <LogMeasurement>[
    // LogMeasurement(
    //     item: '',
    //     timestamp: new DateFormat.jm().format(new DateTime.now()))
  ];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<LogMeasurement> get items =>
      UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(LogMeasurement item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(int index) {
    _items.removeAt(index);

    notifyListeners();
  }
}

class LogMeasurement {
  final item;
  final measurement;
  final timestamp;

  LogMeasurement({this.item, this.measurement, this.timestamp});
}
