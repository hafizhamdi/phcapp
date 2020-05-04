import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:phcapp/src/providers/medication_provider.dart';
import 'package:phcapp/src/providers/patinfo_provider.dart';
import 'package:provider/provider.dart';
import 'main_assessment.dart';
import 'information.dart';
import 'cprlog.dart';
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

  Action getAction(index) {
    if (index == null)
      return Action.cancel;
    else
      return Action.delete;
  }

  @override
  void initState() {
    patientBloc = BlocProvider.of<PatientBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          dob: patProvider.getDob,
          gender: patProvider.getGender);

      print(patProvider.getName);

      return patInfo;
    }

    List<CprLog> preparingResultCPRlog(BuildContext context) {
      final logProvider = Provider.of<CPRProvider>(context, listen: false);

      final logs = logProvider.items;
      final newCpr = new CprLog(id: "1", created: DateTime.now(), logs: logs);
      print("PREPARING RESULT CPRLOG");
      print(newCpr.toJson());

      List<CprLog> list = List<CprLog>(1);
      list[0] = newCpr;

      return list;
    }

    createButton(BuildContext context, action) => FlatButton(
        onPressed: () {
          if (action == Action.delete) {
            //TODO:Update

          } else {
            final provider =
                Provider.of<PatInfoProvider>(context, listen: false);
            if (provider.formKey.currentState.validate()) {
              final patInfo = preparingResultPatientInformation(context);
              // final cprlog = preparingResultCPRlog();

              final traumaBloc = BlocProvider.of<TraumaBloc>(context);

              print("trauma state");
              print(traumaBloc.state);

              // print(cprlog)

              final cprlog = preparingResultCPRlog(context);
              print(cprlog);

              patientBloc.add(AddPatient(
                patient:
                    new Patient(patientInformation: patInfo, cprLogs: cprlog),
              ));

              print("patient created");
              Navigator.pop(context);
            }
          }
        },
        child: Text(
          (action == Action.delete) ? "SAVE" : "CREATE",
          style: TextStyle(color: Colors.white),
        ));

    print("patient_TAB");
    // print(index);
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CPRProvider()),
        ChangeNotifierProvider(create: (context) => PatInfoProvider()),

        BlocProvider(
          create: (context) => TraumaBloc(),
        )
        // Provider<PatInfoProvider>(create: (context) => PatInfoProvider())
      ],
      child: DefaultTabController(
          length: 4,
          child: Consumer<PatInfoProvider>(
            builder: (context, data, child) {
              return Scaffold(
                appBar: AppBar(
                    // automaticallyImplyLeading: false,
                    bottom: TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.account_box)),
                        Tab(icon: Icon(Icons.airline_seat_flat)),
                        Tab(icon: Icon(Icons.favorite)),
                        Tab(icon: Icon(Icons.assessment)),
                      ],
                    ),
                    title: Text(
                      'Patient',
                    ),
                    actions: <Widget>[
                      deleteButton(context, action),
                      createButton(context, action)
                    ],
                    backgroundColor: Colors.purple),
                body: TabBarView(
                  children: <Widget>[
                    PatientInformationScreen(
                        patient_information: widget.patient.patientInformation),
                    // ),
                    CPRLog(),
                    VitalSignList(),
                    MainAssessment(context: context),
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
