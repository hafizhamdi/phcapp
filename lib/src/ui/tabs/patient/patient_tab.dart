import 'package:flutter/material.dart';
import 'package:phcapp/src/models/phc.dart';
import 'main_assessment.dart';
import 'information.dart';
import 'cprlog.dart';
// import 'assessment.dart';
import 'vitalsign_list.dart';

class PatientTab extends StatelessWidget {
  final Patient patient;

  PatientTab({this.patient});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
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
              backgroundColor: Colors.purple),
          body: TabBarView(
            children: <Widget>[
              PatientInformationScreen(
                  patient_information: patient.patientInformation),
              CPRLog(),
              VitalSignList(),
              MainAssessment(),
            ],
          ),
        ));
  }
}
