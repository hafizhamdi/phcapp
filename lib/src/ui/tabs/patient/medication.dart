import 'package:flutter/material.dart';

class Medication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Medication"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            // Navigator.push(
            // context, MaterialPageRoute(builder: (context) => PatientTab()));
            // Add your onPressed code here!
          },
          // label: Text('ADD PATIENT'),
          // icon: Icon(Icons.add),
          // backgroundColor: Colors.purple,
        ));
  }
}
