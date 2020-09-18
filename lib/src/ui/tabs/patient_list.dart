import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/sampler_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/patient_tab.dart';
import '../../models/phc.dart';

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

  PatientBloc patientBloc;
  PPE ppe;
  OtherServices otherServices;
  List<String> ppeList;
  List<String> environmentList;
  List<String> caseTypeList;
  List<String> patientList;
  List<String> backupList;
  List<String> wantedList;

  TextEditingController ppeOtherController = TextEditingController();
  TextEditingController otherServicesController = TextEditingController();
  SceneBloc sceneBloc;
  // CprBloc cprBloc;

  @override
  initState() {}

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
    ppeOtherController.text = widget.sceneAssessment != null
        ? widget.sceneAssessment.ppe != null
            ? widget.sceneAssessment.ppe.otherspecify
            : null
        : null;
    otherServicesController.text = widget.sceneAssessment != null
        ? widget.sceneAssessment.otherServicesAtScene != null
            ? widget.sceneAssessment.otherServicesAtScene.otherspecify
            : null
        : null;

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
                    onChanged: (text) {
                      if (ppeList == null &&
                          widget.sceneAssessment.ppe.ppe == null) {
                        ppeList = new List<String>();
                      }
                      if (wantedList == null &&
                          widget.sceneAssessment.otherServicesAtScene
                                  .otherServices ==
                              null) {
                        wantedList = new List<String>();
                      }
                      final ppe = new PPE(
                          ppe: widget.sceneAssessment.ppe.ppe != null
                              ? widget.sceneAssessment.ppe.ppe
                              : ppeList,
                          otherspecify: ppeOtherController.text);

                      final otherServices = new OtherServices(
                          otherServices: widget.sceneAssessment
                                      .otherServicesAtScene.otherServices !=
                                  null
                              ? widget.sceneAssessment.otherServicesAtScene
                                  .otherServices
                              : wantedList,
                          otherspecify: otherServicesController.text);
                      sceneBloc = BlocProvider.of<SceneBloc>(context);
                      // if(ppeOtherController.text.isNotEmpty){
                      //   ppeList.removeLast();
                      //   ppeList.add(ppeOtherController.text);
                      // }

                      // otherServicesController.text.isNotEmpty
                      // ? wantedList.add(otherServicesController.text)
                      // : wantedList = wantedList;

                      sceneBloc.add(LoadScene(
                          selectedPPE: ppe,
                          selectedEnvironment: environmentList,
                          selectedCaseType: caseTypeList,
                          selectedPatient: patientList,
                          selectedBackup: backupList,
                          selectedServices: otherServices));
                    },
                    controller: otherController,
                    decoration: InputDecoration(
                      labelText: "Other separated with comma(,)",
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  _defaultChips(header, List<String> list, callback, initialData) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
          title: Padding(
            child: Text(header),
            padding: EdgeInsets.symmetric(vertical: 10.0),
          ),
          subtitle: SingleOption(
              header: header,
              stateList: list,
              callback: callback,
              multiple: false,
              initialData: initialData),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patientBloc = BlocProvider.of<PatientBloc>(context);

    void nothingCallback(String item, List<String> selectedItems) {}
    void callback(String item, List<String> selectedItems) {
      if (item == "PPE") {
        setState(() {
          ppeList = selectedItems;
        });
      }
      if (item == "Environment") {
        setState(() {
          environmentList = selectedItems;
        });
      }
      if (item == "Case Type") {
        setState(() {
          caseTypeList = selectedItems;
        });
      }
      if (item == "Patient") {
        setState(() {
          patientList = selectedItems;
        });
      }
      if (item == "Backup") {
        setState(() {
          backupList = selectedItems;
        });
      }
      if (item == "Other services at scene") {
        setState(() {
          wantedList = selectedItems;
        });
      }

      sceneBloc = BlocProvider.of<SceneBloc>(context);
      // ppeOtherController.text.isNotEmpty
      // ? ppeList.add(ppeOtherController.text)
      // : ppeList = ppeList;

      // otherServicesController.text.isNotEmpty
      // ? wantedList.add(otherServicesController.text)
      // : wantedList = wantedList;

      final ppe = new PPE(
          ppe: widget.sceneAssessment.ppe.ppe != null
              ? widget.sceneAssessment.ppe.ppe
              : ppeList,
          otherspecify: ppeOtherController.text);
      final otherServices = new OtherServices(
          otherServices:
              widget.sceneAssessment.otherServicesAtScene.otherServices != null
                  ? widget.sceneAssessment.otherServicesAtScene.otherServices
                  : wantedList,
          otherspecify: otherServicesController.text);
      sceneBloc.add(LoadScene(
          selectedPPE: ppe,
          selectedEnvironment: environmentList,
          selectedCaseType: caseTypeList,
          selectedPatient: patientList,
          selectedBackup: backupList,
          selectedServices: otherServices));
      print("bloc kat sini: ");

      // patientBloc.add(LoadPatient(
      //     assign_id: widget.assign_id,
      //     patients: patientBloc.state.patients,
      //     sceneAssessment:
      //         SceneAssessment(otherServicesAtScene: selectedItems)));
    }

    return Scaffold(
      body: Container(
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
                  BlocBuilder<SceneBloc, SceneState>(builder: (context, state) {
                    if (state is LoadedScene) {
                      return Column(children: [
                        HeaderSection("Scene Assessment"),
                        SizedBox(
                          height: 10,
                        ),
                        _buildSceneChips(
                            "PPE",
                            _ppe,
                            callback,
                            state.selectedPPE != null
                                ? state.selectedPPE.ppe
                                : null,
                            ppeOtherController),
                        _defaultChips("Environment", _environment, callback,
                            state.selectedEnvironment),
                        _defaultChips("Case Type", _trauma, callback,
                            state.selectedCaseType),
                        _defaultChips("Patient", _patient, callback,
                            state.selectedPatient),
                        _defaultChips(
                            "Backup", _backup, callback, state.selectedBackup),
                        _buildSceneChips(
                            "Other services at scene",
                            _otherServices,
                            callback,
                            state.selectedServices != null
                                ? state.selectedServices.otherServices
                                : null,
                            otherServicesController),
                      ]);
                    }
                  }),
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
    );
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

      return InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.only(left: 8, top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey, width: 0.5)),
            // onHighlightChanged: (hightlight) {},
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
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
              // },
            ),
          ),
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
          });
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
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: patientList.length,
                    itemBuilder: (BuildContext context, int index) {
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

                  return PatientTab(
                    patient: new Patient(
                      patientInformation: new PatientInformation(),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
