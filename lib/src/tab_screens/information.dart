import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/input.dart';
import 'package:phcapp/custom/label.dart';

// Flutter code sample for SlideTransition

// The following code implements the [SlideTransition] as seen in the video
// above:

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

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.blue),
          alignment: Alignment.center,
          height: 50,
          padding: EdgeInsets.all(8.0),
          child: Text("Call Information",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w700,
              ))),
    );
  }
}

class CallInfo extends StatefulWidget {
  _CallInfoState createState() => _CallInfoState();
}

class _CallInfoState extends State<CallInfo> {
  String _locationTypeSelected = "Select option";
  String _distancesSelected = "Select option";
  // String _currentItemSelected;

  // void _onDropDownChanged(String newValueSelected) {
  //   setState(() {
  //     this._currentItemSelected = newValueSelected;
  //   });

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

  Widget _dateReceived(labelText, context) {
    // Text(),
    var txt = TextEditingController();

    txt.text = DateFormat("dd/MM/yyyy HH:mm:ss").format(new DateTime.now());

    return Container(
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
                controller: txt,
                decoration: InputDecoration(
                    labelText: labelText,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      borderSide: new BorderSide(),
                    )))));
  }

  Widget _textInput(labelText, context) {
    return Container(
        // width: 500,
        width: 500,
        child: Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
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
        child: Center(
            child: Card(
          margin: EdgeInsets.all(10.0),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              HeaderSection("Call Information"),
              _textInput("Call Card No", context),
              _dateReceived("Date Received", context),
              _textInput("Caller Contact No", context),
              _textInput("Event Code", context),
              _textInput("Priority", context),
              _textInput("Incident Location", context),
              _textInput("Landmark", context),
              _dropDownList("Location Type", LIST_LOCTYPE, locCallback,
                  _locationTypeSelected),
              _dropDownList("Distance to Scene", LIST_DISTANCES, distCallback,
                  _distancesSelected),
            ],
          ),
        )),
      ),
      //  ListView(
      // padding: EdgeInsets.all(10.0),
      // child: Container(
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         begin: Alignment.topRight,
      //         end: Alignment.bottomLeft,
      //         colors: [Colors.blue, Colors.green[200]])),
      // child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      // children: <Widget>[
      // HeaderSection("Call Information"),
      // _textInput("Call Card No"),
      // _textInput("Date Received"),
      // _textInput("Caller Contact No"),
      // _textInput("Event Code"),
      // _textInput("Priority"),
      // _textInput("Incident Location"),
      // _textInput("Landmark"),
      // _dropDownList("Location Type", LIST_LOCTYPE, locCallback,
      //     _locationTypeSelected),
      // _dropDownList("Distance to Scene", LIST_DISTANCES, distCallback,
      //     _distancesSelected),

      //  _textInput("Location Type"),

      // _textInput("Incident Location"),

      // MyStatefulWidget(),
      // Label("Call Card No.", "Date&Time Received"),
      // Input("19999282828", "22/03/2020 10:10:22"),
      // Label("Caller Contact No.", "Event Code"),
      // Input("+6013-2939302", "A2/33/42/53"),
      // Label("Priority", ""),
      // Input("Urgent", ""),
      // Label("Incident Location", ""),
      // Input("Bawah jambatan depan RHB KL", ""),
      // Label("Landmark", ""),
      // Input("Petron sebelah kiri", ""),
      // Label("Location Type", ""),
      // Input("Street/Highway", ""),
      // Label("Distance to scene", ""),
      // Input("< 5km", ""),
      // ]),
      // )
      // ),
      // )
      // ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   label: Text('EDIT'),
      //   icon: Icon(Icons.edit),
      //   // backgroundColor: Colors.purple,
      // )
    );
  }
}
