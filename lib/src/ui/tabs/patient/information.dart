import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/common/commons.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/patinfo_provider.dart';
import 'package:provider/provider.dart';

enum InputSelector { gender, idtype }

const LIST_GENDER = ["Male", "Female", "Unknown"];
const LIST_IDTYPE = [
  "Old IC",
  "Military ID",
  "Police ID",
  "New IC",
  "Passport",
  "Birth Certificate",
  "Temporary ID"
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

  String idType;
  String idHintText;

  PatientBloc patientBloc;
  String docType;
  String gender;

  @override
  void didChangeDependencies() {
    print("I save form");
    patientBloc = BlocProvider.of<PatientBloc>(context);
    if (patientBloc.formKey.currentState != null)
      patientBloc.formKey.currentState.save();
    super.didChangeDependencies();
  }

  var dobFormater = MaskTextInputFormatter(
      mask: "##/##/####", filter: {"#": RegExp(r'[a-zA-Z0-9]')});

  @override
  build(BuildContext context) {
    final patProvider = Provider.of<PatInfoProvider>(context);

    patientBloc = BlocProvider.of<PatientBloc>(context);
    // if (widget.patient_information != null) {
    print(jsonEncode(widget.patient_information));
    patProvider.setName = patProvider.getName != ""
        ? patProvider.getName
        : widget.patient_information.name;
    patProvider.setId =
        // patProvider.getId != ""
        // ?
        widget.patient_information.idNo;
    // : patProvider.getId;
    patProvider.setIdType = patProvider.getIdtype != ""
        ? patProvider.getIdtype
        : widget.patient_information.idType;
    patProvider.setAge = nativeAges(widget.patient_information.dob);
    // patProvider.getAge != ""
    // ?
    // widget.patient_information.age;
    // : patProvider.getAge;
    patProvider.setDob =
        // patProvider.getDob != ""
        // ?
        convertDOBtoStandard(widget.patient_information.dob);
    // : patProvider.getDob;
    patProvider.setGender = patProvider.getGender != ""
        ? patProvider.getGender
        : widget.patient_information.gender;
    print("id type: $docType");
    // }
    return Scaffold(
      // backgroundColor: Colors.grey,

      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
        ),
        // padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 700),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              // child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                margin:
                    EdgeInsets.only(left: 12.0, right: 12, top: 40, bottom: 12),
                child: Form(
                  key: patientBloc.formKey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        HeaderSection("Patient Information"),
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Row(children: [
                            Icon(Icons.info),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                  "Changes of existing Identification No. shall create new record in PHC web",
                                  softWrap: true),
                            ),
                          ]),
                        ),
                        MyTextInput2(
                          labelText: "Name",
                          controller: patProvider.nameController,
                          validator: nameValidator,
                          ageController: patProvider.ageController,
                          // null
                        ),

                        Row(children: [
                          Expanded(
                            child: DropDownList("Document Type", LIST_IDTYPE,
                                InputSelector.idtype, patProvider.getIdtype),
                          ),
                          Expanded(
                            child: _idInputCalculated(
                              context,
                              "ID No.",
                              patProvider.idController,
                              idValidator,
                              patProvider.ageController,
                              patProvider.dobController,
                              patProvider.genderController,
                              // patProvider.getIdtype
                            ),
                          ),
                        ]),
                        // _textInput("Document Type", idTypeController),
                        Row(children: [
                          Expanded(
                            child: MyTextInput2(
                                labelText: "Date of Birth",
                                controller: patProvider.dobController,
                                // validator: dobValidator,
                                ageController: patProvider.ageController,
                                formater: dobFormater,
                                keyboardType: TextInputType.number,
                                hint: "dd/mm/yyyy"),
                          ),
                          Expanded(
                            child: MyTextInput2(
                              labelText: "Age",
                              controller: patProvider.ageController,
                              // validator: ageValidator,
                              ageController: patProvider.ageController,
                              keyboardType: TextInputType.number,
                              // null
                            ),
                          )
                        ]),
                        DropDownList("Gender", LIST_GENDER,
                            InputSelector.gender, patProvider.gender),
                        SizedBox(
                          height: 40,
                        ),
                        // _textInput("Gender", patProvider.genderController),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

  Widget _idInputCalculated(context, labelText, controller, validator,
      ageController, dobController, genderController) {
    return Container(
      // width: 500,
      // width: 500,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: TextFormField(
          autovalidate: true,
          controller: controller,
          // inputFormatters: formater != null ? [formater] : [],
          validator: (value) {
            if (idType == "New IC") {
              if (value.length != 12) {
                return "Enter a valid New IC number";
              }
            } else if (idType == "Old IC") {
              if (value.length > 8) {
                return "Enter a valid Old IC number";
              }
            } else if (idType == "Passport") {
              if (value.length > 20) {
                return "Enter a valid passport number";
              }
            } else if (idType == "Birth Certificate") {
              if (value.length > 20) {
                return "Enter a valid birth certificate number";
              }
            } else if (idType == "Police ID") {
              if (value.length > 20) {
                return "Enter a valid Police ID";
              }
            } else if (idType == "Military ID") {
              if (value.length > 20) {
                return "Enter a valid Military ID";
              }
            } else if (idType == "Temporary Id") {
              if (value.length >= 15) {
                return "Temporary ID cannot more than 15";
              }
            }

            if (value == null && value.isEmpty) {
              return "ID No. is required";
            }

            return null;
          },
          onChanged: (String text) {
            // print("idtype: $idType");
            // print(controller.text);
            if (controller.text.length == 12) {
              //   print("inside controller lenght");
              String idNo = controller.text.substring(0, 6);
              // idNo = idNo;
              String year = idNo.substring(0, 2);
              String month = idNo.substring(2, 4);
              String day = idNo.substring(4, 6);

              var nyear;
              if (int.parse(year) > 40) {
                nyear = "19" + year;
              } else {
                nyear = "20" + year;
              }

              String dob = "$day/$month/$nyear";

              dobController.text = dob;

              var ndate =
                  DateTime(int.parse(nyear), int.parse(month), int.parse(day));
              var now = DateTime.now();

              var diff = now.difference(ndate).inDays;
              var totalYear = diff / 365;
              print("TOTAL YEARS THIS PERSION: $totalYear");

              // var rounded = totalYear;
              // print(rounded);
              ageController.text = calcAge(day, month, nyear);

              //to set Gender
              print(controller.text.substring(11));
              if (int.parse(controller.text.substring(11)) % 2 == 0) {
                // setState(() {
                genderController.sink.add("Female");
                // widget.patient_information.gender = "Female";
                // });
              } else {
                // setState(() {
                genderController.sink.add("Male");
                // widget.patient_information.gender = "Male";
                // });
              }
            } else {
              dobController.clear();
              ageController.clear();
              // genderController.clear();
            }
          },
          decoration: InputDecoration(
            hintText: idHintText,
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
      // width: 500,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: controller.stream.asBroadcastStream(),
          initialData: initialData,
          builder: (context, snapshot) {
            setterField(selector, snapshot.data); // {

            return DropdownButtonFormField(
                isExpanded: true,
                isDense: true,
                items: list.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                      child: Text(
                        dropDownStringItem,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: dropDownStringItem);
                }).toList(),
                onChanged: (valueChanged) {
                  print("initialData: $initialData");

                  print("WHATS IS INDESIDE:$valueChanged");
                  controller.sink.add(valueChanged);
                  setState(() {
                    idType = valueChanged;
                    if (idType == "New IC") {
                      idHintText = "e.g.,800128016139";
                    } else if (idType == "Old IC") {
                      idHintText = "e.g.,43111520";
                    } else if (idType == "Passport") {
                      idHintText = "e.g.,A00000000";
                    } else if (idType == "Birth Certificate") {
                      idHintText = "e.g.,PK031612";
                    } else if (idType == "Police ID") {
                      idHintText = "e.g.,RF154190";
                    } else if (idType == "Military ID") {
                      idHintText = "e.g.,1149282";
                    } else if (idType == "Temporary ID") {
                      idHintText = "e.g.,HRPBD060725B21";
                    }
                  });
                },
                value: snapshot.data,
                validator: (value) {
                  print("DROPDOWNVALUE");
                  print(value);
                  if (value == null && snapshot.data == null) {
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
          },
        ),
      ),
    );
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

class MyTextInput2 extends StatelessWidget {
  final labelText;
  final controller;
  final validator;
  final ageController;
  final formater;
  final keyboardType;
  final hint;

  MyTextInput2(
      {this.labelText,
      this.controller,
      this.validator,
      this.ageController,
      this.formater,
      this.keyboardType,
      this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      // width: 500,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: TextFormField(
          keyboardType: keyboardType,
          controller: controller,
          inputFormatters: formater != null ? [formater] : [],
          validator: validator,
          textCapitalization: TextCapitalization.characters,
          autovalidate: true,
          onChanged: (String text) {
            print(controller.text);

            var sliceDate = controller.text.split("/");
            print(sliceDate.length);
            if (sliceDate.length == 3) {
              var day = sliceDate[0];
              var month = sliceDate[1];
              var year = sliceDate[2];

              ageController.text = calcAge(day, month, year);
            } else {
              ageController.clear();
            }
          },
          decoration: InputDecoration(
            labelText: labelText,
            fillColor: Colors.white,
            hintText: hint,
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
