import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
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
const LIST_IDTYPE = [
  "Old IC",
  "Military ID",
  "Police ID",
  "New IC",
  "Work Permit",
  "Passport",
  "Birth Certificate",
  "Pensioner card",
  "My PR",
  "UNHCR"
];

class PatientInformationScreen extends StatefulWidget {
  PatientInformation patient_information;
  PatientInformationScreen({this.patient_information});
  _Information createState() => _Information();
}

class _Information extends State<PatientInformationScreen>
    with AutomaticKeepAliveClientMixin<PatientInformationScreen> {
  @override
  bool get wantKeepAlive => true;
  TextEditingController nameController = new TextEditingController();
  TextEditingController idNoController = new TextEditingController();
  TextEditingController idTypeController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  String idType;

  PatientBloc patientBloc;

  // @override
  // initState() {

  // nameController.text = widget.patient_information.nama;
  // idNoController.text = widget.patient_information.id_no;
  // idTypeController.text = widget.patient_information.id_type;
  // ageController.text = widget.patient_information.age;
  // genderController.text = widget.patient_information.jantina;
  // dobController.text = widget.patient_information.dateOfBirth;
  // }

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

  var dobFormater = MaskTextInputFormatter(
      mask: "##/##/####", filter: {"#": RegExp(r'[a-zA-Z0-9]')});

  convertDOBtoStandard(data) {
    print("CONVERT DOB");
    if (data == null) return null;

    var split = data.split('-');
    var yyyy = split[0];
    var MM = split[1];
    var dd = split[2];

    print(data);
    // print("$yyyy-$MM-$dd");
    print("$dd/$MM/$yyyy");
    return "$dd/$MM/$yyyy";
  }

  @override
  build(BuildContext context) {
    final patProvider = Provider.of<PatInfoProvider>(context);

    patientBloc = BlocProvider.of<PatientBloc>(context);

    patProvider.setName = widget.patient_information.name;
    patProvider.setId = widget.patient_information.idNo;
    patProvider.setIdType = widget.patient_information.idType;
    patProvider.setAge = widget.patient_information.age;
    patProvider.setDob = convertDOBtoStandard(widget.patient_information.dob);
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
                      _textInput("Name", patProvider.nameController,
                          nameValidator, null),

                      DropDownList("Document Type", LIST_IDTYPE,
                          InputSelector.idtype, patProvider.getIdtype),
                      _idInputCalculated(
                          context,
                          "ID No.",
                          patProvider.idController,
                          idValidator,
                          patProvider.ageController,
                          patProvider.dobController),
                      // _textInput("Document Type", idTypeController),
                      _textInput("Date of Birth", patProvider.dobController,
                          dobValidator, dobFormater),
                      _textInput(
                          "Age", patProvider.ageController, ageValidator, null),
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

  String nameValidator(value) {
    if (value.isEmpty) {
      return 'Enter Name is required';
    }
    return null;
  }

  String idValidator(value) {
    if (value.isEmpty) {
      return 'Enter ID number is required';
    }
    return null;
  }

  String dobValidator(value) {
    if (value.isEmpty) {
      return 'Enter Date of birth is required';
    }
    return null;
  }

  String ageValidator(value) {
    if (value.isEmpty) {
      return 'Enter Age is required';
    }
    return null;
  }

  String genderValidator(value) {
    if (value.isEmpty) {
      return 'Enter Gender is required';
    }
    return null;
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

  Widget _textInput(labelText, controller, validator, formater) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                controller: controller,
                inputFormatters: formater != null ? [formater] : [],
                validator: validator,
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }

  Widget _idInputCalculated(
      context, labelText, controller, validator, ageController, dobController) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                controller: controller,
                // inputFormatters: formater != null ? [formater] : [],
                validator: (value) {
                  if (idType == "NRIC") {
                    if (value.length != 12) {
                      return "Enter valid NRIC number";
                    }
                  }
                  return null;
                },
                onEditingComplete: () {
                  print(controller.text);
                  // print(value);
                  // print(idType);

                  // final patProvider = Provider.of<PatInfoProvider>(context);
                  // final idType = patProvider.getIdtype;
                  // // final stream = getStreamController(idType);
                  // print(idType);
                  // print("HELLO");
                  // if (idType == "NRIC") {
                  print(controller.text.length);
                  if (controller.text.length > 6) {
                    print("inside controller lenght");
                    String idNo = controller.text.substring(0, 6);
                    // idNo = idNo;
                    String year = idNo.substring(0, 2);
                    String month = idNo.substring(2, 4);
                    String day = idNo.substring(4, 6);

                    print(idNo);
                    print(year);
                    print(month);
                    print(day);
                    var nyear;
                    if (int.parse(year) > 20) {
                      nyear = "19" + year;
                    } else {
                      nyear = "20" + year;
                    }

                    String dob = "$day/$month/$nyear";

                    dobController.text = dob;

                    var ndate = DateTime(
                        int.parse(nyear), int.parse(month), int.parse(day));
                    var now = DateTime.now();

                    var diff = now.difference(ndate).inDays;
                    var totalYear = diff / 365;
                    print("TOTAL YEARS THIS PERSION: $totalYear");

                    var rounded = totalYear.round();
                    print(rounded);
                    ageController.text = rounded.toString();
                  }
                  // }
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                    hintText: "800128016139",
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

class MyTextInput extends StatelessWidget {
  final labelText;
  final controller;
  final validator;
  final formater;
  final Function onChanged;

  MyTextInput(
      {this.labelText,
      this.controller,
      this.validator,
      this.formater,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      width: 500,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: TextFormField(
          controller: controller,
          inputFormatters: formater != null ? [formater] : [],
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
      ),
    );
  }
}
