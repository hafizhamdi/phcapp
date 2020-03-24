import 'package:flutter/widgets.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/label.dart';
import 'package:phcapp/custom/input.dart';
import 'package:flutter/material.dart';

class PatientInfo extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ListView(
          children: <Widget>[
            HeaderSection("Patient Information"),
            Label("Name", ""),
            Input("Muhamad Iskandar", ""),
            Label("ID No.", "Document Type"),
            Input("850229011919", "NRIC"),
            // Label("",""),
            // Input("Muhamad Iskandar", ""),
            Label("Date of Birth", "Age"),
            Input("29-02-1985", "35 yrs old"),
            Label("Gender", ""),
            Input("Male", ""),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('EDIT'),
          icon: Icon(Icons.edit),
          backgroundColor: Colors.purple,
        ));
  }
}
