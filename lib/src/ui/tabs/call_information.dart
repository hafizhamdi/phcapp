import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  "Transportaion area",
  "Farm",
  "Country side",
  "Waterfall/Sea",
  "Medical service area",
  "Recreational/Cultrural/Public area"
];

const LIST_DISTANCES = ["", "< 5km", "5-10km", "> 10km"];

class CallInformationScreen extends StatefulWidget {
  final CallInformation call_information;

  CallInformationScreen({this.call_information});

  _CallInfoState createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInformationScreen> {
  CallInfoBloc callInfoBloc;

  Completer<void> _refreshCompleter;
  // CallInfoBloc infoBloc = new CallInfoBloc();

  String _locationTypeSelected = "";
  String _distancesSelected = "";
  String _priority = "";

  final _formKey = GlobalKey<FormState>();

  var receivedController = TextEditingController();
  var cardNoController = TextEditingController();
  var contactNoController = TextEditingController();
  var eventCodeController = TextEditingController();
  var incidentController = TextEditingController();
  var locationController = TextEditingController();
  var landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _refreshCompleter = Completer<void>();
    callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    var assignId = widget.call_information.assign_id;
    print("assignid=$assignId");
    callInfoBloc.add(LoadCallInfo(assign_id: assignId));

    cardNoController.text =
        widget.call_information.callcard_no; //.callcardNo.value;

    receivedController.text = widget.call_information.call_received;
    contactNoController.text = widget.call_information.caller_contactno;
    eventCodeController.text = widget.call_information.event_code;
    incidentController.text = widget.call_information.incident_desc;
    locationController.text = widget.call_information.incident_location;
    landmarkController.text = widget.call_information.landmark;
  }

  @override
  void dispose() {
    super.dispose();

    var call = CallInformation(
        callcardNo: cardNoController.text,
        callReceived: receivedController.text,
        callerContactno: contactNoController.text,
        eventCode: eventCodeController.text,
        priority: _priority,
        incidentDesc: incidentController.text,
        incidentLocation: locationController.text,
        locationType: _locationTypeSelected,
        landmark: landmarkController.text,
        distanceToScene: _distancesSelected,
        plateNo: widget.call_information.plate_no,
        assignId: widget.call_information.assign_id);

    callInfoBloc.add(AddCallInfo(call_information: call));

    // final snackBar = SnackBar(
    //   content: Text("Call information push!"),
    //   action: SnackBarAction(
    //     label: "Undo",
    //     onPressed: () {},
    //   ),
    // );

    // if (_formKey.currentState.validate()) {
    // Scaffold.of(context).showSnackBar(snackBar);
    // }

    print("im dispose atas arahan pkp");
    cardNoController.dispose();
    receivedController.dispose();
    contactNoController.dispose();
    eventCodeController.dispose();
    incidentController.dispose();
    locationController.dispose();
    landmarkController.dispose();
  }

  void priorityCallback(String selected) {
    print(selected);
    setState(() {
      _priority = selected;
    });
  }

  void locCallback(String selected) {
    setState(() {
      _locationTypeSelected = selected;
    });
  }

  void distCallback(String selected) {
    setState(() {
      _distancesSelected = selected;
    });
  }

  Widget _dateReceived(labelText, controller) {
    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }

  @override
  Widget build(BuildContext context) {
    print("build call info run again");

    void callback(String item, int index) {}

    var maskEventCode = MaskTextInputFormatter(
        mask: "##/#/##/#", filter: {"#": RegExp(r'[a-zA-Z0-9]')});

    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: BlocConsumer<CallInfoBloc, CallInfoState>(
              listener: (context, state) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }, builder: (context, state) {
            if (state is CallInfoLoaded) {
              print("UI:CALLINFOLOADED");
              callInfoBloc.cardNoController.text =
                  state.call_information.callcard_no;
              cardNoController.text = state.call_information.callcard_no;
              contactNoController.text =
                  state.call_information.caller_contactno;
              receivedController.text = state.call_information.call_received;
              eventCodeController.text = state.call_information.event_code;
              incidentController.text = state.call_information.incident_desc;
              locationController.text =
                  state.call_information.incident_location;
              landmarkController.text = state.call_information.landmark;
              print(state.call_information.callcard_no);

              // _locationTypeSelected = state.call_information.location_type;
              // _priority = state.call_information.priority;
              // _distancesSelected = state.call_information.distance_to_scene;
            } else {
              print(
                  "THis is not cool im not loaded state, get datafrom previous yo!");
            }

            return Center(
              child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        HeaderSection("Call Information"),
                        // TextEditLabel(
                        //     labelText: "Call Card No",
                        //     controller: cardNoController),

                        TextInput(
                          labelText: "Call Card No",
                          controller: cardNoController,
                          // stream: infoBloc.callcarNoStream,
                          // updateText: infoBloc.setCallcardNo,
                        ),
                        _dateReceived("Date Received", receivedController),
                        TextInput(
                          labelText: "Caller Contact No",
                          controller: contactNoController,
                          inputType:
                              TextInputType.numberWithOptions(signed: true),
                          hintText: "0139446197",
                        ),
                        TextInput(
                          labelText: "Event Code",
                          controller: eventCodeController,
                          hintText: "37/C/02/W",
                          maskFormater: maskEventCode,
                        ),
                        DropDownList("Priority", LIST_PRIORITY,
                            priorityCallback, _priority),
                        // TextInput(
                        //   labelText: "Priority",
                        //   controller: _priority_ctrl,
                        //   hintText: "1 - 4",
                        //   inputType: TextInputType.numberWithOptions(),
                        //   validator: validatePriority,
                        // ),
                        TextInput(
                            labelText: "Incident Description",
                            controller: incidentController),
                        TextInput(
                            labelText: "Incident Location",
                            controller: locationController),
                        TextInput(
                            labelText: "Landmark",
                            controller: landmarkController),
                        DropDownList("Location Type", LIST_LOCTYPE, locCallback,
                            _locationTypeSelected),
                        DropDownList("Distance to Scene", LIST_DISTANCES,
                            distCallback, _distancesSelected),
                      ],
                    ),
                  )),
            );
            // }
            // return Center(child: CircularProgressIndicator());
          })),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.publish),
      //   onPressed: () {
      //     print("press publish");

      // var call = CallInformation(
      //     callcardNo: cardNoController.text,
      //     callReceived: receivedController.text,
      //     callerContactno: contactNoController.text,
      //     eventCode: eventCodeController.text,
      //     priority: _priority,
      //     incidentDesc: incidentController.text,
      //     incidentLocation: locationController.text,
      //     locationType: _locationTypeSelected,
      //     landmark: landmarkController.text,
      //     distanceToScene: _distancesSelected,
      //     plateNo: widget.call_information.plate_no,
      //     assignId: widget.call_information.assign_id);

      // callInfoBloc.add(AddCallInfo(call_information: call));

      // final snackBar = SnackBar(
      //   content: Text("Call information push!"),
      //   action: SnackBarAction(
      //     label: "Undo",
      //     onPressed: () {},
      //   ),
      // );

      // if (_formKey.currentState.validate()) {
      //   Scaffold.of(context).showSnackBar(snackBar);
      // }
      //   },
      // )
    );
  }

  String changeStandardDateFormat(var mydate) {
    assert(mydate != null);

    // var date = mydate.toString();

    var elem = mydate.split('/');
    var dd = elem[0];
    var mm = elem[1];
    var yyyy = elem[2].substring(0, 4);
    var time = elem[2].substring(4);

    // DateFormat("dd/MM/yyyy HH:mm:ss")
    //     .format(widget.call_information.call_received);

    print(dd + mm + yyyy + time);
    return yyyy + "-" + mm + "-" + dd + time;
  }
}

class TextInput extends StatelessWidget {
  final labelText;
  final controller;
  final hintText;
  final inputType;
  final validator;
  final maskFormater;
  final stream;
  final updateText;

  TextInput(
      {this.labelText,
      this.controller,
      this.hintText,
      this.inputType,
      this.validator,
      this.maskFormater,
      this.stream,
      this.updateText});

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child:
                // StreamBuilder(
                //     stream: stream,
                //     builder: (context, snapshot) {
                //       return
                // },)
                TextFormField(
                    validator: validator,
                    // onChanged: updateText,
                    // maxLines: null,
                    inputFormatters: maskFormater != null ? [maskFormater] : [],
                    keyboardType: inputType,
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: hintText,
                        labelText: labelText,
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: new BorderSide(),
                        )))
            // })
            ));
  }
}

class DropDownList extends StatelessWidget {
  final String labelText;
  final List<String> list;
  final Function callback;
  final String selected;

  DropDownList(this.labelText, this.list, this.callback, this.selected);

  String _currentItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: DropdownButtonFormField(
                isDense: true,
                items: list.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                      child: Text(dropDownStringItem),
                      value: dropDownStringItem);
                }).toList(),
                onChanged: (String newValueSelected) {
                  callback(newValueSelected);
                },
                value: selected,
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }
}
