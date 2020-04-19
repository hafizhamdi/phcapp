import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient_list.dart';
import 'package:phcapp/src/ui/tabs/response_team.dart';
import 'package:phcapp/src/ui/tabs/response_time.dart';
import 'package:provider/provider.dart';
// import '../blocs/info_bloc.dart';
import 'package:phcapp/src/ui/tabs/call_information.dart';
import '../repositories/repositories.dart';
// import 'src/tab_screens/patients.dart';
// import 'src/tab_screens/information.dart';
// import 'src/tab_screens/team.dart';
// import 'src/tab_screens/timer.dart';
// import '../models/info_model.dart';
// import '../models/phc_model.dart';
// import '../models/team_model.dart';
// import '../models/timer_model.dart';
import '../models/phc.dart';

class CallcardTabs extends StatelessWidget {
  final String callcard_no;
  final CallInformation call_information;
  final ResponseTeam response_team;
  final ResponseTime response_time;
  final List<Patient> patients;
  final PhcDao phcDao;

  CallInfoBloc callInfoBloc;

  PhcBloc phcBloc;
  CallcardTabs(
      {this.callcard_no,
      this.call_information,
      this.response_team,
      this.response_time,
      this.patients,
      this.phcDao});

  @override
  Widget build(BuildContext context) {
    // var callcard = Provider.of<Callcard>(context);

    callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    // var callInfoBloc = Provider.of<CallInfoBloc>(context);

    phcBloc = BlocProvider.of<PhcBloc>(context);

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
                var testBloc = callInfoBloc.state;
                Callcard callcard =
                    Callcard(callInformation: testBloc.props.first);
                print('push to server');
                phcBloc.add(PostPhc(callcard: callcard));

                // testBloc.pro
                print("callcardNoState");
                print(callInfoBloc.cardNoController.text);
                print(testBloc.props.first);
                // print(CallInformation.fromJson(testBloc));
                // var callInfoBloc = BlocProvider.of<CallInfoBloc>(context);

                // print(callcard.call_information);
                // bloc.addCallInfo();
                //TODO: add handler
              },
            )
          ],
        ),
        // backgroundColor: Colors.purple),
        body:
            // Consumer<CallInformation>(builder: (context, info, child) {
            //   return
            TabBarView(
          children: <Widget>[
            CallInformationScreen(call_information: this.call_information),
            ResponseTeamScreen(response_team: this.response_team),
            ResponseTimeScreen(response_time: this.response_time),
            PatientListScreen(patients: this.patients)
            // Icon(Icons.ev_station),
            // Icon(Icons.ev_station),
            // Team(),
            // Timer(),
            // Patients(),
          ],
          // );
          // }
        ),
      ),
    );
    // });
  }
}
