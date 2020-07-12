import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:phcapp/src/providers/patinfo_provider.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/sampler_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/patient_tab.dart';
import 'package:provider/provider.dart';
// import 'package:phcapp/custom/label.dart';
// import 'package:phcapp/custom/input.dart';
import '../../models/phc.dart';
// import 'package:phcapp/src/tab_screens/patient_screens/main.dart';

const _otherServices = [
  "APM",
  "EMRS",
  "Red cresent",
  "St. John ambulance",
  "Private",
  "Supervisor vehicle",
];

const _ppe = ["Gown", "Glove", "Mask", "Safety Helmet", "Faceshield"];

const _environment = [
  "Safe",
  "Unsafe",
];
const _trauma = [
  "Trauma",
  "Non-Trauma",
];
const _patient = [
  "Single",
  "Multiple",
];
const _backup = [
  "Required",
  "Not Required",
];

class PatientListScreen extends StatefulWidget {
  final assign_id;
  final SceneAssessment sceneAssessment;
  final List<Patient> patients;

  PatientListScreen({this.assign_id, this.patients, this.sceneAssessment});
  _Patients createState() => _Patients();
}

class _Patients extends State<PatientListScreen>
    with AutomaticKeepAliveClientMixin<PatientListScreen> {
  @override
  bool get wantKeepAlive => true;
  // List<PatientModel> patients = <PatientModel>[
  //   PatientModel(name: "Abu Bakar malik bin marwan", age: "45", gender: "Male"),
  //   PatientModel(name: "Abu Bakar", age: "45", gender: "Male"),
  //   PatientModel(name: "Abu Bakar", age: "45", gender: "Female"),
  //   PatientModel(name: "Abu Bakar", age: "45", gender: "Male"),
  // ];

  PatientBloc patientBloc;
  List<String> wantedList;

  TextEditingController ppeOtherController = TextEditingController();
  TextEditingController otherServicesController = TextEditingController();
  SceneBloc sceneBloc;
  // CprBloc cprBloc;

  // @override
  // initState() {
  //   patientBloc = BlocProvider.of<PatientBloc>(context);

  //   patientBloc.add(LoadPatient(assign_id: widget.assign_id));
  // }

  @override
  void didChangeDependencies() {
    // cprBloc = BlocProvider.of<CprBloc>(context);

    // if (widget.patients != null) {
    // patientBloc.add(LoadPatient(
    //     assign_id: widget.assign_id,
    //     sceneAssessment: widget.sceneAssessment,
    //     patients: patientBloc.state.patients != null
    //         ? patientBloc.state.patients
    //         : widget.patients));
    // } else {
    //   patientBloc.add(LoadPatient(
    //       assign_id: widget.assign_id,
    //       patients: List<Patient>(),
    //       sceneAssessment: widget.sceneAssessment));
    // }

    super.didChangeDependencies();
  }

  @override
  dispose() {
    // patientBloc.close();
    super.dispose();
  }

  _buildSceneChips(
      header, List<String> list, callback, initialData, otherController) {
    return Container(
      // width: 500,
      margin: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
            title: Padding(
              child: Text(header),
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SingleOption(
                    header: header,
                    stateList: list,
                    callback: callback,
                    multiple: true,
                    initialData: initialData),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    controller: otherController,
                    decoration: InputDecoration(
                      labelText: "Other separated with comma(,)",
                    ),
                  ),
                )
              ],
            )
            //  Wrap(
            //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            // ],
            // ),
            ),
      ),
    );
  }

  _defaultChips(header, List<String> list, callback, initialData) {
    return Container(
      // width: 500,
      margin: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
          title: Padding(
            child: Text(header),
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          subtitle:
              //  Wrap(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              SingleOption(
                  header: header,
                  stateList: list,
                  callback: callback,
                  multiple: false,
                  initialData: initialData),
          // ],
          // ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patientBloc = BlocProvider.of<PatientBloc>(context);

    // final patientBloc = Provider

    void nothingCallback(String item, List<String> selectedItems) {}
    void callback(String item, List<String> selectedItems) {
      if (item == "Other services at scene") {
        setState(() {
          wantedList = selectedItems;
        });
        sceneBloc = BlocProvider.of<SceneBloc>(context);

        sceneBloc.add(LoadScene(selectedServices: wantedList));
        print("callback");
        print(selectedItems.length.toString());
      }

      // patientBloc.add(LoadPatient(
      //     assign_id: widget.assign_id,
      //     patients: patientBloc.state.patients,
      //     sceneAssessment:
      //         SceneAssessment(otherServicesAtScene: selectedItems)));
    }

    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Container(
        // padding: EdgeInsets.symmetric(vertical: 40),
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            margin: EdgeInsets.only(left: 12.0, right: 12, top: 40, bottom: 12),
            child: Container(
              padding: EdgeInsets.all(10),
              // height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BlocBuilder<SceneBloc, SceneState>(
                    builder: (context, state) {
                      if (state is LoadedScene) {
                        return Column(children: [
                          HeaderSection("Scene Assessment"),
                          // Container(
                          //   height: 1,
                          //   color: Colors.grey,
                          // ),
                          SizedBox(
                            height: 10,
                          ),

                          _buildSceneChips("PPE", _ppe, nothingCallback,
                              state.selectedServices, ppeOtherController),
                          _defaultChips("Environment", _environment,
                              nothingCallback, state.selectedServices),
                          _defaultChips("Case Type", _trauma, nothingCallback,
                              state.selectedServices),
                          _defaultChips("Patient", _patient, nothingCallback,
                              state.selectedServices),
                          _defaultChips("Backup", _backup, nothingCallback,
                              state.selectedServices),
                          _buildSceneChips(
                              "Other services at scene",
                              _otherServices,
                              callback,
                              state.selectedServices,
                              otherServicesController),
                        ]);
                      }
                      return Column(children: [
                        HeaderSection("Scene Assessment"),
                        // Container(
                        //   height: 1,
                        //   color: Colors.grey,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildSceneChips("PPE", _ppe, nothingCallback,
                            state.selectedServices, ppeOtherController),
                        _defaultChips("Environment", _environment,
                            nothingCallback, state.selectedServices),
                        _defaultChips("Case Type", _trauma, nothingCallback,
                            state.selectedServices),
                        _defaultChips("Patient", _patient, nothingCallback,
                            state.selectedServices),
                        _defaultChips("Backup", _backup, nothingCallback,
                            state.selectedServices),
                        _buildSceneChips(
                            "Other services at scene",
                            _otherServices,
                            callback,
                            widget.sceneAssessment !=
                                    null //widget.sceneAssessment.otherServicesAtScene
                                ? widget.sceneAssessment.otherServicesAtScene
                                : null,
                            otherServicesController),
                      ]);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<PatientBloc, PatientState>(
                      builder: (context, state) {
                    if (state is PatientLoaded) {
                      print("Patient Loaded");
                      return BuildPatientList(
                        patientList: state.patients,
                      );
                    }
                    return BuildPatientList(
                      patientList: widget.patients,
                    );
                  }),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   heroTag: 8,
      //   onPressed: () {
      //     // BlocProvider.of(context);
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) {
      //           // final patientBloc = BlocProvider.of<PatientBloc>(context);
      //           // patientBloc.add(InitPatient());
      //           final vitalBloc = BlocProvider.of<VitalBloc>(context);
      //           vitalBloc.add(ResetVital());

      //           final interBloc = BlocProvider.of<InterBloc>(context);
      //           interBloc.add(ResetInter());

      //           final patBloc = BlocProvider.of<AssPatientBloc>(context);
      //           patBloc.add(ResetAssPatient());

      //           final traumaBloc = BlocProvider.of<TraumaBloc>(context);
      //           traumaBloc.add(ResetTrauma());

      //           final medicationBloc = BlocProvider.of<MedicationBloc>(context);
      //           medicationBloc.add(ResetMedication());
      //           final reportingBloc = BlocProvider.of<ReportingBloc>(context);
      //           reportingBloc.add(ResetReporting());
      //           final outcomeBloc = BlocProvider.of<OutcomeBloc>(context);
      //           outcomeBloc.add(ResetOutcome());

      //           // setState(() {
      //           // final cprlog = Provider.of<CPRProvider>(context);
      //           // cprlog.resetLogs();
      //           // });

      //           return PatientTab(
      //             patient: new Patient(
      //               patientInformation: new PatientInformation(),
      //               // vitalSigns: []
      //             ),
      //           );
      //         },
      //       ),
      //     );
      //     // Add your onPressed code here!
      //   },
      //   label: Text('ADD PATIENT NOTE'),
      //   icon: Icon(Icons.add),
      //   // backgroundColor: Colors.purple,
      // ),
    );

    // ],)

    //     // bloc: patientBloc,
    //     builder: (context, state) {
    //   final currentState = state;
    //   // print("WHAT ABOUT THIS");
    // print(currentState);
    // if (state is PatientEmpty) {
    //   BlocProvider.of<PatientBloc>(context).add(LoadPatient(
    //       assign_id: widget.assign_id,
    //       sceneAssessment: widget.sceneAssessment,
    //       patients: patientBloc.state.patients != null
    //           ? patientBloc.state.patients
    //           : widget.patients));
    // } else

    // if (state is PatientLoaded) {
// Container(
//                         // width: 500,
//                         // padding: EdgeInsets.only(bottom: 10),
//                         child: ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           // addRepaintBoundaries: false,
//                           shrinkWrap: true,
//                           // ke: ,
//                           // padding: EdgeInsets.all(30),
//                           itemCount: currentState.patients.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return _buildPatient(
//                                 currentState.patients[index].patientInformation,
//                                 PatientTab(
//                                     patient: currentState.patients[index],
//                                     index: index));
//                           },
//                         )
//                         // }
// // },
//                         )
    // },),},
    // ,
    //     floatingActionButton:

    //         // Stack(
    //         //   children: [
    //         //     Padding(
    //         //         padding: EdgeInsets.only(bottom: 70),
    //         //         child: Align(
    //         //             alignment: Alignment.bottomRight,
    //         //             child:

    //         FloatingActionButton.extended(
    //       heroTag: 8,
    //       onPressed: () {
    //         // BlocProvider.of(context);
    //         Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => PatientTab(
    //                       patient: new Patient(
    //                           patientInformation: new PatientInformation()),
    //                     )));
    //         // Add your onPressed code here!
    //       },
    //       label: Text('ADD PATIENT'),
    //       icon: Icon(Icons.add),
    //       // backgroundColor: Colors.purple,
    //     ),

    //     // ),),
    //     //   Align(
    //     //     alignment: Alignment.bottomRight,
    //     //     child: FloatingActionButton(
    //     //       heroTag: 4,
    //     //       onPressed: () {
    //     //         patientBloc.add(AddSceneAssessment(
    //     //             patients: patientBloc.state.patients,
    //     //             sceneAssessment:
    //     //                 SceneAssessment(otherServicesAtScene: wantedList)));

    //     //         // print(patientBloc.state.patients);
    //     //         // print(patientBloc.sceneAssessment.toJson());
    //     //         final snackBar = SnackBar(
    //     //           content: Text("Scene Assessment has been saved!"),
    //     //         );
    //     //         Scaffold.of(context).showSnackBar(snackBar);
    //     //       },
    //     //       child: Icon(Icons.save),
    //     //     ),
    //     //   ),
    //     // ],
    //     // ),
  }
}

class BuildPatientList extends StatelessWidget {
  final patientList;

  BuildPatientList({this.patientList});

  @override
  Widget build(BuildContext context) {
    final cprBloc = BlocProvider.of<CprBloc>(context);
    _buildPatient(data, route) {
      var callInfo = data.patientInformation;
      var vital_length =
          data.vitalSigns != null ? data.vitalSigns.length : null;

      return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.grey, width: 0.5)),

        //  return   Container(
        // color: Colors.grey[200],
        child:

            // ListTile(
            //   leading: Icon(Icons.face
            ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                leading: Icon(Icons.face),
                title: Text(callInfo.name != null ? callInfo.name : "Not set",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontFamily: "Raleway")),
                subtitle: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(children: <Widget>[
                          Icon(
                            Icons.accessibility_new,
                            color: Colors.purple,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            (callInfo.age != null ? callInfo.age : "0") +
                                " yrs (" +
                                (callInfo.gender != null
                                    ? callInfo.gender.substring(0, 1)
                                    : 'N') +
                                ")",
                            style: TextStyle(fontFamily: "Arial"),
                          )
                        ])),
                        Expanded(
                            child: Row(children: <Widget>[
                          Icon(
                            Icons.favorite,
                            color: vital_length != null
                                ? Colors.purple
                                : Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            (vital_length != null
                                    ? vital_length.toString()
                                    : "0") +
                                " vitals",
                            style: TextStyle(fontFamily: "Arial"),
                          )
                        ])),
                      ],
                    ),
                    padding: EdgeInsets.only(right: 20)),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  //  onPressed: () {
                  cprBloc.add(
                    LoadCpr(
                      cprLog: data.cprLog != null
                          ? data.cprLog
                          : new CprLog(
                              witnessCpr: new Cpr(),
                              bystanderCpr: new Cpr(),
                              cprStart: new Cpr(),
                              cprStop: new Cpr(),
                              rosc: new Cpr(),
                              rhythmAnalysis: []),
                    ),
                  );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => route));

                  // Add your onPressed code here!
                }
                // },
                ),
      );

      // return Container(
      //   // child: Container(
      //   // width: 500,
      //   child: Card(
      //     // color: Colors.purple[100],
      //     margin: EdgeInsets.only(
      //       top: 10,
      //       left: 10,
      //       right: 10,
      //     ),
      //     child: ListTile(
      //         leading: Icon(Icons.face),
      //         title: Text(callInfo.name != null ? callInfo.name : "Not set",
      //             overflow: TextOverflow.ellipsis,
      //             style: TextStyle(
      //                 fontWeight: FontWeight.bold, fontFamily: "Raleway")),
      //         subtitle: Container(
      //             child: Row(
      //               children: <Widget>[
      //                 Expanded(
      //                     child: Row(children: <Widget>[
      //                   Icon(
      //                     Icons.accessibility_new,
      //                     color: Colors.purple,
      //                     size: 20,
      //                   ),
      //                   Text(
      //                     (callInfo.age != null ? callInfo.age : "0") +
      //                         " yrs (" +
      //                         (callInfo.gender != null
      //                             ? callInfo.gender.substring(0, 1)
      //                             : 'N') +
      //                         ")",
      //                     style: TextStyle(fontFamily: "Arial"),
      //                   )
      //                 ])),
      //               ],
      //             ),
      //             padding: EdgeInsets.only(right: 20)),
      //         trailing: Icon(Icons.arrow_forward_ios),
      //         onTap: () {
      //           //  onPressed: () {
      //           cprBloc.add(
      //             LoadCpr(
      //               cprLog: data.cprLog != null
      //                   ? data.cprLog
      //                   : new CprLog(
      //                       witnessCpr: new Cpr(),
      //                       bystanderCpr: new Cpr(),
      //                       cprStart: new Cpr(),
      //                       cprStop: new Cpr(),
      //                       rosc: new Cpr(),
      //                       rhythmAnalysis: []),
      //             ),
      //           );
      //           Navigator.push(
      //               context, MaterialPageRoute(builder: (context) => route));

      //           // Add your onPressed code here!
      //         }
      //         // },
      //         ),
      //   ),
      //   // )
      //   // )
      // );
    }

    badgeCircle(count) => Container(
          width: 25,
          height: 25,
          decoration:
              BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
          child: Center(
              child: Text(
            "${count}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          )),
        );

    // return
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              HeaderSection("Patients Note"),
              Positioned(
                child:
                    badgeCircle(patientList != null ? patientList.length : 0),
                right: 0,
                top: 0,
                width: 20,
              ),
            ],
          ),
        ),
        (patientList != null)
            ? Container(
                // width: 500,
                // padding: EdgeInsets.only(bottom: 10),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    // addRepaintBoundaries: false,
                    shrinkWrap: true,
                    // ke: ,
                    // padding: EdgeInsets.all(30),
                    itemCount: patientList.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final vitalBloc = BlocProvider.of<VitalBloc>(context);
                      // vitalBloc.add(
                      //     LoadVital(listVitals: patientList[index].vitalSigns));
                      // Patient()

                      // cprBloc.add(
                      //   LoadCpr(
                      //     cprLog: patientList[index].cprLog != null
                      //         ? patientList[index].cprLog
                      //         : new CprLog(
                      //             witnessCpr: new Cpr(),
                      //             bystanderCpr: new Cpr(),
                      //             cprStart: new Cpr(),
                      //             cprStop: new Cpr(),
                      //             rosc: new Cpr(),
                      //             rhythmAnalysis: []),
                      //   ),
                      // );
                      return _buildPatient(
                        patientList[index],
                        PatientTab(patient: patientList[index], index: index),
                      );
                    }),
              )
            : Container(
                child: Text(
                  "No patient note",
                  style: TextStyle(color: Colors.grey, fontFamily: "OpenSans"),
                ),
              ),
        SizedBox(
          height: 10,
        ),
        RaisedButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          icon: Icon(Icons.add, color: Colors.blueAccent),
          label: Text(
            "ADD PATIENT NOTE",
            style: TextStyle(color: Colors.blueAccent),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  // final patientBloc = BlocProvider.of<PatientBloc>(context);
                  // patientBloc.add(InitPatient());
                  final vitalBloc = BlocProvider.of<VitalBloc>(context);
                  vitalBloc.add(ResetVital());

                  final interBloc = BlocProvider.of<InterBloc>(context);
                  interBloc.add(ResetInter());

                  final patBloc = BlocProvider.of<AssPatientBloc>(context);
                  patBloc.add(ResetAssPatient());

                  final traumaBloc = BlocProvider.of<TraumaBloc>(context);
                  traumaBloc.add(ResetTrauma());

                  final medicationBloc =
                      BlocProvider.of<MedicationBloc>(context);
                  medicationBloc.add(ResetMedication());
                  final reportingBloc = BlocProvider.of<ReportingBloc>(context);
                  reportingBloc.add(ResetReporting());
                  final outcomeBloc = BlocProvider.of<OutcomeBloc>(context);
                  outcomeBloc.add(ResetOutcome());

                  final samplerBloc = BlocProvider.of<SamplerBloc>(context);
                  samplerBloc.add(ResetSampler());

                  final cprBloc = BlocProvider.of<CprBloc>(context);

                  cprBloc.add(ResetCprLog());
                  cprBloc.add(
                    LoadCpr(
                      cprLog: new CprLog(
                          witnessCpr: new Cpr(),
                          bystanderCpr: new Cpr(),
                          cprStart: new Cpr(),
                          cprStop: new Cpr(),
                          rosc: new Cpr(),
                          rhythmAnalysis: []),
                    ),
                  );
                  // cprBloc.add(ResetCprLog());

                  // setState(() {
                  // final cprlog = Provider.of<CPRProvider>(context);
                  // cprlog.resetLogs();
                  // });

                  return PatientTab(
                    patient: new Patient(
                      patientInformation: new PatientInformation(),
                      // vitalSigns: []
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
    // ;
  }
}
