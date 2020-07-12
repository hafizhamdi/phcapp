import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/otherinfo_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/sampler_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/incident_report.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/intervention.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/medication.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/other_information.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/outcome_assessment.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/patient_assessment.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/sample_screen.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/trauma.dart';

class MainAssessment extends StatelessWidget {
  final patientAssessment;
  final traumaAssessment;
  final interventionAssessment;
  final medicationAssessment;
  final reportingAssessment;
  final outcomeAssessment;
  final samplerAssessment;
  final otherAssessment;

  MainAssessment(
      {this.patientAssessment,
      this.traumaAssessment,
      this.interventionAssessment,
      this.medicationAssessment,
      this.reportingAssessment,
      this.outcomeAssessment,
      this.samplerAssessment,
      this.otherAssessment});
  // final BuildContext context;
  // MainAssessment({this.context});

  @override
  build(BuildContext context) {
    final medicationBloc = BlocProvider.of<MedicationBloc>(context);
    final reportingBloc = BlocProvider.of<ReportingBloc>(context);
    final outcomeBloc = BlocProvider.of<OutcomeBloc>(context);
    final traumaBloc = BlocProvider.of<TraumaBloc>(context);
    final samplerBloc = BlocProvider.of<SamplerBloc>(context);
    final otherBloc = BlocProvider.of<OtherBloc>(context);
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
        // padding: EdgeInsets.symmetric(vertical: 40),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              margin:
                  EdgeInsets.only(left: 12.0, right: 12, top: 40, bottom: 12),
              child: Container(
                padding: EdgeInsets.all(10),
                // width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    HeaderSection("Assessment"),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<AssPatientBloc, AssPatientState>(
                      builder: (context, state) {
                        if (state is AssPatientLoaded) {
                          print("PATIENTLOADED");
                          return BuildCard(
                            icon: Icons.accessibility,
                            title: "Patient",
                            // disasterTriage:
                            //     state.patientAssessment.disasterTriage,
                            nextRoute: PatientAssessmentScreen(
                              patientAssessment: state.patientAssessment,
                            ),
                            timestamp: state.patientAssessment.timestamp,
                          );
                        }
                        return BuildCard(
                          icon: Icons.accessibility,
                          title: "Patient",
                          // disasterTriage: patientAssessment != null
                          //     ? patientAssessment.disasterTriage
                          //     : null,
                          nextRoute: PatientAssessmentScreen(
                            patientAssessment: patientAssessment ?? null,
                          ),
                          timestamp: patientAssessment != null
                              ? patientAssessment.timestamp
                              : null,
                        );
                      },
                    ),

                    BlocBuilder<InterBloc, InterState>(
                      builder: (context, state) {
                        if (state is InterLoaded) {
                          print("Interloaded");

                          // print(state.inter.toJson());
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
                          nextRoute: InterventionScreen(
                            interAssessment: interventionAssessment ?? null,
                          ),
                          timestamp: interventionAssessment != null
                              ? interventionAssessment.timestamp
                              : null,
                        );
                      },
                    ),

                    BuildCard(
                      icon: Icons.change_history,
                      title: "SAMPLER",
                      nextRoute: SampleScreen(
                        samplerAssessment:
                            samplerBloc.state.samplerAssessment != null
                                ? samplerBloc.state.samplerAssessment
                                : samplerAssessment ?? null,
                      ),
                      timestamp: samplerBloc.state.samplerAssessment != null
                          ? samplerBloc.state.samplerAssessment.timestamp
                          : samplerAssessment != null
                              ? samplerAssessment.timestamp
                              : null,
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
                                : traumaAssessment ?? null),
                        timestamp: traumaBloc.state.traumaAssessment != null
                            ? traumaBloc.state.traumaAssessment.timestamp
                            : traumaAssessment != null
                                ? traumaAssessment.timestamp
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
                      nextRoute: MedicationScreen(
                        medications:
                            medicationBloc.state.medicationAssessment != null
                                ? medicationBloc
                                    .state.medicationAssessment.medication
                                : medicationAssessment != null
                                    ? medicationAssessment.medication
                                    : null,
                      ),
                      timestamp: medicationBloc.state.medicationAssessment !=
                              null
                          ? medicationBloc.state.medicationAssessment.timestamp
                          : medicationAssessment != null
                              ? medicationAssessment.timestamp
                              : null,
                    ),

                    BuildCard(
                        icon: Icons.chrome_reader_mode,
                        title: "Other Information",
                        nextRoute: OtherInformation(
                            otherAssessment:
                                otherBloc.state.otherAssessment != null
                                    ? otherBloc.state.otherAssessment
                                    : otherAssessment != null
                                        ? otherAssessment
                                        : null),
                        timestamp: otherBloc.state.otherAssessment != null
                            ? otherBloc.state.otherAssessment.timestamp
                            : otherAssessment != null
                                ? otherAssessment.timestamp
                                : null),

                    BuildCard(
                      icon: Icons.report_problem,
                      title: "Incident Reporting",
                      nextRoute: IncidentReport(
                        incidentReporting:
                            reportingBloc.state.incidentReporting != null
                                ? reportingBloc.state.incidentReporting
                                : reportingAssessment ?? null,
                      ),
                      timestamp: reportingBloc.state.incidentReporting != null
                          ? reportingBloc.state.incidentReporting.timestamp
                          : reportingAssessment != null
                              ? reportingAssessment.timestamp
                              : null,
                    ),

                    BuildCard(
                        icon: Icons.note,
                        title: "Outcome",
                        disasterTriage: outcomeBloc.state.outcome != null
                            ? outcomeBloc.state.outcome.etdTriage
                            : outcomeAssessment != null
                                ? outcomeAssessment.etdTriage
                                : null,
                        nextRoute: OutcomeAssessment(
                          outcome: outcomeBloc.state.outcome != null
                              ? outcomeBloc.state.outcome
                              : outcomeAssessment ?? null,
                        ),
                        timestamp: outcomeBloc.state.outcome != null
                            ? outcomeBloc.state.outcome.timestamp
                            : outcomeAssessment != null
                                ? outcomeAssessment.timestamp
                                : null),
                  ],
                ),
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
  final disasterTriage;
  BuildCard(
      {this.icon,
      this.title,
      this.nextRoute,
      this.timestamp,
      this.disasterTriage});

  generateTime(time) {
    if (time == null) return "No data";

    return "Last updated " + DateFormat("h:mm aa").format(time);
  }

  @override
  Widget build(BuildContext context) {
    // final interBloc = BlocProvider.of<InterBloc>(context);
    // return Card(
    //   elevation: 3.0,
    //   margin: EdgeInsets.all(10),
    //   child:

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey, width: 0.5)),

      //  return   Container(
      // color: Colors.grey[200],
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: Icon(
          icon,
          // size: 30,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.access_time,
                          color: Colors.purple,
                          // size: 18,
                        )),
                    timestamp != null
                        ? Text(
                            generateTime(timestamp),
                          )
                        : Text(
                            "No data",
                            // style: TextStyle(fontSize: 16),
                          ),
                    title == "Outcome"
                        ? Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.person_pin_circle,
                                  color: defineColor(disasterTriage),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                title == "Patient"
                                    ? Text("Disaster Triage")
                                    : Text("ETD Triage")
                              ],
                            ),
                          )
                        : Container()
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
      // ),
    );
  }

  defineColor(String color) {
    if (color != null) {
      if (color.toLowerCase() == "red")
        return Colors.red;
      else if (color.toLowerCase() == "green")
        return Colors.green;
      else if (color.toLowerCase() == "yellow")
        return Colors.yellow;
      else if (color.toLowerCase() == "white")
        return Colors.white;
      else if (color.toLowerCase() == "bid") return Colors.black;
    } else
      return Colors.grey;
  }
}
