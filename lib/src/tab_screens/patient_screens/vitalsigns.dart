import 'package:flutter/widgets.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:flutter/material.dart';

class VitalSigns extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
        body: ListView(
          children: <Widget>[
            HeaderSection("Vital Signs"),
            Card(
              color: Colors.purple[100],
              margin: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text("First reading",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: Colors.purple,
                          ),
                          Text("10:40 AM")
                        ])),
                        Expanded(
                            child: Row(children: <Widget>[
                          Icon(Icons.flag, color: Colors.purple),
                          Text("Normal")
                        ])),
                      ],
                    ),
                    padding: EdgeInsets.only(right: 20)),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              color: Colors.purple[100],
              margin:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 100),
              child: ListTile(
                leading: Icon(Icons.star),
                title: Text("Second reading",
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('ADD VITALSIGN'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.purple,
        ));
  }
}
