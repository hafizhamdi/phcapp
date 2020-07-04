import 'dart:async';

// import 'package:flutter/cupertino.dart';
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
  reroute,
  abortMission
}

const MISSION_ABORT = [
    " ",
    "arrive at scene no patient found",
    "stand down"
];

class ResponseTimeScreen extends StatelessWidget {
  final ResponseTime responseTime;

  // ignore: close_sinks


  ResponseTimeScreen({this.responseTime});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimeBloc, TimeState>(
      builder: (context, state) {
        final currentState = state;
        if (state is TimeLoaded) {
          print("TimeLoaded");
          return ResponseTimeScreenA(
              dispatchTime: currentState.responseTime.dispatchTime,
              enrouteTime: currentState.responseTime.enrouteTime,
              atSceneTime: currentState.responseTime.atSceneTime,
              atPatientTime: currentState.responseTime.atPatientTime,
              transportingTime: currentState.responseTime.transportingTime,
              rerouteTime: currentState.responseTime.rerouteTime,
              atHospitalTime: currentState.responseTime.atHospitalTime,
              reasonAbort: currentState.responseTime.reasonAbort);
        }
        return ResponseTimeScreenA(
            dispatchTime: responseTime.dispatchTime,
            enrouteTime: responseTime.enrouteTime,
            atSceneTime: responseTime.atSceneTime,
            atPatientTime: responseTime.atPatientTime,
            transportingTime: responseTime.transportingTime,
            rerouteTime: responseTime.rerouteTime,
            atHospitalTime: responseTime.atHospitalTime,
            reasonAbort: responseTime.reasonAbort);
      },
    );
  }
}

class ResponseTimeScreenA extends StatefulWidget {
  DateTime dispatchTime;
  DateTime enrouteTime;
  DateTime atSceneTime;
  DateTime atPatientTime;
  DateTime rerouteTime;
  DateTime transportingTime;
  DateTime atHospitalTime;
  String reasonAbort;

  ResponseTimeScreenA(
      {this.dispatchTime,
      this.enrouteTime,
      this.atSceneTime,
      this.atPatientTime,
      this.rerouteTime,
      this.transportingTime,
      this.atHospitalTime,
      this.reasonAbort});

  _ResponseTimeScreenA createState() => _ResponseTimeScreenA();
}

class _ResponseTimeScreenA extends State<ResponseTimeScreenA>
    with AutomaticKeepAliveClientMixin<ResponseTimeScreenA> {
  @override
  bool get wantKeepAlive => true;
  // {
  TimeBloc timeBloc;
  ResponseTime responseTime;

  StreamController<String> abortMissionController = new StreamController.broadcast();
  String missionSelected = " ";

  @override
  void didChangeDependencies() {
    timeBloc = BlocProvider.of<TimeBloc>(context);
    responseTime = new ResponseTime(
      dispatchTime: widget.dispatchTime,
      enrouteTime: widget.enrouteTime,
      atSceneTime: widget.atSceneTime,
      atPatientTime: widget.atPatientTime,
      rerouteTime: widget.rerouteTime,
      transportingTime: widget.transportingTime,
      atHospitalTime: widget.atHospitalTime,
      reasonAbort: widget.reasonAbort
    );
    super.didChangeDependencies();
  }

  @override
  void initState() {
    missionSelected = widget.reasonAbort;
  }

  @override
  Widget build(BuildContext context) {
   print("1 $missionSelected");
        return Container(
          color: Colors.grey,
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              margin: EdgeInsets.all(12.0),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Center(child: HeaderSection("Response Time")),
                  SizedBox(
                    height: 10,
                  ),
                  _buildCardTime(
                      Response.dispatch, widget.dispatchTime, _onPressedDispatch),
                  _buildCardTime(
                      Response.enroute, widget.enrouteTime, _onPressedEnroute),
                  _buildCardTime(
                      Response.atScene, widget.atSceneTime, _onPressedAtScene),
                  _buildCardTime(Response.atPatient, widget.atPatientTime,
                      _onPressedAtPatient),
                  _buildCardTime(Response.transport, widget.transportingTime,
                      _onPressedTransporting),
                  _buildCardTime(Response.atHospital, widget.atHospitalTime,
                      _onPressedAtHospital),
                  _buildCardTime(
                      Response.reroute, widget.rerouteTime, _onPressedReroute),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 500,
                    child: DropDownList("Mission abort", MISSION_ABORT, missionSelected)
                //     child: CustomDropDown(
                //       labelText: "Mission abort",
                //       items: [
                //         " ",
                //         "arrive at scene no patient found",
                //         "stand down"
                //       ],
                //       // callback: missionCallback,
                //       // itemSelected: missionSelected,
                //       controller: _abortMissionController,
                //       initialData: "stand down",
                // ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  getTitle(selector) {
    switch (selector) {
      case Response.dispatch:
        return "Dispatch Time";
        break;
      case Response.enroute:
        return "Enroute Time";
        break;
      case Response.atScene:
        return "At Scene Time";
        break;
      case Response.atPatient:
        return "At Patient Time";
        break;
      case Response.transport:
        return "Transporting Time";
        break;
      case Response.reroute:
        return "Reroute Time";
        break;
      case Response.atHospital:
        return "At Hospital Time";
        break;
      case Response.abortMission:
        return "Mission Abort";
        break;
      default:
        return "";
        break;
    }
  }

  _onPressedDispatch() {
    setState(() {
      widget.dispatchTime = DateTime.now();
      responseTime.dispatchTime = widget.dispatchTime;
      timeBloc.add(AddTime(responseTime: responseTime));
    });
  }

  _onPressedEnroute() {
    setState(() {
      widget.enrouteTime = DateTime.now();
      responseTime.enrouteTime = widget.enrouteTime;
      timeBloc.add(AddTime(responseTime: responseTime));
    });
  }

  _onPressedAtScene() {
    setState(() {
      widget.atSceneTime = DateTime.now();
      responseTime.atSceneTime = widget.atSceneTime;
      timeBloc.add(AddTime(responseTime: responseTime));
    });
  }

  _onPressedAtPatient() {
    setState(() {
      widget.atPatientTime = DateTime.now();
      responseTime.atPatientTime = widget.atPatientTime;
      timeBloc.add(AddTime(responseTime: responseTime));
    });
  }

  _onPressedTransporting() {
    setState(() {
      widget.transportingTime = DateTime.now();
      responseTime.transportingTime = widget.transportingTime;
      timeBloc.add(AddTime(responseTime: responseTime));
    });
  }

  _onPressedReroute() {
    setState(() {
      widget.rerouteTime = DateTime.now();
      responseTime.rerouteTime = widget.rerouteTime;
      timeBloc.add(AddTime(responseTime: responseTime));
    });
  }

  _onPressedAtHospital() {
    setState(() {
      widget.atHospitalTime = DateTime.now();
      responseTime.atHospitalTime = widget.atHospitalTime;
      timeBloc.add(AddTime(responseTime: responseTime));
    });
  }

  _buildCardTime(selector, initialData, Function onPressed) {
    var labelText = getTitle(selector);
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              labelText,
              style: TextStyle(
                  color: Colors.grey,
                  // fontSize: 18,
                  fontFamily: "OpenSans"),
            ),
          ),
          subtitle: Text(
            initialData != null
                ? DateFormat("HH:mm").format(initialData)
                : "No data",
            style: TextStyle(
                // fontFamily: "OpenSans",
                fontSize: initialData != null ? 30 : 16,
                // fontWeight: FontWeight.bold,
                color:
                    // initialData != null ?
                    Colors.black
                // : Colors.grey
                // fontSize: 30,
                ),
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) =>
                      _timerPopup(labelText, initialData, selector),
                );
              },
            ),
            SizedBox(
              width: 20,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Text(
                  "NOW",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.green,
                onPressed: onPressed)
          ]),
        ),
      ),
    );
  }

    Widget DropDownList(labelText, List<String> list, initialData) {
    final controller = abortMissionController;

    // if (!list.contains(initialData)) initialData = "";

    print("initialData: $initialData");
    return Container(
        // width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: StreamBuilder(
                stream: controller.stream,
                initialData: initialData,
                builder: (context, snapshot) {
                  print("Streambuilder value");
                  print(snapshot.data);
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
                        widget.reasonAbort = valueChanged;
                        responseTime.reasonAbort = widget.reasonAbort;
                        timeBloc.add(AddTime(responseTime: responseTime));
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
  }

  _timerPopup(labelText, initialData, selector) {
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
                switch (selector) {
                  case Response.dispatch:
                    setState(() {
                      widget.dispatchTime = dateTime;
                      timeBloc.add(
                          AddTime(selector: Response.dispatch, time: dateTime));
                    });

                    break;
                  case Response.enroute:
                    setState(() {
                      widget.enrouteTime = dateTime;
                      timeBloc.add(
                          AddTime(selector: Response.enroute, time: dateTime));
                    });
                    break;
                  case Response.atScene:
                    setState(() {
                      widget.atSceneTime = dateTime;
                      timeBloc.add(AddTime(
                          selector: Response.atScene,
                          time: widget.atSceneTime));
                    });
                    break;
                  case Response.atPatient:
                    setState(() {
                      widget.atPatientTime = dateTime;
                      timeBloc.add(AddTime(
                          selector: Response.atPatient,
                          time: widget.atPatientTime));
                    });
                    break;
                  case Response.transport:
                    setState(() {
                      widget.transportingTime = dateTime;
                      timeBloc.add(AddTime(
                          selector: Response.transport,
                          time: widget.transportingTime));
                    });
                    break;
                  case Response.reroute:
                    setState(() {
                      widget.rerouteTime = dateTime;
                      timeBloc.add(AddTime(
                          selector: Response.reroute,
                          time: widget.rerouteTime));
                    });
                    break;
                  case Response.atHospital:
                    setState(() {
                      widget.atHospitalTime = dateTime;
                      timeBloc.add(AddTime(
                          selector: Response.atHospital,
                          time: widget.atHospitalTime));
                    });
                    break;
                  default:
                    // return "";
                    break;
                }
              },
            ))
          ],
        ));
  }
}
