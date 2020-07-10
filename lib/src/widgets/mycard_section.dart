import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MycardSection extends StatelessWidget {
  final IconData icon;
  final title;
  final nextRoute;
  final timestamp;
  final disasterTriage;
  MycardSection(
      {this.icon,
      this.title,
      this.nextRoute,
      this.timestamp,
      this.disasterTriage});

  generateTime(time) {
    if (time == null) return "No data";

    return "Last updated " + DateFormat("h:mm aa").format(time);
  }

  @override
  Widget build(BuildContext context) {
    // final interBloc = BlocProvider.of<InterBloc>(context);
    // return Card(
    //   elevation: 3.0,
    //   margin: EdgeInsets.all(10),
    //   child:

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(left: 8, top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey, width: 0.5)),

      //  return   Container(
      // color: Colors.grey[200],
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        leading: Icon(
          icon,
          // size: 30,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.access_time,
                          color: Colors.purple,
                          // size: 18,
                        )),
                    timestamp != null
                        ? Text(
                            generateTime(timestamp),
                          )
                        : Text(
                            "No data",
                            // style: TextStyle(fontSize: 16),
                          ),
                  ]),
                ),
              ],
            ),
            padding: EdgeInsets.only(right: 20)),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => nextRoute),
          );
        },
      ),
      // ),
    );
  }
}
