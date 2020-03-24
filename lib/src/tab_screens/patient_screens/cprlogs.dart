import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/label.dart';
import 'package:provider/provider.dart';

const _rhythmChoices = ['Rhythm 1', 'Rhythm 2', 'Rhythm 3'];
const _mainChoices = [
  'Witness CPR',
  'Bystander CPR',
  'CPR Start',
  'ROSC',
  'CPR Stop'
];

const _typeChoices = ['Shockable', "Non-shockable", "Other"];

const _rhythmType = [
  "VF",
  "Pulseless VT",
  "Asystole",
  "PEA",
  "Tachyarrythmias",
  "Bradyarrythmias"
];

const _drugsType = ["Adrenaline", "Amiodarone", "Atropine"];

const _interventionType = ["Defibrillation", "Sync-cardioversion", "Pacing"];

const _airwayType = ["BVM", "LMA", "ETT"];

// const _rhythmChoice = ['Rhythm 1', 'Rhythm 2', 'Rhythm 3'];

final GlobalKey<AnimatedListState> _listKey = GlobalKey();
final _formKey = GlobalKey<FormState>();

List<String> _data = ['CPR Start', 'Bystander', 'ROSC'];

class CPRLogs extends StatelessWidget {
  @override
  build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LogModel(),
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Consumer<LogModel>(
            builder: (context, logs, child) {
              return ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildIconData(
                          context, logs, Icons.videocam, _typeChoices, "Types"),
                      _buildIconData(context, logs, Icons.vibration,
                          _rhythmType, "Rhythm"),
                      _buildIconData(context, logs, Icons.donut_large,
                          _drugsType, "Drugs"),
                      _buildIconData(context, logs, Icons.surround_sound,
                          _interventionType, "Intervention"),
                    ],
                  ),
                  // HeaderSection("Select rhythm"),
                  // SingleOption(_rhythmChoice),
                  HeaderSection("CPR Logs"),
                  _todaysDate(),

                  SizedBox(
                    height: 300,
                    child: AnimatedList(
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
                            logs, index, logs._items[index], animation);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: () {},
          //   label: Text('SELECT ACTION'),
          //   icon: Icon(Icons.menu),
          //   backgroundColor: Colors.purple,
          // )
        ));
    // return
  }

  void onModalPressed(context) {}

  Widget _buildItem(logs, index, String item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Text(new DateFormat.jm().format(new DateTime.now())),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // int temp = index;
              // temp -= 1;
              // print(temp);
              // print(index--);
              logs.remove(index);

              AnimatedListRemovedItemBuilder builder = (context, animation) {
                return _buildItem(logs, index, item, animation);
              };
              // Remove the item visually from the AnimatedList.
              _listKey.currentState.removeItem(index, builder);

              // This builder is just for showing the row while it is still
              // animating away. The item is already gone from the data list.

              // _listKey.currentStat
              // _listKey.currentState.
              // _listKey.currentState.removeItem(2);
            },
          ),
        ),
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
  String text;
  final commentController = TextEditingController();

  void setItem(String item) {
    data = item;
  }

  void chipCallback(String item) {
    print('user tapped on $item');
    setItem(item);
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
                      Label("Select type", ""),
                      SingleOption(list, chipCallback),
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
                            logs.add(title +
                                " " +
                                newItem +
                                " " +
                                commentController.text);
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
  /// Internal, private state of the cart.
  final List<String> _items = ['CPR Start'];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<String> get items => UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(String item) {
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
