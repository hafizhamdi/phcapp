import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';

// constants
const LIST_RESPONSES = ["999 Primary", "999 Secondary", "Supervisor Vehicle"];

const LIST_AGENCIES = [
  "Civil defence",
  "Fire rescue",
  "Red cresent",
  "St John ambulance",
  "Private"
];

class Team extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: _Team(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('ADD TEAM'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.purple,
        ));
  }
}

class _Team extends StatelessWidget {

  void callback(String item){

  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HeaderSection("Type of Service Response"),
        SingleOption(LIST_RESPONSES,callback),
        HeaderSection("Vehicle Registration No."),
        Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              style: TextStyle(),
            )),
        HeaderSection("Agency"),
        SingleOption(LIST_AGENCIES, callback),
        HeaderSection("Response Team"),
        Card(
          color: Colors.purple[100],
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListTile(
            leading: Icon(Icons.face),
            title: Text(
              "Ahmad Nisfu",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Doctor"),
            trailing: Icon(Icons.remove_circle),
          ),
        ),
        Card(
          color: Colors.purple[100],
          margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 100),
          child: ListTile(
            leading: Icon(Icons.face),
            title: Text("Siti Hanafiah",
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Pegawai Perubatan G12"),
            trailing: Icon(Icons.remove_circle),
          ),
        )
      ],
    );
  }
}
