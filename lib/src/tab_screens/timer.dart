import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Function DateTime _onDateTimeChangedHandler() {
//   var now = new DateTime.now();
//   return now;
// };

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 200,
          child: Card(
            child: ListTile(
              title: Text("Dispatch Time"),
              subtitle: CupertinoDatePicker(
                initialDateTime: new DateTime.now(),
                onDateTimeChanged: (dateTime) {
                  print(dateTime);
                  setState(() {
                    _dateTime = dateTime;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
