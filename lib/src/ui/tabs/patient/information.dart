import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/label.dart';
import 'package:phcapp/custom/input.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';

class PatientInformationScreen extends StatefulWidget {
  PatientInformation patient_information;
  PatientInformationScreen({this.patient_information});
  _Information createState() => _Information();
}

class _Information extends State<PatientInformationScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController idNoController = new TextEditingController();
  TextEditingController idTypeController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  PatientBloc patientBloc;

  @override
  initState() {
    patientBloc = BlocProvider.of<PatientBloc>(context);

    nameController.text = "";
    idNoController.text = "";
    idTypeController.text = "";
    ageController.text = "";
    genderController.text = "";
    dobController.text = "";
  }

  @override
  void dispose() {
    // patientBloc.close();

    super.dispose();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
              child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      HeaderSection("Patient Information"),
                      _textInput("Name", nameController),
                      _textInput("ID No.", idNoController),
                      _textInput("Document Type", idTypeController),
                      _textInput("Date of Birth", dobController),
                      _textInput("Age", ageController),
                      _textInput("Gender", genderController),
                    ],
                  )))),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   label: Text('EDIT'),
      //   icon: Icon(Icons.edit),
      //   // backgroundColor: Colors.purple,
      // )
    );
  }
}

Widget _textInput(labelText, controller) {
  return Container(
      // width: 500,
      width: 500,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  labelText: labelText,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: new BorderSide(),
                  )))));
}
