import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/incident_report.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/intervention.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/medication.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/outcome_assessment.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/patient_assessment.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/trauma.dart';

class MainAssessment extends StatelessWidget {
  // final BuildContext context;
  // MainAssessment({this.context});

  @override
  build(BuildContext context) {
    final medicationBloc = BlocProvider.of<MedicationBloc>(context);
    final reportingBloc = BlocProvider.of<ReportingBloc>(context);
    final outcomeBloc = BlocProvider.of<OutcomeBloc>(context);
    final traumaBloc = BlocProvider.of<TraumaBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            width: 500,
            child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
              child: Column(
                children: <Widget>[
                  HeaderSection("Assessment"),

                  BlocBuilder<AssPatientBloc, AssPatientState>(
                    builder: (context, state) {
                      if (state is AssPatientLoaded) {
                        print("PATIENTLOADED");
                        return BuildCard(
                          icon: Icons.accessibility,
                          title: "Patient",
                          nextRoute: PatientAssessmentScreen(
                            patientAssessment: state.patientAssessment,
                          ),
                          timestamp: state.patientAssessment.timestamp,
                        );
                      }
                      return BuildCard(
                        icon: Icons.accessibility,
                        title: "Patient",
                        nextRoute: PatientAssessmentScreen(),
                        timestamp: null,
                      );
                    },
                  ),

                  // BuildCard(
                  //   icon: Icons.airline_seat_recline_normal,
                  //   title: "Trauma",
                  //   nextRoute: Trauma(),
                  // ),

                  BlocBuilder<InterBloc, InterState>(
                    builder: (context, state) {
                      if (state is InterLoaded) {
                        print("Interloaded");

                        print(state.inter.toJson());
                        return BuildCard(
                          icon: Icons.desktop_mac,
                          title: "Intervention",
                          nextRoute: InterventionScreen(
                            interAssessment: state.inter,
                          ),
                          timestamp: state.inter.timestamp,
                        );
                      }
                      return BuildCard(
                        icon: Icons.desktop_mac,
                        title: "Intervention",
                        nextRoute: InterventionScreen(),
                        timestamp: null,
                      );
                    },
                  ),

                  // BlocBuilder<TraumaBloc, TraumaState>(
                  //   builder: (context, state) {
                  //     print("TRAUMABLOC");
                  //     print(state);
                  //     if (state is TraumaLoaded) {
                  //       print("TRAUMALOADED");
                  // return
                  BuildCard(
                      icon: Icons.airline_seat_recline_normal,
                      title: "Trauma",
                      nextRoute: TraumaScreen(
                          trauma: traumaBloc.state.traumaAssessment != null
                              ? traumaBloc.state.traumaAssessment
                              : null),
                      timestamp: traumaBloc.state.traumaAssessment != null
                          ? traumaBloc.state.traumaAssessment.timestamp
                          : null),
                  // }
                  //     return BuildCard(
                  //       icon: Icons.airline_seat_recline_normal,
                  //       title: "Trauma",
                  //       nextRoute: TraumaScreen(),
                  //       timestamp: null,
                  //     );
                  //   },
                  // ),
                  BuildCard(
                    icon: Icons.dns,
                    title: "Medication",
                    nextRoute: MedicationScreen(),
                    timestamp: medicationBloc.state.medicationAssessment != null
                        ? medicationBloc.state.medicationAssessment.timestamp
                        : null,
                  ),

                  BuildCard(
                    icon: Icons.report_problem,
                    title: "Incident Reporting",
                    nextRoute: IncidentReport(
                      incidentReporting:
                          reportingBloc.state.incidentReporting != null
                              ? reportingBloc.state.incidentReporting
                              : null,
                    ),
                    timestamp: reportingBloc.state.incidentReporting != null
                        ? reportingBloc.state.incidentReporting.timestamp
                        : null,
                  ),

                  BuildCard(
                      icon: Icons.note,
                      title: "Outcome",
                      nextRoute: OutcomeAssessment(
                        outcome: outcomeBloc.state.outcome != null
                            ? outcomeBloc.state.outcome
                            : null,
                      ),
                      timestamp: outcomeBloc.state.outcome != null
                          ? outcomeBloc.state.outcome.timestamp
                          : null),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  final IconData icon;
  final title;
  final nextRoute;
  final timestamp;
  BuildCard({this.icon, this.title, this.nextRoute, this.timestamp});

  generateTime(time) {
    if (time == null) return "No data";

    return DateFormat("HH:mm aa").format(time);
  }

  @override
  Widget build(BuildContext context) {
    // final interBloc = BlocProvider.of<InterBloc>(context);
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.all(10),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: Icon(
          icon,
          size: 30,
        ),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        subtitle: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.access_time,
                          color: Colors.purple,
                          size: 23,
                        )),
                    timestamp != null
                        ? Text("Last changes: " + generateTime(timestamp),
                            style: TextStyle(fontSize: 16))
                        : Text(
                            "No data",
                            style: TextStyle(fontSize: 16),
                          )
                  ]),
                ),
              ],
            ),
            padding: EdgeInsets.only(right: 20)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => nextRoute),
          );
        },
      ),
    );
  }
}
