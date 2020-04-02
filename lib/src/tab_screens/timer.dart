import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phcapp/custom/drop_downlist.dart';
import 'package:phcapp/custom/header_section.dart';

// Function DateTime _onDateTimeChangedHandler() {
//   var now = new DateTime.now();
//   return now;
// };

const LIST_MISSIONABORT = [
  "N/A",
  "Arrive at scene no patient found",
  "Stand down"
];

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  DateTime _cupertinoTime = DateTime.now();
  DateTime _dispatchTime = DateTime.now();
  DateTime _enrouteTime = DateTime.now();
  DateTime _atSceneTime = DateTime.now();
  DateTime _atPatientTime = DateTime.now();
  DateTime _transportTime = DateTime.now();
  DateTime _atHospitalTime = DateTime.now();
  DateTime _rerouteTime = DateTime.now();
  String _dateTime =
      DateFormat("dd/MM/yyyy HH:mm:ss").format(new DateTime.now()).toString();

  String missionSelected = "N/A";

  void missionCallback(String item) {
    missionSelected = item;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Center(
                child: Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Center(child: HeaderSection("Response Time")),
                        _buildCardTime("Dispatch Time", _dispatchTime),
                        _buildCardTime("Enroute", _enrouteTime),
                        _buildCardTime("At Scene", _atSceneTime),
                        _buildCardTime("At Patient", _atPatientTime),
                        _buildCardTime("Transporting", _transportTime),
                        _buildCardTime("At Hospital", _atHospitalTime),
                        _buildCardTime("Reroute", _rerouteTime),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Container(
                          width: 500,
                          child: CustomDropDown(
                            labelText: "Mission abort",
                            items: LIST_MISSIONABORT,
                            callback: missionCallback,
                            itemSelected: missionSelected,
                          ),
                        )
                      ],
                    )))));
  }

  Widget _buildCardTime(labelText, timeHandler) {
    // String timeText;
    String currentTime;

    var cancelButton = CupertinoButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    var doneButton = CupertinoButton(
      child: Text("Done"),
      onPressed: () {
        // setState(() {
        //   _dateTime = new DateFormat("dd/MM/yyyy HH:mm:ss")
        //       .format(_cupertinoTime)
        //       .toString();
        // });
        Navigator.of(context).pop();
      },
    );

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 500,
        child: Card(
          child: ListTile(
            // isThreeLine: true,
            // leading: Icon(
            //   Icons.access_time,
            //   size: 40,
            // ),
            title: Text(
              DateFormat("HH:mm:ss").format(timeHandler),
              style: TextStyle(
                  fontFamily: "Roboto", fontWeight: FontWeight.w600, fontSize: 30),
            ),
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    DateFormat("dd MMM yyyy").format(timeHandler),
                    style: TextStyle(fontFamily: "OpenSans"),
                  ),
                  Text(labelText),
                ]),
            trailing: Row(mainAxisSize: MainAxisSize.min,
                // mainAxisAlign: MainAxisAlign.,
                children: <Widget>[
                  // Expanded(
                  //     child:
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      final action = SizedBox(
                          height: 150.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          249, 249, 247, 1.0),
                                      border: Border(
                                          bottom: const BorderSide(
                                              width: 0.5,
                                              color: Colors.black38))),
                                  child: Center(
                                      // mainAxisAlignment:
                                      // MainAxisAlignment.spaceBetween,
                                      // children: <Widget>[
                                      // cancelButton,
                                      child: doneButton
                                      // ],
                                      )),
                              Expanded(
                                  child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.dateAndTime,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (dateTime) {
                                  setState(() {
                                    switch (labelText) {
                                      case "Dispatch Time":
                                        _dispatchTime = dateTime;
                                        break;
                                      case "Enroute":
                                        _enrouteTime = dateTime;
                                        break;
                                      case "At Scene":
                                        _atSceneTime = dateTime;
                                        break;
                                      case "At Patient":
                                        _atPatientTime = dateTime;
                                        break;
                                      case "Transporting":
                                        _transportTime = dateTime;
                                        break;
                                      case "At Hospital":
                                        _atHospitalTime = dateTime;
                                        break;
                                      case "Reroute":
                                        _rerouteTime = dateTime;
                                        break;
                                      default:
                                        break;
                                    }
                                  });
                                },
                              ))
                            ],
                          ));

                      showCupertinoModalPopup(
                          context: context, builder: (context) => action);
                    },
                    // )set
                  ),
                  RaisedButton(
                    child: Text(
                      "NOW",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      var dateTime = DateTime.now();
                      setState(() {
                        switch (labelText) {
                          case "Dispatch Time":
                            _dispatchTime = dateTime;
                            break;
                          case "Enroute":
                            _enrouteTime = dateTime;
                            break;
                          case "At Scene":
                            _atSceneTime = dateTime;
                            break;
                          case "At Patient":
                            _atPatientTime = dateTime;
                            break;
                          case "Transporting":
                            _transportTime = dateTime;
                            break;
                          case "At Hospital":
                            _atHospitalTime = dateTime;
                            break;
                          case "Reroute":
                            _rerouteTime = dateTime;
                            break;
                          default:
                            break;
                        }
                      });
                    },
                  )
                ]),
          ),
        ));
  }
}
