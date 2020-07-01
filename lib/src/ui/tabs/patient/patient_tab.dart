import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:phcapp/src/providers/medication_provider.dart';
import 'package:phcapp/src/providers/patinfo_provider.dart';
import 'package:phcapp/src/providers/vital_provider.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
// import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_detail.dart';
import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_items.dart';
import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_timelog.dart';
import 'package:provider/provider.dart';
import 'asessments/main_assessment.dart';
// import 'main_assessment.dart';
import 'information.dart';
// import 'cprlog.dart';
// import 'assessment.dart';
import 'vitalsign_list.dart';

enum Action { cancel, delete }

class PatientTab extends StatefulWidget {
  final Patient patient;
  final index;

  PatientTab({this.patient, this.index});

  _PatientTab createState() => _PatientTab();
}

class _PatientTab extends State<PatientTab> {
  PatientBloc patientBloc;
  PatientInformation patientInformation;
  VitalBloc vitalBloc;
  AssPatientBloc assPatientBloc;
  InterBloc interBloc;
  TraumaBloc traumaBloc;
  MedicationBloc medicationBloc;
  ReportingBloc reportingBloc;
  OutcomeBloc outcomeBloc;

  Action getAction(index) {
    if (index == null)
      return Action.cancel;
    else
      return Action.delete;
  }

  @override
  void didChangeDependencies() {
    print("DID DEPENDENCY");
    print(widget.patient.toJson());

    patientBloc = BlocProvider.of<PatientBloc>(context);

    assPatientBloc = BlocProvider.of<AssPatientBloc>(context);
    interBloc = BlocProvider.of<InterBloc>(context);
    traumaBloc = BlocProvider.of<TraumaBloc>(context);
    medicationBloc = BlocProvider.of<MedicationBloc>(context);
    reportingBloc = BlocProvider.of<ReportingBloc>(context);
    outcomeBloc = BlocProvider.of<OutcomeBloc>(context);

    // final provider = Provider.of<PatInfoProvider>(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  convertDOBtoStandard(data) {
    print("CONVERT DOB");
    if (data == "") return null;

    var split = data.split('/');
    var dd = split[0];
    var MM = split[1];
    var yyyy = split[2];

    print(data);
    print("$yyyy-$MM-$dd");
    return "$yyyy-$MM-$dd";
  }

  @override
  Widget build(BuildContext context) {
    final vitalBloc = BlocProvider.of<VitalBloc>(context);
    final action = getAction(widget.index);
    // final patProvider = Provider.of<PatInfoProvider>(context);

    PatientInformation preparingResultPatientInformation(BuildContext context) {
      final patProvider = Provider.of<PatInfoProvider>(context, listen: false);

      print("PATPROVIDER VALUES===");
      print(patProvider.getName);
      PatientInformation patInfo = new PatientInformation(
          name: patProvider.getName,
          idNo: patProvider.getId,
          idType: patProvider.getIdtype,
          age: patProvider.getAge,
          dob: convertDOBtoStandard(patProvider.getDob),
          gender: patProvider.getGender);

      print(patProvider.getName);

      return patInfo;
    }

    // CprLog preparingResultCPRlog(BuildContext context) {
    // final logProvider = Provider.of<CPRProvider>(context, listen: false);

    // final logs = logProvider.items;
    // final newCpr = new CprLog(id: "1", created: DateTime.now(), logs: logs);
    // print("PREPARING RESULT CPRLOG");
    // print(newCpr.toJson());

    // List<CprLog> list = List<CprLog>(1);
    // list[0] = newCpr;

    // return newCpr;
    // }

    List<VitalSign> preparingResultVitalSigns(BuildContext context) {
      // print(vitalBloc.state.listVitals);
      // print(vitalBloc.state.listVitals.length);
      return vitalBloc.state.listVitals;
    }

    createButton(BuildContext context, action, index) => InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0), color: Colors.green),
            // color: Colors.green,
            child: Text((action == Action.delete) ? "SAVE NOTE" : "CREATE NOTE",
                style: TextStyle(color: Colors.white)),
          ),

          // FlatButton(
          onTap: () {
            final provider =
                Provider.of<PatInfoProvider>(context, listen: false);
            // if (provider.formKey.currentState.validate()) {
            final patInfo = preparingResultPatientInformation(context);
            // final cprlog = preparingResultCPRlog();

            final traumaBloc = BlocProvider.of<TraumaBloc>(context);

            print("trauma state");
            // print(traumaBloc.state);

            // print(cprlog)

            final cprBloc = BlocProvider.of<CprBloc>(context);
            print("CPR RESULT WOHOW");
            // print(cprBloc.state.cpr.toJson());
            // final cprlog = preparingResultCPRlog(context);
            // print(cprlog);

            // final vitalSigns = BlocProvider.of<VitalBloc>(context);
            // final vitalsigns = preparingResultVitalSigns(context);
            if (action == Action.delete) {
              //TODO:Update
              patientBloc.add(UpdatePatient(
                  patient: new Patient(
                      // cpr: cprBloc.state.cpr,
                      patientInformation: patInfo,
                      vitalSigns: vitalBloc.state.listVitals ??
                          widget.patient.vitalSigns,
                      patientAssessment:
                          assPatientBloc.state.patientAssessment ??
                              widget.patient.patientAssessment,
                      intervention:
                          interBloc.state.inter ?? widget.patient.intervention,
                      traumaAssessment: traumaBloc.state.traumaAssessment ??
                          widget.patient.traumaAssessment,
                      medicationAssessment:
                          medicationBloc.state.medicationAssessment ??
                              widget.patient.medicationAssessment,
                      incidentReporting:
                          reportingBloc.state.incidentReporting ??
                              widget.patient.incidentReporting,
                      outcome:
                          outcomeBloc.state.outcome ?? widget.patient.outcome),
                  index: widget.index));
            } else {
              print("ADD PATIENT BLOC");
              patientBloc.add(AddPatient(
                patient: new Patient(
                    // cpr: cprBloc.state.cpr,

                    patientInformation: patInfo,
                    vitalSigns:
                        vitalBloc.state.listVitals ?? widget.patient.vitalSigns,
                    patientAssessment: assPatientBloc.state.patientAssessment ??
                        widget.patient.patientAssessment,
                    intervention:
                        interBloc.state.inter ?? widget.patient.intervention,
                    traumaAssessment: traumaBloc.state.traumaAssessment ??
                        widget.patient.traumaAssessment,
                    medicationAssessment:
                        medicationBloc.state.medicationAssessment ??
                            widget.patient.medicationAssessment,
                    incidentReporting: reportingBloc.state.incidentReporting ??
                        widget.patient.incidentReporting,
                    outcome:
                        outcomeBloc.state.outcome ?? widget.patient.outcome),
              ));
            }
            print("patient created");

            // final vitalBloc = BlocProvider.of<VitalBloc>(context);
            vitalBloc.add(ResetVital());

            // final interBloc = BlocProvider.of<InterBloc>(context);
            interBloc.add(ResetInter());

            // final patBloc = BlocProvider.of<AssPatientBloc>(context);
            assPatientBloc.add(ResetAssPatient());

            // final traumaBloc = BlocProvider.of<TraumaBloc>(context);
            traumaBloc.add(ResetTrauma());

            // final medicationBloc = BlocProvider.of<MedicationBloc>(context);
            medicationBloc.add(ResetMedication());
            // final reportingBloc = BlocProvider.of<ReportingBloc>(context);
            reportingBloc.add(ResetReporting());
            // final outcomeBloc = BlocProvider.of<OutcomeBloc>(context);
            outcomeBloc.add(ResetOutcome());

            Navigator.pop(context);
            // }
          },
          // child: Text(
          //   (action == Action.delete) ? "SAVE" : "CREATE",
          //   style: TextStyle(color: Colors.white),
          // )
        );

    print("patient_TAB");
    // print(index);
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PatInfoProvider()),

        // BlocProvider(
        //   create: (context) => TraumaBloc(),
        // )
        // Provider<PatInfoProvider>(create: (context) => PatInfoProvider())
      ],
      child: DefaultTabController(
          length: 4,
          child: Consumer<PatInfoProvider>(
            builder: (context, data, child) {
              return Scaffold(
                backgroundColor: Colors.grey,
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.account_box)),
                        Tab(icon: Icon(Icons.airline_seat_flat)),
                        Tab(icon: Icon(Icons.favorite)),
                        Tab(icon: Icon(Icons.assessment)),
                      ],
                    ),
                    title: Text(
                      'Patient Note',
                    ),
                    actions: <Widget>[
                      deleteButton(context, action),
                      createButton(context, action, widget.index)
                    ],
                    backgroundColor: Colors.purple),
                body: TabBarView(
                  children: <Widget>[
                    PatientInformationScreen(
                        patient_information: widget.patient.patientInformation),
                    // ),

                    CPRTimeLog(),
                    // ),

                    // CPRDetail(),
                    VitalSignList(
                        listVitals: widget.patient.vitalSigns,
                        index: widget.index),
                    MainAssessment(
                      patientAssessment: widget.patient.patientAssessment,
                      interventionAssessment: widget.patient.intervention,
                      traumaAssessment: widget.patient.traumaAssessment,
                      medicationAssessment: widget.patient.medicationAssessment,
                      reportingAssessment: widget.patient.incidentReporting,
                      outcomeAssessment: widget.patient.outcome,

                      // context: context
                    ),
                  ],
                ),
              );
            },
          )
          // )
          ),
    );
    // PatInfoProvider(),
    // );
  }

  Widget deleteButton(BuildContext context, action) => FlatButton(
      onPressed: () {
        if (action == Action.delete) {
          patientBloc.add(RemovePatient(index: widget.index));
        }
        Navigator.pop(context);
      },
      child: Text((action == Action.delete) ? "DELETE" : "CANCEL",
          style: TextStyle(color: Colors.white)));
}
