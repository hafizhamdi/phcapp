import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/widgets/mycard_single_option.dart';

const _medication = [
  "D50%",
  "D10%",
  "NaCl 0.9%",
  "NaCl 0.45%"
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

class MedicationScreen extends StatefulWidget {
  _MedicationScreen createState() => _MedicationScreen();
}

class _MedicationScreen extends State<MedicationScreen> {
  List<Medication> _items = new List<Medication>();

  // UnmodifiableListView<Medication> items =
  //     UnmodifiableListView<Medication>(_items);
  final _listKey = GlobalKey<AnimatedListState>();
  var _index = 0;

  TextEditingController doseController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  List<String> listMedicine;

  medicationCallback(id, List<String> listReturn) {
    setState(() {
      listMedicine = listReturn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medication Assessment"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            label: Text(
              "SAVE",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              MedicationAssessment medicationAssessment =
                  new MedicationAssessment(
                      timestamp: new DateTime.now(), medication: _items);

              BlocProvider.of<MedicationBloc>(context).add(
                  UpdateMedication(medicationAssessment: medicationAssessment));

              Navigator.pop(context);
            },
          )
        ],
      ),
      body: BlocBuilder<MedicationBloc, MedicationState>(
          builder: (context, state) {
        if (state is LoadedMedication) {
          _items = state.medicationAssessment.medication;
          return _buildAnimatedList(_items);
        }
        return _buildAnimatedList(_items);
      }

          // },
          ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text("ADD MEDICATION"),
        onPressed: () {
          timeController.text =
              DateFormat("dd/MM/yyyy HH:mm").format(new DateTime.now());

          doseController.text = "";
          showDialog(
              context: context,
              // builder: (context, <LogModel> logs, child) {
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                  ),
                  content: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          MyCardSingleOption(
                            id: "medication",
                            name: "Add Medication",
                            listData: _medication,
                            mycallback: medicationCallback,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextField(
                              controller: doseController,
                              decoration: InputDecoration(labelText: "Dose"),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: TextField(
                              controller: timeController,
                              decoration: InputDecoration(labelText: "Time"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                              ),
                              color: Colors.lightGreen,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Text(
                                "ADD MEDICINE",
                                style: TextStyle(fontSize: 16),
                              ),
                              onPressed: () {
                                _index = _items.length;
                                _items.insert(
                                  _index,
                                  Medication(
                                      index: _index,
                                      name: listMedicine.length > 0
                                          ? listMedicine[0]
                                          : "",
                                      timestamp: timeController.text,
                                      dose: doseController.text),
                                );
                                _listKey.currentState.insertItem(_index);
                                _index++;
                                // _items.length
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      // bo
    );
  }

  _buildAnimatedList(_items) {
    return AnimatedList(
      key: _listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: MedicationCard(
              currentState: _listKey.currentState,
              items: _items,
              index: (index + 1).toString(),
              name: _items[index].name,
              timestamp: _items[index].timestamp,
              dose: _items[index].dose),
        );
      },
    );
  }
}

class MedicationCard extends StatelessWidget {
  final currentState;
  final List<Medication> items;
  final index;
  final name;
  final timestamp;
  final dose;

  MedicationCard(
      {this.index,
      this.name,
      this.timestamp,
      this.dose = "",
      this.items,
      this.currentState});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          index,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.grey.withOpacity(0.9),
          ),
        ),
        title: Text("Medicine name: " + name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            items.removeAt(int.parse(index) - 1);
            currentState.removeItem(
                int.parse(index) - 1,
                (context, animation) => MedicationCard(
                      index: index,
                      dose: dose,
                      name: name,
                      timestamp: timestamp,
                    ));
          },
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Dose: " + dose), Text(timestamp)],
        ),
      ),
    );
  }
}

class MedicationModel {
  final index;
  final name;
  final timestamp;
  final dose;

  MedicationModel({this.index, this.name, this.timestamp, this.dose});
}
