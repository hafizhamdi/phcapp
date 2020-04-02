import 'package:flutter/material.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/label.dart';
import 'package:phcapp/custom/input.dart';
import 'package:phcapp/src/tab_screens/patient_screens/main.dart';

const _otherServices = [
  "Civil defence",
  "Fire rescue",
  "Red cresent",
  "St. John ambulance",
  "Private",
  "Police",
  "Supervisor vehicle"
];

class Patients extends StatelessWidget {
  Widget _buildSceneChips(header, list, callback) {
    return Container(
        width: 500,
        margin: EdgeInsets.all(10),
        child: Card(
            child: ListTile(
          title: Padding(
              child: Text(header),
              padding: EdgeInsets.symmetric(vertical: 10.0)),
          subtitle:
              //  Wrap(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              SingleOption(header: header, stateList: list, callback: callback),
          // ],
          // ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    void callback(String item, int index) {}

    // void callback(String item) {}
    // TODO: implement build
    return Scaffold(
        // backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            child: Card(
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    HeaderSection("Scene Assessment"),
                    _buildSceneChips(
                        "Other services at scene", _otherServices, callback),
                    // Label("Other services at scene", ""),
                    // SingleOption(_otherServices, callback),
                    HeaderSection("Patients"),
                    Card(
                      // color: Colors.purple[100],
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: ListTile(
                        leading: Icon(Icons.face),
                        title: Text("Malik Noor",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: Row(children: <Widget>[
                                  Icon(
                                    Icons.accessibility_new,
                                    color: Colors.purple,
                                  ),
                                  Text("51 yrs (M)")
                                ])),
                                // Expanded(
                                //     child: Row(children: <Widget>[
                                //   Icon(Icons.flag, color: Colors.purple),
                                //   Text("Green I")
                                // ])),
                              ],
                            ),
                            padding: EdgeInsets.only(right: 20)),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                    Card(
                      // color: Colors.purple[100],
                      margin: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 100),
                      child: ListTile(
                          leading: Icon(Icons.face),
                          title: Text("Siti Hanafiah",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Row(children: <Widget>[
                                    Icon(
                                      Icons.accessibility_new,
                                      color: Colors.purple,
                                    ),
                                    Text("23 yrs (F)")
                                  ])),
                                  Expanded(
                                      child: Row(children: <Widget>[
                                    Icon(Icons.flag, color: Colors.purple),
                                    Text("Green II")
                                  ])),
                                ],
                              ),
                              padding: EdgeInsets.only(right: 20)),
                          trailing: Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Patient()));
                          }),
                    )
                  ],
                ))),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('ADD PATIENT'),
          icon: Icon(Icons.add),
          // backgroundColor: Colors.purple,
        ));
  }
}
