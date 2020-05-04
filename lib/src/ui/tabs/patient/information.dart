import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/label.dart';
import 'package:phcapp/custom/input.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/patinfo_provider.dart';
import 'package:provider/provider.dart';

enum InputSelector { gender, idtype }

const LIST_GENDER = ["Male", "Female"];
const LIST_IDTYPE = ["NRIC", "TEMPORARY ID", "POLICE ID"];

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

  String idType;

  PatientBloc patientBloc;

  @override
  initState() {
    patientBloc = BlocProvider.of<PatientBloc>(context);

    // nameController.text = widget.patient_information.nama;
    // idNoController.text = widget.patient_information.id_no;
    // idTypeController.text = widget.patient_information.id_type;
    // ageController.text = widget.patient_information.age;
    // genderController.text = widget.patient_information.jantina;
    // dobController.text = widget.patient_information.dateOfBirth;
  }

  @override
  void dispose() {
    // patProvider.idTypeController.close();
    // patProvider.idController.close();
    // patientBloc.patientController.sink.add(new PatientInformation(
    //     name: nameController.text,
    //     age: ageController.text,
    //     idNo: idNoController.text,
    //     idType: idTypeController.text,
    //     gender: genderController.text,
    //     dob: dobController.text));

    // patientBloc.patientController.close();
    // patientBloc.close();

    super.dispose();
  }

  @override
  build(BuildContext context) {
    final patProvider = Provider.of<PatInfoProvider>(context);

    patProvider.setName = widget.patient_information.name;
    patProvider.setId = widget.patient_information.id_no;
    patProvider.setIdType = widget.patient_information.id_type;
    patProvider.setAge = widget.patient_information.age;
    patProvider.setDob = widget.patient_information.dob;
    patProvider.setGender = widget.patient_information.gender;

    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Center(
          child: Card(
              margin: EdgeInsets.all(10.0),
              // child:
              child: Form(
                  key: patProvider.formKey,
                  child: Column(
                    children: <Widget>[
                      HeaderSection("Patient Information"),
                      _textInput("Name", patProvider.nameController),
                      _textInput("ID No.", patProvider.idController),
                      DropDownList("Document Type", LIST_IDTYPE,
                          InputSelector.idtype, patProvider.getIdtype),
                      // _textInput("Document Type", idTypeController),
                      _textInput("Date of Birth", patProvider.dobController),
                      _textInput("Age", patProvider.ageController),
                      DropDownList("Gender", LIST_GENDER, InputSelector.gender,
                          patProvider.gender),

                      // _textInput("Gender", patProvider.genderController),
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
    ));
  }

  StreamController getStreamController(selector) {
    final provider = Provider.of<PatInfoProvider>(context);

    switch (selector) {
      case InputSelector.gender:
        return provider.genderController;
        break;
      case InputSelector.idtype:
        return provider.idTypeController;
        break;
      default:
        return new StreamController();
    }
  }

  Widget _textInput(labelText, controller) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                controller: controller,
                // validator: (){
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some value';
                  }
                  return null;
                  // },
                },
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }

  void setterField(selector, value) {
    final provider = Provider.of<PatInfoProvider>(context);

    switch (selector) {
      case InputSelector.gender:
        provider.setGender = value;
        break;
      case InputSelector.idtype:
        provider.setIdType = value;
        break;
      default:
        break;
    }
  }

  Widget DropDownList(labelText, List<String> list, selector, initialData) {
    final controller = getStreamController(selector);

    print(selector);
    print(initialData);
    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: controller.stream.asBroadcastStream(),
                initialData: initialData,
                builder: (context, snapshot) {
                  print("Streambuilder value");
                  print(snapshot.data);

                  // setInputOption(selector, snapshot.data);
                  // child:

                  setterField(selector, snapshot.data); // {

                  return DropdownButtonFormField(
                      isDense: true,
                      items: list.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem);
                      }).toList(),
                      onChanged: (valueChanged) {
                        print("WHATS IS INDESIDE:$valueChanged");
                        controller.sink.add(valueChanged);
                      },
                      value: snapshot.data,
                      validator: (value) {
                        print("DROPDOWNVALUE");
                        print(value);
                        if (value == null) {
                          return 'Please choose option';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: labelText,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          )));
                })));
  }
}
