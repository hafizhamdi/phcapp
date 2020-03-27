import 'package:flutter/material.dart';
import 'src/tab_screens/patients.dart';
import 'src/tab_screens/information.dart';
import 'src/tab_screens/team.dart';
import 'src/tab_screens/timer.dart';

class CallCardDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.info)),
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.timer)),
                Tab(icon: Icon(Icons.person)),
              ],
            ),
            title: Text(
              'PH Care Ambulance',
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.cloud_upload),
                tooltip: "Push to Server",
                onPressed: () {
                  //TODO: add handler
                },
              )
            ],
            backgroundColor: Colors.purple),
        body: TabBarView(
          children: <Widget>[
            CallInfo(),
            Team(),
            Timer(),
            Patients(),
          ],
        ),
      ),
    );
  }
}
