import 'package:flutter/material.dart';
import 'package:phcapp/src/tab_screens/patient_screens/assessment.dart';
import 'package:phcapp/src/tab_screens/patient_screens/info.dart';
import 'package:phcapp/src/tab_screens/patient_screens/cprlogs.dart';
import 'package:phcapp/src/tab_screens/patient_screens/vitalsigns.dart';

class Patient extends StatelessWidget {
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
              PatientInfo(),
              CPRLogs(),
              VitalSigns(),
              Assessments(),
            ],
          ),
        ));
  }
}
