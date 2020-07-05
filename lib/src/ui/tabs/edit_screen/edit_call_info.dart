import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

class EditCallInfo extends StatefulWidget {
  final CallInformation call_information;

  EditCallInfo({this.call_information});

  _EditCallInfo createState() => _EditCallInfo();
}

class _EditCallInfo extends State<EditCallInfo>
    with AutomaticKeepAliveClientMixin<EditCallInfo> {
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

  TextEditingController receivedController = TextEditingController(
      text: DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now()));
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
    callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    // print("widget.call_information.assign_id");
    // print(widget.call_information.assign_id);
    if (widget.call_information != null) {
      print("INISDE WIDGET INFO");
      receivedController.text = widget.call_information.call_received;
      cardNoValue = widget.call_information.callcard_no;
      callInfoBloc.cardNoController.sink
          .add(widget.call_information.callcard_no);
      // cardNoController.text = widget.call_information.callcard_no;
      contactNoController.text = widget.call_information.caller_contactno;
      eventCodeController.text = widget.call_information.event_code;
      incidentController.text = widget.call_information.incident_desc;
      locationController.text = widget.call_information.incidentLocation;
      landmarkController.text = widget.call_information.landmark;

      _priority = widget.call_information.priority;
      _distance = widget.call_information.distance_to_scene;
      _location = widget.call_information.location_type;
    }
    // else {
    //   print("NEW CALLCARD");
    //   receivedController.text = DateTime.now().toIso8601String();
    // }

    callInfoBloc.cardNoController.stream.listen((value) {
      cardNoValue = value;
      print('Value from controller: $value');
    });

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

  Widget _buildBloc(BuildContext context, initialValue) {
    // final callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    var eventCodeFormater = MaskTextInputFormatter(
        mask: "##/##/##/##", filter: {"#": RegExp(r'[a-zA-Z0-9]')});
    var contactNoFormater = MaskTextInputFormatter(
        mask: "###-########", filter: {"#": RegExp(r'[a-zA-Z0-9]')});

    // return BlocConsumer<CallInfoBloc, CallInfoState>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       if (state is CallInfoLoaded) {
    //         final currentState = state.call_information;

    //         print("UI:CALLINFOLOADED");
    //         cardNoController.text = setField(currentState.callcard_no);
    //         contactNoController.text = setField(currentState.caller_contactno);
    //         receivedController.text = setField(currentState.call_received);
    //         eventCodeController.text = setField(currentState.event_code);
    //         incidentController.text = setField(currentState.incident_desc);
    //         locationController.text = setField(currentState.incident_location);
    //         landmarkController.text = setField(currentState.landmark);

    //         _priority = setField(currentState.priority);
    //         _location = setField(currentState.location_type);
    //         _distance = setField(currentState.distance_to_scene);
    //       }
    // String initialValue;

    return Center(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Center(
                      child: HeaderSection("Edit Call Information"),
                    ),
                    IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        // {
                        // if (_formKey.currentState.validate()) {
                        // print("widget.call_information.assign_id");
                        // print(widget.call_information.assign_id);
                        callInfoBloc.add(SaveCallInfo(
                            callInformation: new CallInformation(
                          callcardNo: cardNoValue,
                          callReceived: receivedController.text,
                          callerContactno: contactNoController.text,
                          eventCode: eventCodeController.text,
                          priority: _priority,
                          incidentDesc: incidentController.text,
                          incidentLocation: locationController.text,
                          landmark: landmarkController.text,
                          locationType: _location,
                          distanceToScene: _distance,
                          assignId: widget.call_information.assign_id,
                          plateNo: widget.call_information.plate_no,
                        )));

                        // final snackBar = SnackBar(
                        //   content: Text("Call information has been saved!"),
                        // );
                        // Scaffold.of(context).showSnackBar(snackBar);

                        //   Navigator.pop(context);
                        // }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                // // TextEditLabel(
                // //     labelText: "Call Card No",
                // //     controller: cardNoController),

                CardNoTextInput(
                  labelText: "Call Card No",
                  controller: callInfoBloc.cardNoController,
                  initialData: cardNoValue,
                  // controller: cardNoController,
                  // stream: infoBloc.callcarNoStream,
                  // updateText: infoBloc.setCallcardNo,
                ),
                _dateReceived("Date Received", receivedController),
                TextInput(
                  labelText: "Caller Contact No",
                  controller: contactNoController,
                  maskFormater: contactNoFormater,
                  hintText: "ex: 012-3456789",
                  //     inputType:
                  //         TextInputType.numberWithOptions(signed: true),
                  //     hintText: "0139446197",
                ),
                TextInput(
                  labelText: "Event Code",
                  controller: eventCodeController,
                  // hintText: "37/XC/02/XW",
                  // maskFormater: eventCodeFormater,
                ),
                DropDownList(
                    "Priority", LIST_PRIORITY, InputOption.priority, _priority),
                TextInput(
                    labelText: "Incident Description",
                    controller: incidentController),
                TextInput(
                    labelText: "Incident Location",
                    controller: locationController),
                TextInput(
                    labelText: "Landmark", controller: landmarkController),
                DropDownList("Location type", LIST_LOCTYPE,
                    InputOption.location, _location),
                DropDownList("Distance to scene", LIST_DISTANCES,
                    InputOption.distance, _distance)
              ],
            ),
          )),
    );
    // });
  }

  convertDateToStandard(var datetime) {
    //dd/MM/yyyy HH:mm:ss to yyyy-MM-dd HH:mm:ss

    print("CONVERT DATETIME");
    print(datetime);
    var split = datetime.split("/");
    var dd = split[0];
    var MM = split[1];
    var yyyy = split[2].substring(0, 4);

    var time = datetime.substring(11);

    print(time);
    return "$yyyy-$MM-$dd $time:00";
  }

  @override
  Widget build(BuildContext context) {
    final callInfoBloc = BlocProvider.of<CallInfoBloc>(context);

    print("build call info run again");

    void callback(String item, int index) {}

    return Scaffold(
      backgroundColor: Colors.grey,
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: _buildBloc(context, initialValue),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 100,
      //   onPressed: () {
      //   },
      //   child: Icon(Icons.save),
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

class CardNoTextInput extends StatelessWidget {
  final labelText;
  final controller;
  final inputType;
  final maskFormater;
  final hintText;
  final initialData;
  final validator;

  CardNoTextInput(
      {this.labelText,
      this.controller,
      this.maskFormater,
      this.inputType,
      this.hintText,
      this.initialData,
      this.validator});

  TextEditingController myController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
                autovalidate: true,
                textCapitalization: TextCapitalization.characters,
                initialValue: initialData,
                validator: (value) {
                  if (value.length > 20) {
                    return "Call Card No cannot be more than 20 characters";
                  }

                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                inputFormatters: maskFormater != null ? [maskFormater] : [],
                onChanged: (value) {
                  controller.sink.add(value);
                },

                // onEditingComplete: (){

                // },
                // keyboardType: inputType,
                // controller: myController,
                decoration: InputDecoration(
                    // hintText: hintText,
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
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
                controller: controller,
                decoration: InputDecoration(
                    hintText: hintText,
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }
}
