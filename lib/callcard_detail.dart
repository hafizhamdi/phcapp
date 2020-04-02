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
              child: Text('PHCare Ambulance',
                  style: TextStyle(fontFamily: "Raleway", fontSize: 20))),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.cloud_upload),
              tooltip: "Push to Server",
              onPressed: () {
                //TODO: add handler
              },
            )
          ],
        ),
        // backgroundColor: Colors.purple),
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
