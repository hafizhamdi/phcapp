import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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

const LIST_DISTANCES = ["", "< 5km", "5-10km", "> 10km"];

class CallInformationScreen extends StatefulWidget {
  final CallInformation call_information;

  CallInformationScreen({this.call_information});

  _CallInfoState createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInformationScreen> {
  CallInfoBloc callInfoBloc;

  Completer<void> _refreshCompleter;

  StreamController<String> _locationController = new StreamController<String>();
  StreamController<String> _distanceController = new StreamController<String>();
  StreamController<String> _priorityController = new StreamController<String>();

  String _location;
  String _distance;
  String _priority;

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
    callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    callInfoBloc
        .add(LoadCallInfo(assign_id: widget.call_information.assign_id));
  }

  @override
  void dispose() {
    _priorityController.close();
    _distanceController.close();
    _locationController.close();

    print(_location);

    cardNoController.dispose();
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

  String setField(data) {
    print(data);
    if (data != null) return data;
    return data;
  }

  Widget _buildBloc() {
    var maskEventCode = MaskTextInputFormatter(
        mask: "##/#/##/#", filter: {"#": RegExp(r'[a-zA-Z0-9]')});

    return BlocConsumer<CallInfoBloc, CallInfoState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CallInfoLoaded) {
            final currentState = state.call_information;

            print("UI:CALLINFOLOADED");
            cardNoController.text = setField(currentState.callcard_no);
            contactNoController.text = setField(currentState.caller_contactno);
            receivedController.text = setField(currentState.call_received);
            eventCodeController.text = setField(currentState.event_code);
            incidentController.text = setField(currentState.incident_desc);
            locationController.text = setField(currentState.incident_location);
            landmarkController.text = setField(currentState.landmark);

            _priority = setField(currentState.priority);
            _location = setField(currentState.location_type);
            _distance = setField(currentState.distance_to_scene);
          }

          return Center(
            child: Card(
                margin: EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      HeaderSection("Call Information"),
                      // // TextEditLabel(
                      // //     labelText: "Call Card No",
                      // //     controller: cardNoController),

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
                          InputOption.priority, _priority),
                      TextInput(
                          labelText: "Incident Description",
                          controller: incidentController),
                      TextInput(
                          labelText: "Incident Location",
                          controller: locationController),
                      TextInput(
                          labelText: "Landmark",
                          controller: landmarkController),
                      DropDownList("Location type", LIST_LOCTYPE,
                          InputOption.location, _location),
                      DropDownList("Distance to scene", LIST_DISTANCES,
                          InputOption.distance, _distance)
                    ],
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("build call info run again");

    void callback(String item, int index) {}

    return Scaffold(
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(), child: _buildBloc()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var call = CallInformation(
              callcardNo: cardNoController.text,
              callReceived: receivedController.text,
              callerContactno: contactNoController.text,
              eventCode: eventCodeController.text,
              priority: _priority,
              incidentDesc: incidentController.text,
              incidentLocation: locationController.text,
              locationType: _location,
              landmark: landmarkController.text,
              distanceToScene: _distance,
              plateNo: widget.call_information.plate_no,
              assignId: widget.call_information.assign_id);

          callInfoBloc.add(AddCallInfo(call_information: call));

          final snackBar = SnackBar(
            content: Text("Call information has been saved!"),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Icon(Icons.save),
      ),
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
    //               })));
  }
}

class TextInput extends StatelessWidget {
  final labelText;
  final controller;
  final inputType;
  final maskFormater;
  final hintText;
  // final mask

  TextInput(
      {this.labelText,
      this.controller,
      this.maskFormater,
      this.inputType,
      this.hintText});

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
                    // validator: validator,
                    // onChanged: updateText,
                    // maxLines: null,
                    inputFormatters: maskFormater != null ? [maskFormater] : [],
                    // keyboardType: inputType,
                    controller: controller,
                    decoration: InputDecoration(
                        // hintText: hintText,
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
