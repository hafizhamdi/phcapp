import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:phcapp/custom/drop_downlist.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/models/timer_model.dart';

const LIST_MISSIONABORT = [
  "N/A",
  "Arrive at scene no patient found",
  "Stand down"
];

class ResponseTime extends StatefulWidget {
  final TimerModel response_time;
  ResponseTime({this.response_time});

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<ResponseTime> {
  // DateTime _cupertinoTime = DateTime.now();
  DateTime _dispatchTime;
  DateTime _enrouteTime;
  DateTime _atSceneTime;
  DateTime _atPatientTime;
  DateTime _transportTime;
  DateTime _atHospitalTime;
  DateTime _rerouteTime;
  String _dateTime =
      DateFormat("dd/MM/yyyy HH:mm:ss").format(new DateTime.now()).toString();

  String missionSelected = "N/A";

  void missionCallback(String item) {
    missionSelected = item;
  }

  @override
  void initState() {
    _dispatchTime = timeDefaultIfNull(widget.response_time.dispatch_time);
    _enrouteTime = timeDefaultIfNull(widget.response_time.enroute_time);
    _atSceneTime = timeDefaultIfNull(widget.response_time.at_scene_time);
    _atPatientTime = timeDefaultIfNull(widget.response_time.at_patient_time);
    _transportTime = timeDefaultIfNull(widget.response_time.transporting_time);
    _atHospitalTime = timeDefaultIfNull(widget.response_time.at_hospital_time);
    _rerouteTime = timeDefaultIfNull(widget.response_time.reroute_time);

    missionSelected = (widget.response_time.reason_abort != '')
        ? widget.response_time.reason_abort
        : 'N/A';
  }

  DateTime timeDefaultIfNull(String time) {
    return (time != '') ? DateTime.parse(time) : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
        // padding: EdgeInsets.symmetric(horizontal: 20),
        width: 500,
        child: Card(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                // isThreeLine: true,
                // leading: Icon(
                //   Icons.access_time,
                //   size: 40,
                // ),
                title: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      labelText,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontFamily: "Raleway"),
                    )),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        DateFormat("HH:mm:ss").format(timeHandler),
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          // color: Colors.black
                        ),
                      ),
                      Text(
                        DateFormat("dd MMM yyyy").format(timeHandler),
                        style: TextStyle(fontFamily: "OpenSans"),
                      ),
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
                                      child: doneButton
                                      // ],
                                      // )
                                      ),
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
                          final snackBar = SnackBar(
                            content: Text(labelText + " changed!"),
                            action: SnackBarAction(
                              label: "Undo",
                              onPressed: () {},
                            ),
                          );

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

                            Scaffold.of(context).showSnackBar(snackBar);
                          });
                        },
                      )
                    ]),
              )),
        ));
  }
}
