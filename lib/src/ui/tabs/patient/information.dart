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
  TextEditingController nameController = new TextEditingController();
  TextEditingController idNoController = new TextEditingController();
  TextEditingController idTypeController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  String idType;
  String idHintText;

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
          padding: EdgeInsets.symmetric(vertical: 40),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                margin: EdgeInsets.all(12.0),
                child: Form(
                  key: patientBloc.formKey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        HeaderSection("Patient Information"),
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
                                patProvider.genderController),
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
          )
          // floatingActionButton: FloatingActionButton.extended(
          //   onPressed: () {
          //     // Add your onPressed code here!
          //   },
          //   label: Text('EDIT'),
          //   icon: Icon(Icons.edit),
          //   // backgroundColor: Colors.purple,
          // )
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
                  print("idtype: $idType");
                  print(controller.text);
                  if (controller.text.length == 12) {
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

                    //to set Gender
                    print(controller.text.substring(11));
                    if (int.parse(controller.text.substring(11)) % 2 == 0) {
                      genderController.sink.add("Female");
                    } else {
                      genderController.sink.add("Male");
                    }
                  } else {
                    dobController.clear();
                    ageController.clear();
                  }
                },
                // onEditingComplete: () {
                //   print(controller.text);
                // print(value);
                // print(idType);

                // final patProvider = Provider.of<PatInfoProvider>(context);
                // final idType = patProvider.getIdtype;
                // // final stream = getStreamController(idType);
                // print(idType);
                // print("HELLO");
                // if (idType == "NRIC") {
                //   print(controller.text.length);
                //   if (controller.text.length > 6) {
                //     print("inside controller lenght");
                //     String idNo = controller.text.substring(0, 6);
                //     // idNo = idNo;
                //     String year = idNo.substring(0, 2);
                //     String month = idNo.substring(2, 4);
                //     String day = idNo.substring(4, 6);

                //     print(idNo);
                //     print(year);
                //     print(month);
                //     print(day);
                //     var nyear;
                //     if (int.parse(year) > 20) {
                //       nyear = "19" + year;
                //     } else {
                //       nyear = "20" + year;
                //     }

                //     String dob = "$day/$month/$nyear";

                //     dobController.text = dob;

                //     var ndate = DateTime(
                //         int.parse(nyear), int.parse(month), int.parse(day));
                //     var now = DateTime.now();

                //     var diff = now.difference(ndate).inDays;
                //     var totalYear = diff / 365;
                //     print("TOTAL YEARS THIS PERSION: $totalYear");

                //     var rounded = totalYear.round();
                //     print(rounded);
                //     ageController.text = rounded.toString();
                //   }
                //   // }
                //   FocusScope.of(context).unfocus();
                // },

                decoration: InputDecoration(
                    hintText: idHintText,
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
        // width: 500,
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
                        print("initialData: $initialData");

                        print("WHATS IS INDESIDE:$valueChanged");
                        controller.sink.add(valueChanged);
                        setState(() {
                          idType = valueChanged;
                          if (idType == "New IC") {
                            idHintText = "800128016139";
                          } else if (idType == "Old IC") {
                            idHintText = "43111520";
                          } else if (idType == "Passport") {
                            idHintText = "A00000000";
                          } else if (idType == "Birth Certificate") {
                            idHintText = "PK031612";
                          } else if (idType == "Police ID") {
                            idHintText = "RF154190";
                          } else if (idType == "Military ID") {
                            idHintText = "1149282";
                          } else if (idType == "Temporary ID") {
                            idHintText = "HRPBD060725B21";
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
          autovalidate: true,
          onChanged: (String text) {
            print(controller.text);

            var sliceDate = controller.text.split("/");
            print(sliceDate.length);
            if (sliceDate.length == 3) {
              var day = sliceDate[0];
              var month = sliceDate[1];
              var year = sliceDate[2];

              var ndate =
                  DateTime(int.parse(year), int.parse(month), int.parse(day));
              var now = DateTime.now();

              var diff = now.difference(ndate).inDays;
              var totalYear = diff / 365;
              print("TOTAL YEARS THIS PERSION: $totalYear");

              var rounded = totalYear.round();
              print(rounded);
              ageController.text = rounded.toString();
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
