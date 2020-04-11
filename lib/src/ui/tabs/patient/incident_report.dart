import 'package:flutter/material.dart';
import 'package:phcapp/custom/drop_downlist.dart';

const LIST_RESPONSE_DELAY = [
  "direction/ unable to locate",
  "traffic",
  "route obstruction",
  "vehicle failure",
  "vehicle crash",
  "staff delay"
];

const LIST_SCENE_DELAY = [
  "awaiting secondary responder",
  "awaiting specialized vehicle",
  "awaiting specialized equipment",
  "awaiting PDRM officer",
  "vehicle crash",
  "vehicle failure"
];

const LIST_TRANSPORT_DELAY = ["traffic", "vehicle crash", "vehicle failure"];

class IncidentReporting extends StatefulWidget {
  _IncidentState createState() => _IncidentState();
}

class _IncidentState extends State<IncidentReporting> {
  String selectedResponse;
  String selectedScene;
  String selectedTransport;

  void responseCallback(String selected) {}
  void sceneCallback(String selected) {}
  void transportCallback(String selected) {}
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Incident Reporting"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CustomDropDown(
                labelText: "Response delay",
                items: LIST_RESPONSE_DELAY,
                callback: responseCallback,
                itemSelected: selectedResponse),
            CustomDropDown(
                labelText: "Scene delay",
                items: LIST_SCENE_DELAY,
                callback: sceneCallback,
                itemSelected: selectedScene),
            CustomDropDown(
                labelText: "Transport delay",
                items: LIST_TRANSPORT_DELAY,
                callback: transportCallback,
                itemSelected: selectedTransport)
          ],
        ),
      ),
    );
  }

  // }
}
