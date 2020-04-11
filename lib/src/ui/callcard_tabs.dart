import 'package:flutter/material.dart';
import 'package:phcapp/src/ui/tabs/patient_list.dart';
import 'package:phcapp/src/ui/tabs/response_team.dart';
import 'package:phcapp/src/ui/tabs/response_time.dart';
import '../blocs/info_bloc.dart';
import 'package:phcapp/src/ui/tabs/call_information.dart';
// import 'src/tab_screens/patients.dart';
// import 'src/tab_screens/information.dart';
// import 'src/tab_screens/team.dart';
// import 'src/tab_screens/timer.dart';
import '../models/info_model.dart';
import '../models/team_model.dart';
import '../models/timer_model.dart';
import '../models/patient_model.dart';

class CallcardTabs extends StatelessWidget {
  final String callcard_no;
  final InfoModel call_information;
  final TeamModel response_team;
  final TimerModel response_time;
  final List<PatientModel> patients;

  CallcardTabs(
      {this.callcard_no,
      this.call_information,
      this.response_team,
      this.response_time,
      this.patients});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          // shape: ShapeBorder(BorderRadius.only(topLeft:Radius.circular(2.0))),
          // backgroundColor: Colors.white,
          bottom: TabBar(
            // unselectedLabelColor: Colors.red,
            // labelColor: Colors.blue,
            // indicatorColor: Color(0x880E4F00),
            tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.timer)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
          title: Center(
              child: Text(this.callcard_no,
                  style: TextStyle(fontFamily: "OpenSans", fontSize: 20))),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cloud_upload),
              tooltip: "Push to Server",
              onPressed: () {
                // bloc.addCallInfo();
                //TODO: add handler
              },
            )
          ],
        ),
        // backgroundColor: Colors.purple),
        body: TabBarView(
          children: <Widget>[
            CallInfo(call_information: this.call_information),
            ResponseTeam(response_team: this.response_team),
            ResponseTime(response_time: this.response_time),
            PatientList(patients: this.patients)
            // Icon(Icons.ev_station),
            // Icon(Icons.ev_station),
            // Team(),
            // Timer(),
            // Patients(),
          ],
        ),
      ),
    );
  }
}
