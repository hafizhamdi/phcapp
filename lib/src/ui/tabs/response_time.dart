import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/drop_downlist.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';

enum Response {
  dispatch,
  enroute,
  atScene,
  atPatient,
  atHospital,
  transport,
  reroute
}

const LIST_MISSIONABORT = [
  "",
  "Arrive at scene no patient found",
  "Stand down"
];

class ResponseTimeScreen extends StatefulWidget {
  final ResponseTime response_time;
  final assign_id;

  ResponseTimeScreen({this.response_time, this.assign_id});

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<ResponseTimeScreen>
    with AutomaticKeepAliveClientMixin<ResponseTimeScreen> {
  @override
  bool get wantKeepAlive => true;
  DateTime _dispatchTime;
  DateTime _enrouteTime;
  DateTime _atSceneTime;
  DateTime _atPatientTime;
  DateTime _transportTime;
  DateTime _atHospitalTime;
  DateTime _rerouteTime;
  String missionAbort;
  TimeBloc timeBloc;

  final StreamController<DateTime> _dispatchController =
      StreamController<DateTime>();
  final StreamController<DateTime> _enrouteController =
      StreamController<DateTime>();
  final StreamController<DateTime> _atSceneController =
      StreamController<DateTime>();
  final StreamController<DateTime> _atPatientController =
      StreamController<DateTime>();
  final StreamController<DateTime> _transportController =
      StreamController<DateTime>();
  final StreamController<DateTime> _atHospitalController =
      StreamController<DateTime>();
  final StreamController<DateTime> _rerouteController =
      StreamController<DateTime>();

  final StreamController<String> _missionController =
      new StreamController<String>();

  // @override
  // void initState() {
  //   // timeBloc = BlocProvider.of<TimeBloc>(context);
  //   // timeBloc.add(LoadTime(assign_id: widget.assign_id));
  // }

  @override
  void dispose() {
    _dispatchController.close();
    _enrouteController.close();
    _atSceneController.close();
    _atPatientController.close();
    _transportController.close();
    _atHospitalController.close();
    _rerouteController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeBloc = BlocProvider.of<TimeBloc>(context);

    if (widget.response_time != null) {
      timeBloc.add(LoadTime(
          assign_id: widget.assign_id, responseTime: widget.response_time));
      missionAbort = widget.response_time.reasonAbort;
    } else {
      timeBloc.add(LoadTime(
          assign_id: widget.assign_id, responseTime: new ResponseTime()));
    }

    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
              constraints: BoxConstraints(), child: _buildMainCard(context))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          timeBloc.add(AddResponseTime(
              assignId: widget.assign_id,
              responseTime: new ResponseTime(
                  dispatchTime: _dispatchTime.toString(),
                  enrouteTime: _enrouteTime.toString(),
                  atSceneTime: _atSceneTime.toString(),
                  atPatientTime: _atPatientTime.toString(),
                  transportingTime: _transportTime.toString(),
                  atHospitalTime: _atHospitalTime.toString(),
                  rerouteTime: _rerouteTime.toString(),
                  reasonAbort: missionAbort)));

          final snackBar = SnackBar(
            content: Text("Response time has been saved!"),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Icon(Icons.save),
      ),
    );
  }

  DateTime parseTime(String datetime) {
    print(datetime);

    if (datetime == "null" || datetime == null || datetime == '') {
      return DateTime.now();
    }
    return DateTime.parse(datetime);
  }

  Widget _buildMainCard(BuildContext context) {
    return Center(
        child: Card(
            margin: EdgeInsets.all(10),
            child: BlocBuilder<TimeBloc, TimeState>(
              builder: (context, state) {
                // // if (state is TimeLoaded) {
                // final currentState = state.responseTime;
                // final dispatchTime = parseTime(currentState.dispatchTime);
                // final enrouteTime = parseTime(currentState.enrouteTime);
                // final atSceneTime = parseTime(currentState.atSceneTime);
                // final atPatientTime = parseTime(currentState.atPatientTime);
                // final atHospitalTime = parseTime(currentState.atHospitalTime);
                // final transportingTime =
                //     parseTime(currentState.transportingTime);
                // final rerouteTime = parseTime(currentState.rerouteTime);

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(child: HeaderSection("Response Time")),
                    _buildTimeCard("Dispatch Time", Response.dispatch),
                    _buildTimeCard("Enroute Time", Response.enroute),
                    _buildTimeCard("At Scene Time", Response.atScene),
                    _buildTimeCard("At Patient Time", Response.atPatient),
                    _buildTimeCard("Transporting Time", Response.transport),
                    _buildTimeCard("At Hospital Time", Response.atHospital),
                    _buildTimeCard("Reroute Time", Response.reroute),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    DropDownList("Mission Abort", LIST_MISSIONABORT,
                        _missionController, missionAbort)
                  ],
                );
                //   }

                //   return Container();
              },
            )));
  }

  DateTime getInitialTimestamp(selector) {
    final data = widget.response_time;

    switch (selector) {
      case Response.dispatch:
        return parseTime(data.dispatchTime);
        break;
      case Response.enroute:
        return parseTime(data.enrouteTime);
        break;
      case Response.atScene:
        return parseTime(data.atSceneTime);
        break;
      case Response.atPatient:
        return parseTime(data.atPatientTime);
        break;
      case Response.transport:
        return parseTime(data.transportingTime);
        break;
      case Response.atHospital:
        return parseTime(data.atHospitalTime);
        break;
      case Response.reroute:
        return parseTime(data.rerouteTime);
        break;
      default:
        return DateTime.now();
        break;
    }
  }

  StreamController getStreamController(selector) {
    switch (selector) {
      case Response.dispatch:
        return _dispatchController;
        break;
      case Response.enroute:
        return _enrouteController;
        break;
      case Response.atScene:
        return _atSceneController;
        break;
      case Response.atPatient:
        return _atPatientController;
        break;
      case Response.transport:
        return _transportController;
        break;
      case Response.atHospital:
        return _atHospitalController;
        break;
      case Response.reroute:
        return _rerouteController;
        break;
      default:
        return new StreamController();
        break;
    }
  }

  void setTimestamp(DateTime dateTime, selector) {
    switch (selector) {
      case Response.dispatch:
        _dispatchTime = dateTime;
        break;
      case Response.enroute:
        _enrouteTime = dateTime;
        break;
      case Response.atScene:
        _atSceneTime = dateTime;
        break;
      case Response.atPatient:
        _atPatientTime = dateTime;
        break;
      case Response.transport:
        _transportTime = dateTime;
        break;
      case Response.atHospital:
        _atHospitalTime = dateTime;
        break;
      case Response.reroute:
        _rerouteTime = dateTime;
        break;

      default:
    }
  }

  Widget _buildListTile(labelText, selector) {
    final controller = getStreamController(selector);
    return ListTile(
        title: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              labelText,
              style: TextStyle(
                  color: Colors.grey, fontSize: 18, fontFamily: "Raleway"),
            )),
        subtitle: _buildSubtitle(controller, selector),
        trailing: _buildTrailing(labelText, selector));
  }

  Widget _timerPopup(labelText, selector) {
    final initialData = getInitialTimestamp(selector);
    final streamController = getStreamController(selector);
    var titleButton = CupertinoButton(
      child: Text(labelText),
      onPressed: () {
        // Navigator.of(context).pop();
      },
    );

    var doneButton = CupertinoButton(
      child: Text("Done"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return SizedBox(
        height: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(249, 249, 247, 1.0),
                    border: Border(
                        bottom: const BorderSide(
                            width: 0.5, color: Colors.black38))),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [titleButton, doneButton]))),
            Expanded(
                child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: initialData,
              onDateTimeChanged: (dateTime) {
                streamController.sink.add(dateTime);
              },
            ))
          ],
        ));
  }

  Widget _buildTrailing(labelText, selector) {
    final streamController = getStreamController(selector);
    return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          showCupertinoModalPopup(
              context: context,
              builder: (context) => _timerPopup(labelText, selector));
        },
      ),
      RaisedButton(
        child: Text(
          "NOW",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.green,
        onPressed: () {
          streamController.sink.add(DateTime.now());

          final snackBar = SnackBar(
            content: Text(labelText + " changed!"),
            action: SnackBarAction(
              label: "Undo",
              onPressed: () {},
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
      )
    ]);
  }

  Widget _buildSubtitle(streamController, selector) {
    final timestamp = getInitialTimestamp(selector);

    return StreamBuilder(
      stream: streamController.stream,
      initialData: timestamp,
      builder: (context, snapshot) {
        setTimestamp(snapshot.data, selector);

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                DateFormat("HH:mm:ss").format(snapshot.data),
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text(
                DateFormat("dd MMM yyyy").format(snapshot.data),
                style: TextStyle(fontFamily: "OpenSans"),
              ),
            ]);
      },
    );
  }

  Widget _buildTimeCard(labelText, selector) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 500,
        child: Card(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: _buildListTile(labelText, selector))));
  }

  Widget DropDownList(labelText, List<String> list, controller, initialData) {
    // final controller = getStreamController(selector);

    // print(selector);
    print(initialData);
    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: controller.stream,
                initialData: initialData,
                builder: (context, snapshot) {
                  print("Streambuilder value");
                  print(snapshot.data);

                  missionAbort = snapshot.data;

                  // setInputOption(selector, snapshot.data);
                  // child:

                  return DropdownButtonFormField(
                      isDense: true,
                      items: list.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                            child: Text(dropDownStringItem),
                            value: dropDownStringItem);
                      }).toList(),
                      onChanged: (valueChanged) {
                        print("WHATS IS INDESIDE:$valueChanged");
                        controller.sink.add(valueChanged);
                      },
                      value: snapshot.data,
                      decoration: InputDecoration(
                          labelText: labelText,
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: new BorderSide(),
                          )));
                })));
    //               })));
  }
}
