import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final callcardNo;
  final plateNo;
  final address;
  final receivedCall;
  final personCount;
  final status;
  final Function onPressed;

  TransactionCard(
      {this.callcardNo,
      this.plateNo,
      this.address,
      this.receivedCall,
      this.onPressed,
      this.personCount,
      this.status});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.trending_up,
                size: 40,
                color: Colors.white,
              ),
              // color: Colors.indigo,
              decoration:
                  BoxDecoration(color: Colors.indigo, shape: BoxShape.circle),
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
                              callcardNo,
                              style: TextStyle(
                                  // fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            DateFormat("dd/MM/yyyy, h:mm a").format(
                              DateTime.parse(receivedCall),
                            ),
                          )
                        ]),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          personCount != null ? personCount.toString() : "0",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      Text(
                        status == 1 ? "Success" : "Failed",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                            color: status == 1 ? Colors.green : Colors.red),
                      )
                    ]),

                    Row(children: [
                      Icon(
                        Icons.directions_car,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          child: Text(
                        plateNo != null ? plateNo : '',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: "Poppins",
                        ),
                      )),
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
