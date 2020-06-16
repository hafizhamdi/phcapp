// import 'dart:async';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:phcapp/custom/drop_downlist.dart';
// import 'package:phcapp/custom/header_section.dart';
// import 'package:phcapp/src/blocs/blocs.dart';
// import 'package:phcapp/src/models/phc.dart';

enum Response {
  dispatch,
  enroute,
  atScene,
  atPatient,
  atHospital,
  transport,
  reroute
}

// const LIST_MISSIONABORT = [
//   "",
//   "Arrive at scene no patient found",
//   "Stand down"
// ];

// class ResponseTimeScreen extends StatefulWidget {
//   final ResponseTime response_time;
//   final assign_id;

//   ResponseTimeScreen({this.response_time, this.assign_id});

//   @override
//   _TimerState createState() => _TimerState();
// }

// class _TimerState extends State<ResponseTimeScreen>
//     with AutomaticKeepAliveClientMixin<ResponseTimeScreen> {
//   @override
//   bool get wantKeepAlive => true;
//   DateTime _dispatchTime;
//   DateTime _enrouteTime;
//   DateTime _atSceneTime;
//   DateTime _atPatientTime;
//   DateTime _transportTime;
//   DateTime _atHospitalTime;
//   DateTime _rerouteTime;
//   String missionAbort;
//   TimeBloc timeBloc;

//   final StreamController<DateTime> _dispatchController =
//       StreamController<DateTime>();
//   final StreamController<DateTime> _enrouteController =
//       StreamController<DateTime>();
//   final StreamController<DateTime> _atSceneController =
//       StreamController<DateTime>();
//   final StreamController<DateTime> _atPatientController =
//       StreamController<DateTime>();
//   final StreamController<DateTime> _transportController =
//       StreamController<DateTime>();
//   final StreamController<DateTime> _atHospitalController =
//       StreamController<DateTime>();
//   final StreamController<DateTime> _rerouteController =
//       StreamController<DateTime>();

//   final StreamController<String> _missionController =
//       new StreamController<String>();

//   // @override
//   // void initState() {
//   //   // timeBloc = BlocProvider.of<TimeBloc>(context);
//   //   // timeBloc.add(LoadTime(assign_id: widget.assign_id));
//   // }

//   @override
//   void dispose() {
//     _dispatchController.close();
//     _enrouteController.close();
//     _atSceneController.close();
//     _atPatientController.close();
//     _transportController.close();
//     _atHospitalController.close();
//     _rerouteController.close();
//     _missionController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final timeBloc = BlocProvider.of<TimeBloc>(context);

//     if (widget.response_time != null) {
//       timeBloc.add(LoadTime(
//           assign_id: widget.assign_id, responseTime: widget.response_time));
//       missionAbort = widget.response_time.reasonAbort;
//     } else {
//       timeBloc.add(LoadTime(
//           assign_id: widget.assign_id, responseTime: new ResponseTime()));
//     }

//     return Scaffold(
//       body: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: ConstrainedBox(
//               constraints: BoxConstraints(), child: _buildMainCard(context))),
//       // floatingActionButton: FloatingActionButton(
//       //   heroTag: 220,
//       //   onPressed: () {
//       //     timeBloc.add(AddResponseTime(
//       //         assignId: widget.assign_id,
//       //         responseTime: new ResponseTime(
//       //             dispatchTime: _dispatchTime,
//       //             enrouteTime: _enrouteTime,
//       //             atSceneTime: _atSceneTime,
//       //             atPatientTime: _atPatientTime,
//       //             transportingTime: _transportTime,
//       //             atHospitalTime: _atHospitalTime,
//       //             rerouteTime: _rerouteTime,
//       //             reasonAbort: missionAbort)));

//       //     final snackBar = SnackBar(
//       //       content: Text("Response time has been saved!"),
//       //     );
//       //     Scaffold.of(context).showSnackBar(snackBar);
//       //   },
//       //   child: Icon(Icons.save),
//       // ),
//     );
//   }

//   DateTime parseTime(String datetime) {
//     print(datetime);

//     if (datetime == "null" || datetime == null || datetime == '') {
//       return null;
//     }
//     return DateTime.parse(datetime);
//   }

//   Widget _buildMainCard(BuildContext context) {
//     return Center(
//         child: Card(
//             margin: EdgeInsets.all(12.0),
//             // width: 500,
//             child: Container(
//                 padding: EdgeInsets.all(10),
//                 child: BlocBuilder<TimeBloc, TimeState>(
//                   builder: (context, state) {
//                     if (state is TimeLoaded) {
//                       // final currentState = state.responseTime;
//                       // final dispatchTime = parseTime(currentState.dispatchTime);
//                       // final enrouteTime = parseTime(currentState.enrouteTime);
//                       // final atSceneTime = parseTime(currentState.atSceneTime);
//                       // final atPatientTime = parseTime(currentState.atPatientTime);
//                       // final atHospitalTime = parseTime(currentState.atHospitalTime);
//                       // final transportingTime =
//                       //     parseTime(currentState.transportingTime);
//                       // final rerouteTime = parseTime(currentState.rerouteTime);

//                       return BuildTimeComponent();
//                     }

//                     //   return Container();
//                   },
//                 ))));
//   }

//   DateTime getInitialTimestamp(selector) {
//     final data = widget.response_time;

//     switch (selector) {
//       case Response.dispatch:
//         return data.dispatchTime;
//         break;
//       case Response.enroute:
//         return data.enrouteTime;
//         break;
//       case Response.atScene:
//         return data.atSceneTime;
//         break;
//       case Response.atPatient:
//         return data.atPatientTime;
//         break;
//       case Response.transport:
//         return data.transportingTime;
//         break;
//       case Response.atHospital:
//         return data.atHospitalTime;
//         break;
//       case Response.reroute:
//         return data.rerouteTime;
//         break;
//       default:
//         return null;
//         break;
//     }
//   }

//   StreamController getStreamController(selector) {
//     switch (selector) {
//       case Response.dispatch:
//         return _dispatchController;
//         break;
//       case Response.enroute:
//         return _enrouteController;
//         break;
//       case Response.atScene:
//         return _atSceneController;
//         break;
//       case Response.atPatient:
//         return _atPatientController;
//         break;
//       case Response.transport:
//         return _transportController;
//         break;
//       case Response.atHospital:
//         return _atHospitalController;
//         break;
//       case Response.reroute:
//         return _rerouteController;
//         break;
//       default:
//         return new StreamController();
//         break;
//     }
//   }

//   void setTimestamp(DateTime dateTime, selector) {
//     switch (selector) {
//       case Response.dispatch:
//         _dispatchTime = dateTime;
//         break;
//       case Response.enroute:
//         _enrouteTime = dateTime;
//         break;
//       case Response.atScene:
//         _atSceneTime = dateTime;
//         break;
//       case Response.atPatient:
//         _atPatientTime = dateTime;
//         break;
//       case Response.transport:
//         _transportTime = dateTime;
//         break;
//       case Response.atHospital:
//         _atHospitalTime = dateTime;
//         break;
//       case Response.reroute:
//         _rerouteTime = dateTime;
//         break;

//       default:
//     }
//   }

//   Widget _buildListTile(labelText, selector) {
//     final controller = getStreamController(selector);
//     return ListTile(
//         title: Padding(
//             padding: EdgeInsets.only(bottom: 10),
//             child: Text(
//               labelText,
//               style: TextStyle(
//                   color: Colors.grey, fontSize: 18, fontFamily: "Raleway"),
//             )),
//         subtitle: _buildSubtitle(controller, selector),
//         trailing: _buildTrailing(labelText, selector));
//   }

//   Widget _timerPopup(labelText, selector) {
//     final initialData = getInitialTimestamp(selector);
//     final streamController = getStreamController(selector);
//     var titleButton = CupertinoButton(
//       child: Text(labelText),
//       onPressed: () {
//         // Navigator.of(context).pop();
//       },
//     );

//     var doneButton = CupertinoButton(
//       child: Text("Done"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );

//     return SizedBox(
//         height: 200.0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Container(
//                 alignment: Alignment.centerRight,
//                 decoration: BoxDecoration(
//                     color: const Color.fromRGBO(249, 249, 247, 1.0),
//                     border: Border(
//                         bottom: const BorderSide(
//                             width: 0.5, color: Colors.black38))),
//                 child: Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [titleButton, doneButton]))),
//             Expanded(
//                 child: CupertinoDatePicker(
//               mode: CupertinoDatePickerMode.dateAndTime,
//               initialDateTime: initialData,
//               onDateTimeChanged: (dateTime) {
//                 streamController.sink.add(dateTime);
//               },
//             ))
//           ],
//         ));
//   }

//   Widget _buildTrailing(labelText, selector) {
//     final streamController = getStreamController(selector);
//     return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
//       IconButton(
//         icon: Icon(Icons.edit),
//         onPressed: () {
//           showCupertinoModalPopup(
//               context: context,
//               builder: (context) => _timerPopup(labelText, selector));
//         },
//       ),
//       RaisedButton(
//         child: Text(
//           "NOW",
//           style: TextStyle(color: Colors.white),
//         ),
//         color: Colors.green,
//         onPressed: () {
//           // streamController.sink.add(DateTime.now());

//           // setTimestamp(DateTime.now(), selector);

//           // final snackBar = SnackBar(
//           //   content: Text(labelText + " changed!"),
//           //   // action: SnackBarAction(
//           //   // label: "Undo",
//           //   //   onPressed: () {},
//           //   // ),
//           // );
//           // Scaffold.of(context).showSnackBar(snackBar);
//         },
//       )
//     ]);
//   }

//   Widget _buildTimeCard(labelText, selector) {
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         width: 500,
//         child: Card(
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 child: _buildListTile(labelText, selector))));
//   }

//   Widget DropDownList(labelText, List<String> list, controller, initialData) {
//     // final controller = getStreamController(selector);

//     // print(selector);
//     print(initialData);
//     return Container(
//         width: 500,
//         child: Padding(
//             padding: EdgeInsets.all(16),
//             child: StreamBuilder(
//                 stream: controller.stream,
//                 initialData: initialData,
//                 builder: (context, snapshot) {
//                   print("Streambuilder value");
//                   print(snapshot.data);

//                   missionAbort = snapshot.data;

//                   // setInputOption(selector, snapshot.data);
//                   // child:

//                   return DropdownButtonFormField(
//                       isDense: true,
//                       items: list.map((String dropDownStringItem) {
//                         return DropdownMenuItem<String>(
//                             child: Text(dropDownStringItem),
//                             value: dropDownStringItem);
//                       }).toList(),
//                       onChanged: (valueChanged) {
//                         print("WHATS IS INDESIDE:$valueChanged");
//                         controller.sink.add(valueChanged);
//                       },
//                       value: snapshot.data,
//                       decoration: InputDecoration(
//                           labelText: labelText,
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             borderRadius: new BorderRadius.circular(10.0),
//                             borderSide: new BorderSide(),
//                           )));
//                 })));
//     //               })));
//   }
// }

// class BuildTimeComponent extends StatelessWidget {
//   final ResponseTime responseTime;

//   BuildTimeComponent({this.responseTime});

//   _buildSubtitle(streamController, initialTime) {
//     // final timestamp = getInitialTimestamp(selector);

//     return StreamBuilder(
//       stream: streamController.stream,
//       initialData: initialTime,
//       builder: (context, snapshot) {
//         // setTimestamp(snapshot.data, selector);

//         if (snapshot.data == null) {
//           return Text("No data",
//               style: TextStyle(fontFamily: "OpenSans", fontSize: 16
//                   // fontWeight: FontWeight.bold,
//                   // fontSize: 30,
//                   ));
//         }

//         return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 DateFormat("HH:mm").format(snapshot.data),
//                 style: TextStyle(
//                   fontFamily: "Roboto",
//                   fontWeight: FontWeight.bold,
//                   fontSize: 30,
//                 ),
//               ),
//               Text(
//                 DateFormat("dd MMM yyyy").format(snapshot.data),
//                 style: TextStyle(fontFamily: "OpenSans"),
//               ),
//             ]);
//       },
//     );
//   }

//   // StreamController getStreamController(selector) {
//   //   switch (selector) {
//   //     case Response.dispatch:
//   //       return _dispatchController;
//   //       break;
//   //     case Response.enroute:
//   //       return _enrouteController;
//   //       break;
//   //     case Response.atScene:
//   //       return _atSceneController;
//   //       break;
//   //     case Response.atPatient:
//   //       return _atPatientController;
//   //       break;
//   //     case Response.transport:
//   //       return _transportController;
//   //       break;
//   //     case Response.atHospital:
//   //       return _atHospitalController;
//   //       break;
//   //     case Response.reroute:
//   //       return _rerouteController;
//   //       break;
//   //     default:
//   //       return new StreamController();
//   //       break;
//   //   }
//   // }

//   _buildListTile(labelText, selector) {
//     // final controller = getStreamController(selector);
//     return ListTile(
//         title: Padding(
//             padding: EdgeInsets.only(bottom: 10),
//             child: Text(
//               labelText,
//               style: TextStyle(
//                   color: Colors.grey, fontSize: 18, fontFamily: "Raleway"),
//             )),
//         subtitle: _buildSubtitle(controller, selector),
//         trailing: _buildTrailing(labelText, selector));
//   }

//   _buildTimeCard(labelText, selector) {
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         width: 500,
//         child: Card(
//             child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 child: _buildListTile(labelText, selector))));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Center(child: HeaderSection("Response Time")),
//         Container(
//           height: 1,
//           color: Colors.grey,
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         _buildTimeCard("Dispatch Time", Response.dispatch),
//         _buildTimeCard("Enroute Time", Response.enroute),
//         _buildTimeCard("At Scene Time", Response.atScene),
//         _buildTimeCard("At Patient Time", Response.atPatient),
//         _buildTimeCard("Transporting Time", Response.transport),
//         _buildTimeCard("At Hospital Time", Response.atHospital),
//         _buildTimeCard("Reroute Time", Response.reroute),
//         Padding(
//           padding: EdgeInsets.all(10),
//         ),
//         DropDownList("Mission Abort", LIST_MISSIONABORT, _missionController,
//             missionAbort)
//       ],
//     );
//     ;
//   }
// }

class ResponseTimeScreen extends StatelessWidget {
  final ResponseTime responseTime;

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
              atHospitalTime: currentState.responseTime.atHospitalTime);
        }
        return ResponseTimeScreenA(
            dispatchTime: responseTime.dispatchTime,
            enrouteTime: responseTime.enrouteTime,
            atSceneTime: responseTime.atSceneTime,
            atPatientTime: responseTime.atPatientTime,
            transportingTime: responseTime.transportingTime,
            rerouteTime: responseTime.rerouteTime,
            atHospitalTime: responseTime.atHospitalTime);
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

  ResponseTimeScreenA(
      {this.dispatchTime,
      this.enrouteTime,
      this.atSceneTime,
      this.atPatientTime,
      this.rerouteTime,
      this.transportingTime,
      this.atHospitalTime});

  _ResponseTimeScreenA createState() => _ResponseTimeScreenA();
}

class _ResponseTimeScreenA extends State<ResponseTimeScreenA>
    with AutomaticKeepAliveClientMixin<ResponseTimeScreenA> {
  @override
  bool get wantKeepAlive => true;
  // {
  TimeBloc timeBloc;
  ResponseTime responseTime;

  @override
  void didChangeDependencies() {
    timeBloc = BlocProvider.of<TimeBloc>(context);
    responseTime = new ResponseTime();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(12.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Center(child: HeaderSection("Response Time")),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            _buildCardTime(
                Response.dispatch, widget.dispatchTime, _onPressedDispatch),
            _buildCardTime(
                Response.enroute, widget.enrouteTime, _onPressedEnroute),
            _buildCardTime(
                Response.atScene, widget.atSceneTime, _onPressedAtScene),
            _buildCardTime(
                Response.atPatient, widget.atPatientTime, _onPressedAtPatient),
            _buildCardTime(Response.transport, widget.transportingTime,
                _onPressedTransporting),
            _buildCardTime(Response.atHospital, widget.atHospitalTime,
                _onPressedAtHospital),
            _buildCardTime(
                Response.reroute, widget.rerouteTime, _onPressedReroute),
          ]),
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
                  color: Colors.grey, fontSize: 18, fontFamily: "Raleway"),
            ),
          ),
          subtitle: Text(
            initialData != null
                ? DateFormat("HH:mm").format(initialData)
                : "No data",
            style: TextStyle(fontFamily: "OpenSans", fontSize: 16
                // fontWeight: FontWeight.bold,
                // fontSize: 30,
                ),
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) =>
                      _timerPopup(labelText, initialData, selector),
                );
              },
            ),
            RaisedButton(
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
