import 'package:flutter/widgets.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/ui/tabs/patient/incident_report.dart';
import 'package:phcapp/src/ui/tabs/patient/intervention.dart';
import 'package:phcapp/src/ui/tabs/patient/medication.dart';
import 'package:phcapp/src/ui/tabs/patient/trauma.dart';
import 'patient_assessment.dart';

class MainAssessment extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
              child: Column(
                // backgroundColor: Colors.grey[200],
                // body: ListView(
                children: <Widget>[
                  HeaderSection("Assessment"),
                  _buildCard(
                      icon: Icons.accessibility,
                      title: "Patient",
                      nextRoute: PatientAssessment()),
                  _buildCard(
                    icon: Icons.airline_seat_recline_normal,
                    title: "Trauma",
                    nextRoute: Trauma(),
                  ),
                  _buildCard(
                    icon: Icons.desktop_mac,
                    title: "Intervention",
                    nextRoute: Intervention(),
                  ),
                  _buildCard(
                    icon: Icons.dns,
                    title: "Medication",
                    nextRoute: Medication(),
                  ),
                  _buildCard(
                    icon: Icons.report_problem,
                    title: "Incident Reporting",
                    nextRoute: IncidentReporting(),
                  ),
                ],
              ))),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     //  onTap: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => VitalDetail()));
      //     // }
      //     // Add your onPressed code here!
      //   },
      //   label: Text('ADD VITALSIGN'),
      //   icon: Icon(Icons.add),
      //   // backgroundColor: Colors.purple,
      // )
    );
  }
}

class _buildCard extends StatelessWidget {
  final IconData icon;
  final title;
  final nextRoute;

  _buildCard({this.icon, this.title, this.nextRoute});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //   return null;
    // }
    return Card(
      // color: Colors.purple[100],
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Row(children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Colors.purple,
                  ),
                  Text("11:40 AM")
                ])),
                Expanded(
                    child: Row(children: <Widget>[
                  Icon(Icons.flag, color: Colors.purple),
                  Text("Severe")
                ])),
              ],
            ),
            padding: EdgeInsets.only(right: 20)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => nextRoute));
          //     // }
        },
      ),
    );
  }
}
