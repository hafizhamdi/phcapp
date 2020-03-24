import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/custom/input.dart';
import 'package:phcapp/custom/label.dart';

// Flutter code sample for SlideTransition

// The following code implements the [SlideTransition] as seen in the video
// above:

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

class CallInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ListView(padding: const EdgeInsets.only(bottom: 10),
            // top: 20, left: 20, right: 20, bottom: 20),
            children: <Widget>[
              HeaderSection("Call Information"),
              // MyStatefulWidget(),
              Label("Call Card No.", "Date&Time Received"),
              Input("19999282828", "22/03/2020 10:10:22"),
              Label("Caller Contact No.", "Event Code"),
              Input("+6013-2939302", "A2/33/42/53"),
              Label("Priority", ""),
              Input("Urgent", ""),
              Label("Incident Location", ""),
              Input("Bawah jambatan depan RHB KL", ""),
              Label("Landmark", ""),
              Input("Petron sebelah kiri", ""),
              Label("Location Type", ""),
              Input("Street/Highway", ""),
              Label("Distance to scene", ""),
              Input("< 5km", ""),
            ]),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('EDIT'),
          icon: Icon(Icons.edit),
          backgroundColor: Colors.purple,
        ));
  }
}
