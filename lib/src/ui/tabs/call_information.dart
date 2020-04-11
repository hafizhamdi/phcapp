import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/models/info_model.dart';
import '../../blocs/info_bloc.dart';

const LIST_LOCTYPE = [
  "Select option",
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

const LIST_DISTANCES = ["Select option", "< 5km", "5-10km", "> 10km"];

class CallInfo extends StatefulWidget {
  final InfoModel call_information;

  CallInfo({this.call_information});

  _CallInfoState createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInfo> {
  String _locationTypeSelected = "Select option";
  String _distancesSelected = "Select option";
  // InfoModel call_information;
  // _CallInfoState(this.call_information);

  InfoBloc bloc = new InfoBloc();

  var _received_ctrl = TextEditingController();
  var _callcardNo_ctrl = TextEditingController();
  var _contactNo_ctrl = TextEditingController();
  var _eventCode_ctrl = TextEditingController();
  var _priority_ctrl = TextEditingController();
  var _incident_ctrl = TextEditingController();
  var _location_ctrl = TextEditingController();
  var _landmark_ctrl = TextEditingController();
  var _loctype_ctrl = TextEditingController();
  var _distScene_ctrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _received_ctrl.text = DateFormat("dd/MM/yyyy HH:mm:ss")
        .format(widget.call_information.call_received);
    _callcardNo_ctrl.text = widget.call_information.callcard_no;
    _contactNo_ctrl.text = widget.call_information.caller_contactno;
    _eventCode_ctrl.text = widget.call_information.event_code;
    _priority_ctrl.text = widget.call_information.priority;
    _incident_ctrl.text = widget.call_information.incident_desc;
    _location_ctrl.text = widget.call_information.incident_location;
    _landmark_ctrl.text = widget.call_information.landmark;
    _loctype_ctrl.text = widget.call_information.location_type;
    _distScene_ctrl.text = widget.call_information.distance_toscene;
    // txt.text =
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // bloc.dispose();
    _received_ctrl.dispose();
    _callcardNo_ctrl.dispose();
    _contactNo_ctrl.dispose();
    _eventCode_ctrl.dispose();
    _priority_ctrl.dispose();
    _incident_ctrl.dispose();
    _location_ctrl.dispose();
    _landmark_ctrl.dispose();
    _loctype_ctrl.dispose();
    _distScene_ctrl.dispose();
  }

  // txt.text = DateFormat("dd/MM/yyyy HH:mm:ss").format(new DateTime.now());

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
  // }

  Widget _dropDownList(
      labelText, List<String> list, Function callback, String selected) {
    String _currentItemSelected;
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
                  // _currentItemSelected = newValueSelected;

                  // _onDropDownChanged(newValueSelected);
                },
                value: selected,
                // onChanged: _onChangeDropdown,
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }

  Widget _dateReceived(labelText, controller) {
    // Text(),
    var txt = TextEditingController();

    txt.text = DateFormat("dd/MM/yyyy HH:mm:ss").format(new DateTime.now());

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

  Widget _textInput(labelText, _controller, _stream, _updateText) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
                onChanged: (String text) => _updateText(text),
                maxLines: null,
                controller: _controller,
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
    void callback(String item, int index) {}

    return Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
              child: Card(
            margin: EdgeInsets.all(10.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                HeaderSection("Call Information"),
                _textInput("Call Card No", _callcardNo_ctrl, bloc.callNoStream,
                    bloc.updateCallcardNo),
                _dateReceived("Date Received", _received_ctrl),
                // _textInput("Caller Contact No", _contactNo_ctrl,
                //     bloc.contactNoStream, bloc.updateContactNo),
                _textInput("Event Code", _eventCode_ctrl, bloc.eventCodeStream,
                    bloc.updateEventCode),
                _textInput("Priority", _priority_ctrl, bloc.priorityStream,
                    bloc.updatePriority),
                _textInput("Incident Description", _incident_ctrl,
                    bloc.incDescStream, bloc.updateIncidentDesc),
                _textInput("Incident Location", _location_ctrl,
                    bloc.incLocStream, bloc.updateIncidentLoc),
                _textInput("Landmark", _landmark_ctrl, bloc.landmarkStream,
                    bloc.updateLandmark),
                _dropDownList("Location Type", LIST_LOCTYPE, locCallback,
                    _locationTypeSelected),
                _dropDownList("Distance to Scene", LIST_DISTANCES, distCallback,
                    _distancesSelected),
              ],
            ),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("push data");
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => Patient()));
            // // Add your onPressed code here!
          },
          // label: Text('ADD PATIENT'),
          // icon: Icon(Icons.add),
          // backgroundColor: Colors.purple,
        ));
  }
}
