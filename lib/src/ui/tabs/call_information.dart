import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phcapp/src/ui/tabs/edit_screen/edit_call_info.dart';

enum InputOption { priority, location, distance }
const LIST_PRIORITY = ["", "1", "2", "3", "4"];

const LIST_LOCTYPE = [
  "",
  "Home",
  "Street",
  "Highway",
  "Industrial area",
  "Construction",
  "Nursing home",
  "School",
  "Comercial area",
  "Sports area",
  "Transportation area",
  "Farm",
  "Country side",
  "Waterfall",
  "Sea",
  "Medical service area",
  "Recreational",
  "Cultrural",
  "Public area"
];

const LIST_DISTANCES = ["", "< 5 km", "5-10 km", "> 10 km"];

class CallInformationScreen extends StatefulWidget {
  final CallInformation call_information;

  CallInformationScreen({this.call_information});

  _CallInfoState createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInformationScreen>
    with AutomaticKeepAliveClientMixin<CallInformationScreen> {
  @override
  bool get wantKeepAlive => true;
  CallInfoBloc callInfoBloc;

  Completer<void> _refreshCompleter;

  StreamController<String> _locationController = new StreamController<String>();
  StreamController<String> _distanceController = new StreamController<String>();
  StreamController<String> _priorityController = new StreamController<String>();

  String _location;
  String _distance;
  String _priority;

  final _formKey = GlobalKey<FormState>();

  TextEditingController receivedController = TextEditingController();
  // text: DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now()));
  TextEditingController cardNoController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController eventCodeController = TextEditingController();
  TextEditingController incidentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  String initialValue;
  String cardNoValue = "";
  @override
  void didChangeDependencies() {
    // callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    // // print("widget.call_information.assign_id");
    // // print(widget.call_information.assign_id);
    // if (widget.call_information != null) {
    //   print("INISDE WIDGET INFO");
    //   receivedController.text = DateFormat("dd/MM/yyyy HH:mm:ss")
    //       .format(DateTime.parse(widget.call_information.call_received));
    //   cardNoValue = widget.call_information.callcard_no;
    //   callInfoBloc.cardNoController.sink
    //       .add(widget.call_information.callcard_no);
    //   // cardNoController.text = widget.call_information.callcard_no;
    //   contactNoController.text = widget.call_information.caller_contactno;
    //   eventCodeController.text = widget.call_information.event_code;
    //   incidentController.text = widget.call_information.incident_desc;
    //   locationController.text = widget.call_information.location_type;
    //   landmarkController.text = widget.call_information.landmark;

    //   _priority = widget.call_information.priority;
    //   _distance = widget.call_information.distance_to_scene;
    //   _location = widget.call_information.location_type;
    // }
    // // else {
    // //   print("NEW CALLCARD");
    // //   receivedController.text = DateTime.now().toIso8601String();
    // // }

    // callInfoBloc.cardNoController.stream.listen((value) {
    //   cardNoValue = value;
    //   print('Value from controller: $value');
    // });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priorityController.close();
    _distanceController.close();
    _locationController.close();

    // callInfoBloc.add(SaveCallInfo(
    //     callInformation:
    //         new CallInformation(callcardNo: cardNoController.text)));
    // print("call info captured");
    // cardNoController.dispose();
    receivedController.dispose();
    contactNoController.dispose();
    eventCodeController.dispose();
    incidentController.dispose();
    locationController.dispose();
    landmarkController.dispose();
    super.dispose();
  }

  Widget _dateReceived(labelText, controller) {
    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                enabled: false,
                controller: controller,
                validator: (value) {
                  if (value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }

  String setField(data) {
    print(data);
    if (data != null) return data;
    return data;
  }

  _buildBody(CallInformation data) {
    // final editData = data;
    // var callReceived = "";
    if (data == null) {
      data = new CallInformation(
          callReceived: DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now()));
      // } else {
      //   callReceived = DateFormat("dd/MM/yyyy HH:mm")
      //       .format(DateTime.parse(data.call_received));
    }
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
        ),
        // padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                margin:
                    EdgeInsets.only(left: 12.0, right: 12, top: 40, bottom: 12),

                child: Form(
                  autovalidate: true,
                  key: _formKey,
                  // child:

                  // Column(
                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                  //   // mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     Expanded(
                  // child:
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      // physics:
                      // physics: BouncingScrollPhysics(),
                      // crossAxisCount: 2,

                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // SizedBox(
                        //   height: 40,
                        // ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeaderSection("Call Information"),
                              IconButton(
                                  icon: Icon(Icons.edit,
                                      color: Colors.blueAccent),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => EditCallInfo(
                                                  call_information: data,
                                                )));
                                  }),
                            ]),
                        // Container(
                        //   height: 1,
                        //   color: Colors.grey,
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        // Expanded(
                        //     flex: 2,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MyTextField(
                                labelText: "Call Card No",
                                // controller: callInfoBloc.cardNoController,
                                initialData: data.callcardNo
                                // controller: cardNoController,
                                // stream: infoBloc.callcarNoStream,
                                // updateText: infoBloc.setCallcardNo,
                                ),
                            MyTextField(
                                labelText: "Date Received",
                                initialData:
                                    // data != null
                                    // ? DateFormat("dd/MM/yyyy hh:mm")
                                    //     .format(DateTime.parse(data.callReceived))
                                    // :
                                    data.callReceived),
                          ],
                        ),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // ),
                              MyTextField(
                                labelText: "Caller Contact No",
                                initialData: data.callerContactno,
                              ),
                              EventCodeField(
                                labelText: "Event Code",
                                initialData: data.eventCode,
                              ),
                            ]),
                        Row(crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MyTextField(
                                  labelText: "Location type",
                                  // LIST_LOCTYPE,
                                  //     InputOption.location,
                                  initialData: data.locationType),
                              MyTextField(
                                  labelText: "Priority",
                                  // LIST_PRIORITY, InputOption.priority,
                                  initialData: data.priority),
                            ]),

                        Row(children: [
                          MyTextField(
                              labelText: "Complaint",
                              initialData: data.incident_desc),
                        ]),
                        Row(children: <Widget>[
                          MyTextField(
                              labelText: "Incident Location",
                              initialData: data.incidentLocation),
                        ]),

                        Row(
                          children: <Widget>[
                            MyTextField(
                                labelText: "Landmark",
                                initialData: data.landmark),
                          ],
                        ),

                        Row(
                          children: <Widget>[
                            MyTextField(
                                labelText: "Distance to scene",
                                // LIST_DISTANCES,
                                //     InputOption.distance,
                                initialData: data.distanceToScene),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // ],
                // ),
                // ),
                // ),
                // ),
              ),
            ),
          ),
        ),
      ),
    );

    // });
  }

  convertDateToStandard(var datetime) {
    //dd/MM/yyyy HH:mm:ss to yyyy-MM-dd HH:mm:ss
    var split = datetime.split("/");
    var dd = split[0];
    var MM = split[1];
    var yyyy = split[2].substring(0, 4);

    var time = datetime.substring(11);

    print(time);
    return "$yyyy-$MM-$dd $time";
  }

  @override
  Widget build(BuildContext context) {
    final callInfoBloc = BlocProvider.of<CallInfoBloc>(context);

    print("build call info run again");
    // print(widget.call_information.toJson());

    void callback(String item, int index) {}

    return BlocBuilder<CallInfoBloc, CallInfoState>(
      builder: (context, state) {
        if (state is CallInfoLoaded) {
          return _buildBody(state.callInformation);
        } else if (widget.call_information != null) {
          return _buildBody(widget.call_information);
        } else {
          return _buildBody(null);
        }
      },
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 100,
      //   onPressed: () {
      // if (_formKey.currentState.validate()) {
      //   // print("widget.call_information.assign_id");
      //   // print(widget.call_information.assign_id);
      //   callInfoBloc.add(SaveCallInfo(
      //       callInformation: new CallInformation(
      //           callcardNo: cardNoValue,
      //           callReceived:
      //               convertDateToStandard(receivedController.text),
      //           callerContactno: contactNoController.text,
      //           eventCode: eventCodeController.text,
      //           priority: _priority,
      //           incidentDesc: incidentController.text,
      //           incidentLocation: locationController.text,
      //           landmark: landmarkController.text,
      //           locationType: _location,
      //           distanceToScene: _distance,
      //           assignId: widget.call_information.assign_id,
      //           plateNo: widget.call_information.plate_no)));

      //   final snackBar = SnackBar(
      //     content: Text("Call information has been saved!"),
      //   );
      //   Scaffold.of(context).showSnackBar(snackBar);
      // }

      // Navigator.push(context,
      //     CupertinoPageRoute(builder: (context) => EditCallInfo()));
      //   },
      //   child: Icon(Icons.edit),
      // ),
    );
  }

  String changeStandardDateFormat(var mydate) {
    assert(mydate != null);

    var elem = mydate.split('/');
    var dd = elem[0];
    var mm = elem[1];
    var yyyy = elem[2].substring(0, 4);
    var time = elem[2].substring(4);

    print(dd + mm + yyyy + time);
    return yyyy + "-" + mm + "-" + dd + time;
  }

  StreamController getStreamController(selector) {
    switch (selector) {
      case InputOption.priority:
        return _priorityController;
        break;
      case InputOption.distance:
        return _distanceController;
        break;
      case InputOption.location:
        return _locationController;
        break;
      default:
        return new StreamController();
    }
  }

  void setInputOption(selector, value) {
    switch (selector) {
      case InputOption.location:
        _location = value;
        break;
      case InputOption.distance:
        _distance = value;
        break;
      case InputOption.priority:
        _priority = value;
        break;
    }
  }
// }

  Widget DropDownList(labelText, List<String> list, selector, initialData) {
    final controller = getStreamController(selector);

    if (!list.contains(initialData)) initialData = "";

    print(selector);
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

                  setInputOption(selector, snapshot.data);
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
  }
}

class MyTextField extends StatelessWidget {
  final labelText;
  final initialData;

  MyTextField({
    this.labelText,
    this.initialData,
    // this.validator
  });

  TextEditingController myController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // height: 50,
        // width: 500,
        // width: 170,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                labelText,
                style: TextStyle(
                    fontFamily: "OpenSans",
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    (initialData != null) ? initialData : "",
                    style: TextStyle(fontSize: 16),
                  ))
              // TextFormField(
              //   enabled: false,
              //   initialValue: initialData,
              //   validator: (value) {
              //     if (value.length > 20) {
              //       return "Call Card No cannot be more than 20 characters";
              //     }

              //     if (value.isEmpty) {
              //       return 'This field is required';
              //     }
              //     return null;
              //   },
              //   inputFormatters: maskFormater != null ? [maskFormater] : [],
              //   onChanged: (value) {
              //     controller.sink.add(value.toUpperCase());
              //   },

              //   // onEditingComplete: (){

              //   // },
              //   // keyboardType: inputType,
              //   // controller: myController,
              //   decoration: InputDecoration(border: InputBorder.none
              //       //   // hintText: hintText,
              //       //   labelText: labelText,
              //       //   fillColor: Colors.white,
              //       //   border: new OutlineInputBorder(
              //       //     borderRadius: new BorderRadius.circular(10.0),
              //       //     borderSide: new BorderSide(),
              //       //   ),
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventCodeField extends StatelessWidget {
  final labelText;
  final initialData;

  EventCodeField({
    this.labelText,
    this.initialData,
    // this.validator
  });

  TextEditingController myController = new TextEditingController();

  var split = ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    _buildBox(text) {
      return Container(
        // padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 5),
        // margin: EdgeInsets.symmetric(horizontal: 5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          //  borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: Colors.grey[900]),
          ),
        ),
      );
    }

    if (initialData != null) {
      if (initialData.contains(',') == true) {
        split = initialData.split(',');
      }
    }
    return Expanded(
      child: Container(
        // height: 50,
        // width: 500,
        // width: 170,
        // child: Container(
        // child: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              labelText,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  // fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildBox(split[0]),
                      _buildBox(split[1]),
                      _buildBox(split[2]),
                      _buildBox(split[3]),
                    ],
                  ),
                )
                // Text(
                //   (initialData != null) ? initialData : "",
                //   style: TextStyle(fontSize: 16),

                )
            // TextFormField(
            //   enabled: false,
            //   initialValue: initialData,
            //   validator: (value) {
            //     if (value.length > 20) {
            //       return "Call Card No cannot be more than 20 characters";
            //     }

            //     if (value.isEmpty) {
            //       return 'This field is required';
            //     }
            //     return null;
            //   },
            //   inputFormatters: maskFormater != null ? [maskFormater] : [],
            //   onChanged: (value) {
            //     controller.sink.add(value.toUpperCase());
            //   },

            //   // onEditingComplete: (){

            //   // },
            //   // keyboardType: inputType,
            //   // controller: myController,
            //   decoration: InputDecoration(border: InputBorder.none
            //       //   // hintText: hintText,
            //       //   labelText: labelText,
            //       //   fillColor: Colors.white,
            //       //   border: new OutlineInputBorder(
            //       //     borderRadius: new BorderRadius.circular(10.0),
            //       //     borderSide: new BorderSide(),
            //       //   ),
            //       ),
            // ),
          ],
        ),
        // ),
        // ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final labelText;
  final controller;
  final inputType;
  final maskFormater;
  final hintText;

  TextInput({
    this.labelText,
    this.controller,
    this.maskFormater,
    this.inputType,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(

                // validator: validator,
                inputFormatters: maskFormater != null ? [maskFormater] : [],
                // keyboardType: inputType,
                enabled: false,
                controller: controller,
                decoration: InputDecoration(
                    hintText: hintText,
                    labelText: labelText,
                    fillColor: Colors.white,
                    enabled: false,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }
}
