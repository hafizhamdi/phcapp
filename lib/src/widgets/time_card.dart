import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeCard extends StatelessWidget {
  final labelText;
  final datetime;
  final dateController;
  final timeController;
  // final date;
  final Function onTime;
  final Function onDate;

  TimeCard(
      {this.labelText,
      this.dateController,
      this.timeController,
      // this.time,
      this.datetime,
      this.onTime,
      this.onDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   top: 10,
      //   // right: 10,
      // ),
      // margin: EdgeInsets.all(10),
      // width: double.infinity,
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.all(10),
      //       child: Text(labelText,
      //           style: TextStyle(
      //             color: Colors.grey,
      //             fontFamily: "Poppins",
      //             fontSize: 18,
      //             // fontWeight: FontWeight.w400
      //           )),
      //     ),
      //     Container(
      //       padding: EdgeInsets.only(left: 10, right: 10),
      //       child: Row(
      //         mainAxisSize: MainAxisSize.min,
      //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         // crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           // TextField(
      //           //   decoration: InputDecoration(),

      //           //   controller: timeController,
      //           //   // datetime != null ? DateFormat("HH:mm").format(datetime) : "",
      //           //   style: TextStyle(
      //           //       // fontFamily: "Poppins",
      //           //       fontSize: 45,
      //           //       fontWeight: FontWeight.w900),
      //           // ),
      //           InkWell(
      //               borderRadius: BorderRadius.circular(20),
      //               splashColor: Colors.pink,
      //               child: Container(
      //                 padding: EdgeInsets.all(5),
      //                 decoration: BoxDecoration(
      //                   color: Colors.indigo,
      //                   // borderRadius: BorderRadius.circular(20),
      //                   shape: BoxShape.circle,
      //                 ),
      //                 child: Icon(
      //                   Icons.access_time,
      //                   color: Colors.white,
      //                   size: 30,
      //                 ),
      //               ),
      //               onTap: onTime
      //               // ),
      //               // ),
      //               )
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.only(left: 10, right: 10),
      //       child: Row(mainAxisSize: MainAxisSize.min,
      //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           // crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             // TextField(
      //             //   decoration: InputDecoration(),
      //             //   controller: dateController,
      //             //   // datetime != null
      //             //   //     ? DateFormat("dd-MM-yyyy").format(datetime)
      //             //   //     : "",
      //             //   style: TextStyle(
      //             //       color: Colors.grey[700],
      //             //       // fontFamily: "Poppins",
      //             //       fontSize: 18,
      //             //       fontWeight: FontWeight.w900),
      //             // ),
      //             InkWell(
      //                 borderRadius: BorderRadius.circular(20),
      //                 splashColor: Colors.pink,
      //                 child: Container(
      //                   padding: EdgeInsets.all(5),
      //                   decoration: BoxDecoration(
      //                     color: Colors.indigo,
      //                     // borderRadius: BorderRadius.circular(20),
      //                     shape: BoxShape.circle,
      //                   ),
      //                   child: Icon(
      //                     Icons.date_range,
      //                     color: Colors.white,
      //                     size: 30,
      //                   ),
      //                 ),
      //                 onTap: onDate
      //                 // ),
      //                 // ),
      //                 )
      //           ]),
      //     ),
      //   ],
      // ),
    );
  }
}
