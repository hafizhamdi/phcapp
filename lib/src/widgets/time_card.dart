import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final labelText;
  final time;
  final date;
  final Function onPressed;

  TimeCard({this.labelText, this.time, this.date, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        // right: 10,
      ),
      // margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(labelText,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Poppins",
                  fontSize: 18,
                  // fontWeight: FontWeight.w400
                )),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(
                      // fontFamily: "Poppins",
                      fontSize: 45,
                      fontWeight: FontWeight.w900),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.pink,

                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      // borderRadius: BorderRadius.circular(20),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  onTap: onPressed
                  // ),
                  // ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    splashColor: Colors.pink,

                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        // borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.date_range,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2018),
                        lastDate: DateTime(2030),
                        builder: (BuildContext context, Widget child) {
                          return Theme(
                            data: ThemeData.dark(),
                            child: child,
                          );
                        },
                      );
                    },
                    // ),
                    // ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
