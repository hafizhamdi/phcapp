import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'datetime_verbose.dart';

class CardList extends StatelessWidget {
  final callcardNo;
  final plateNo;
  final address;
  final receivedCall;
  final updatedDate;
  final Function onPressed;

  CardList(
      {this.callcardNo,
      this.plateNo,
      this.address,
      this.receivedCall,
      this.onPressed,
      this.updatedDate});

  @override
  Widget build(BuildContext context) {
    DateFormatter df = DateFormatter();
    DateTime dt = DateTime.parse(updatedDate);
    var updateTime =
        updatedDate != null ? df.getVerboseDateTimeRepresentation(dt) : '';

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          color: Provider.of<ThemeProvider>(context).isDarkTheme
              ? Colors.grey[900]
              : Colors.white,
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000).withOpacity(0.2),
              blurRadius: 10.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.call,
                size: 40,
                color: Colors.white,
              ),
              // color: Colors.indigo,
              decoration: BoxDecoration(
                  color: Provider.of<ThemeProvider>(context).isDarkTheme
                      ? Colors.purple
                      : Colors.indigo,
                  shape: BoxShape.circle),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              callcardNo != null ? callcardNo : '',
                              style: TextStyle(
                                  // fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            " $updateTime",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey),
                          )
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      Icon(
                        Icons.person_pin,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Text(
                        address != null ? address : "No location",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: "Poppins",
                        ),
                      )),
                    ]),

                    Row(children: [
                      Row(children: [
                        Icon(
                          Icons.directions_car,
                          color: Colors.purple,
                        ),
                        SizedBox(width: 10),
                        Container(
                            width: 100,
                            child: Text(
                              plateNo != null ? plateNo : '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: "Poppins",
                              ),
                            )),
                      ]),
                      Row(children: [
                        Icon(
                          Icons.call_received,
                          color: Colors.indigo,
                        ),
                        SizedBox(width: 10),
                        Container(
                            width: 100,
                            child: Text(
                              receivedCall != null
                                  ? DateFormat("d-MMM HH:mm").format(
                                      DateTime.parse(receivedCall),
                                    )
                                  : '',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: "Poppins",
                              ),
                            )),
                      ])
                    ]),
                    // Text("THE REST")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
