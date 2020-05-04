import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/providers/medication_provider.dart';
// import 'package:phcapp/src/providers/assessment_provider.dart';
import 'package:phcapp/src/providers/trauma_provider.dart';
import 'package:phcapp/src/ui/tabs/patient/incident_report.dart';
import 'package:phcapp/src/ui/tabs/patient/intervention.dart';
import 'package:phcapp/src/ui/tabs/patient/medication.dart';
import 'package:phcapp/src/ui/tabs/patient/trauma.dart';
import 'package:provider/provider.dart';
import 'patient_assessment.dart';

class MainAssessment extends StatelessWidget {
  final BuildContext context;
  MainAssessment({this.context});

  @override
  build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
              child: Column(
                children: <Widget>[
                  HeaderSection("Assessment"),
                  // BuildCard(
                  //     icon: Icons.accessibility,
                  //     title: "Patient",
                  //     nextRoute: PatientAssessments()),
                  // BuildCard(
                  //   icon: Icons.airline_seat_recline_normal,
                  //   title: "Trauma",
                  //   nextRoute: Trauma(),
                  // ),
                  BuildCard(
                    icon: Icons.desktop_mac,
                    title: "Intervention",
                    nextRoute: Intervention(),
                  ),
                  // BuildCard(
                  //   icon: Icons.dns,
                  //   title: "Medication",
                  //   nextRoute: Medication(),
                  // ),
                  // BuildCard(
                  //   icon: Icons.report_problem,
                  //   title: "Incident Reporting",
                  //   nextRoute: IncidentReporting(),
                  // ),
                ],
              ))),
    );
  }
}

class BuildCard extends StatelessWidget {
  final IconData icon;
  final title;
  final nextRoute;
  BuildCard({this.icon, this.title, this.nextRoute});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
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
                  Text(
                    "Last updated: 11:40 AM",
                    style: TextStyle(fontSize: 12),
                  )
                ])),
              ],
            ),
            padding: EdgeInsets.only(right: 20)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextRoute));
        },
      ),
    );

    ;
  }
}
