import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/drop_downlist.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/text_input.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/models/team_model.dart';

// constants
const LIST_RESPONSES = [
  "Select option",
  "999 Primary",
  "999 Secondary",
  "Supervisor Vehicle"
];

const LIST_AGENCIES = [
  "Civil defence",
  "Fire rescue",
  "Red cresent",
  "St John ambulance",
  "Private"
];

// class Team extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // backgroundColor: Colors.grey[200],
//         body: _Team(),
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             // Add your onPressed code here!
//           },
//           label: Text('ADD TEAM'),
//           icon: Icon(Icons.add),
//           // backgroundColor: Colors.purple,
//         ));
//   }
// }

class ResponseTeamScreen extends StatefulWidget {
  final ResponseTeam response_team;

  ResponseTeamScreen({this.response_team});
  // Team();
  _TeamState createState() => _TeamState();
}

class _TeamState extends State<ResponseTeamScreen> {
  String serviceSelected = "Select option";
  TextEditingController vehicleTxtController;
  void serviceCallback(String selected) {
    setState(() {
      serviceSelected = selected;
    });
  }

  @override
  void initState() {
    vehicleTxtController = new TextEditingController();
    vehicleTxtController.text =
        widget.response_team.vehicleRegno; // List<Person> team = <Person>[
    //   Person(name: "Abu Bakar", position: "Medical Assistant"),
    //   Person(name: "Malik Sinai", position: "Driver van"),
    //   Person(name: "Malik Sinai", position: "Driver van"),
    //   Person(name: "Malik Sinai", position: "Driver van")
    // ];
  }

  @override
  Widget build(BuildContext context) {
    Widget circle = new Container(
      width: 25,
      height: 25,
      decoration:
          BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
      child: Center(
          child: Text(
        widget.response_team.staffs.length.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      )),
    );

    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
            // padding: EdgeInsets.all(20),
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
                constraints: BoxConstraints(),
                child: Center(
                    // widthFactor: 2/3,
                    child: Card(
                        margin: EdgeInsets.only(
                            top: 10.0, bottom: 80, left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            HeaderSection("Response Details"),
                            CustomDropDown(
                                labelText: "Type of service response",
                                items: LIST_RESPONSES,
                                callback: serviceCallback,
                                itemSelected: serviceSelected),
                            CustomTextInput(
                                labelText: "Vehicle Registration No",
                                textController: vehicleTxtController),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Stack(children: <Widget>[
                                HeaderSection("Team"),
                                Positioned(
                                  child: circle,
                                  right: 0,
                                  top: 0,
                                  width: 20,
                                ),
                              ]),
                            ),
                            Container(
                                width: 500,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  // addRepaintBoundaries: false,
                                  shrinkWrap: true,
                                  // ke: ,
                                  // padding: EdgeInsets.all(30),
                                  itemCount: widget.response_team.staffs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Card(
                                          child: ListTile(
                                            leading: Icon(Icons.face),
                                            title: Text(
                                              widget.response_team.staffs[index]
                                                  .name,
                                              style: TextStyle(
                                                  fontFamily: "Raleway",
                                                  fontWeight: FontWeight.bold
                                                  // fontSize: 16
                                                  // fontWeight: FontWeight.bold
                                                  ),
                                            ),
                                            subtitle: Text(widget.response_team
                                                .staffs[index].position),
                                            trailing: Icon(Icons.remove_circle),
                                          ),
                                        ));
                                  },
                                )),
                            Padding(
                              padding: EdgeInsets.all(10),
                            )
                          ],
                        ))))),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('ADD STAFF'),
          icon: Icon(Icons.add),
          // backgroundColor: Colors.purple,
        ));
  }
}

class Person {
  Person({this.name, this.position});

  String name;
  String position;
}
