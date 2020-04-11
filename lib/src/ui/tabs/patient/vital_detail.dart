import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class VitalDetail extends StatefulWidget {
  VitalDetail({Key key}) : super(key: key);

  @override
  _VitalDetailState createState() => _VitalDetailState();
}

class _VitalDetailState extends State<VitalDetail> {
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
          //  textTheme: themeProvider.getThemeData,
          title: Text(
            'Vital signs',
          ),
          backgroundColor: Colors.purple),
      body: SingleChildScrollView(
          child: Center(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    children: <Widget>[
                      _buildItem(context, "BP Systolic"),
                      _buildItem(context, "BP Diastolic"),
                      _buildItem(context, "MAP"),
                      _buildItem(context, "PR"),
                      _buildItem(context, "Pulse Pressure"),
                      _buildItem(context, "Pulse Volume"),
                      _buildItem(context, "CRT"),
                      _buildItem(context, "Shock Index"),
                      _buildItem(context, "RR"),
                      _buildItem(context, "Sp02"),
                      // _buildItcontext,em("temp"),
                      _buildItem(context, "EVM"),
                      _buildItem(context, "Pain Score"),
                      _buildItem(context, "Blood Glucose"),
                      _buildItemPupil("Left Pupil"),
                      _buildItemPupil("Right Pupil"),
                      _buildItemGCS("GCS"),
                    ],
                  )))),
    );
  }
}

Widget _buildItem(context, title) {
  var doneButton = CupertinoButton(
    child: Text("Done"),
    onPressed: () {
      // setState(() {
      //   _dateTime = new DateFormat("dd/MM/yyyy HH:mm:ss")
      //       .format(_cupertinoTime)
      //       .toString();
      // });
      Navigator.of(context).pop();
    },
  );
  return Card(
      // color: Colors.white10,
      elevation: 2.4,
      child: Container(
          padding: EdgeInsets.only(left: 8, top: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          width: 160,
          height: 100,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      // style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "141.2",
                    style: TextStyle(
                      fontSize: 40,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.grey,
                      iconSize: 25,
                      onPressed: () {
                        final action = SizedBox(
                            height: 200,
                            // child:
                            // Column(children: <Widget>[
                            // SizedBox(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      child: CupertinoPicker(
                                          itemExtent: 50,
                                          onSelectedItemChanged: (int index) {
                                            print(index);
                                          },
                                          children: List<Widget>.generate(
                                              200,
                                              (int index) =>
                                                  Text(index.toString())))),
                                  Expanded(
                                      child: CupertinoPicker(
                                          itemExtent: 50,
                                          onSelectedItemChanged: (int index) {
                                            print(index);
                                          },
                                          children: List<Widget>.generate(
                                              10,
                                              (int index) =>
                                                  Text(index.toString()))))
                                  //   ],
                                  // )
                                  // )

                                  // Column(
                                  //     // crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: <Widget>[
                                  //       Container(
                                  //           alignment: Alignment.centerRight,
                                  //           decoration: BoxDecoration(
                                  //               color: const Color.fromRGBO(
                                  //                   249, 249, 247, 1.0),
                                  //               border: Border(
                                  //                   bottom: const BorderSide(
                                  //                       width: 0.5,
                                  //                       color: Colors.black38))),
                                  //           child: doneButton
                                  //           // ],
                                  //           // )
                                  //           ),
                                  // child: Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   // mainAxisSize: MainAxisSize.min,
                                  //   children: <Widget>[
                                  //     Text("HEllo"),
                                  //     Text("HEllo")
                                  //   ],
                                  // )
                                  //   ],
                                  // )
                                  // Expanded(
                                  //     flex: 2,
                                  //     //     // child: CupertinoDatePicker(

                                  //     child:

                                  // CupertinoPicker(
                                  //     itemExtent: 50,
                                  //     onSelectedItemChanged: (int index) {
                                  //       print(index);
                                  //     },
                                  //     children: List<Widget>.generate(
                                  //         50,
                                  //         (int index) =>
                                  //             Text(index.toString()))
                                  // ))
                                ]));
                        showCupertinoModalPopup(
                            context: context, builder: (context) => action);

                        // }))]))
                        // mode: CupertinoDatePickerMode.dateAndTime,
                        // initialDateTime: DateTime.now(),
                        // onDateTimeChanged: (dateTime) {
                        // setState(() {
                        //   switch (labelText) {
                        //     case "Dispatch Time":
                        //       _dispatchTime = dateTime;
                        //       break;
                        //     case "Enroute":
                        //       _enrouteTime = dateTime;
                        //       break;
                        //     case "At Scene":
                        //       _atSceneTime = dateTime;
                        //       break;
                        //     case "At Patient":
                        //       _atPatientTime = dateTime;
                        //       break;
                        //     case "Transporting":
                        //       _transportTime = dateTime;
                        //       break;
                        //     case "At Hospital":
                        //       _atHospitalTime = dateTime;
                        //       break;
                        //     case "Reroute":
                        //       _rerouteTime = dateTime;
                        //       break;
                        //     default:
                        //       break;
                        //   }
                      })
                ])
          ])
          //       },
          )); //     ))
  //   ],
  // ));

  //                       },
  //                 )
  //               ])
  //         ],
  //       )),
  // );
}

Widget _buildItemPupil(title) {
  return Card(
    // color: Colors.white10,
    elevation: 2.4,
    child: Container(
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: 160,
        height: 200,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.left,
                  // style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "8",
                    style: TextStyle(
                      fontSize: 40,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Response to light",
                      textAlign: TextAlign.left,
                      // style: TextStyle(color: Colors.white),
                    ),
                  ],
                )),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sluggish",
                    style: TextStyle(
                      fontSize: 25,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ])
          ],
        )),
  );
}

Widget _buildItemGCS(title) {
  return Card(
    // color: Colors.white10,
    elevation: 2.4,
    child: Container(
        padding: EdgeInsets.only(left: 8, top: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        width: 160,
        height: 230,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.left,
                  // style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "E",
                    textAlign: TextAlign.left,
                    // style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "4",
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "V",
                    textAlign: TextAlign.left,
                    // style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "4",
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "M",
                    textAlign: TextAlign.left,
                    // style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "5",
                    style: TextStyle(
                      fontSize: 30,
                      // color: Colors.purple[200]
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.grey,
                    iconSize: 25,
                    onPressed: () {},
                  )
                ]),
            Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total",
                    textAlign: TextAlign.left,
                    // style: TextStyle(color: Colors.white),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "13",
                        style: TextStyle(
                          fontSize: 30,
                          // color: Colors.purple[200]
                        ),
                      )),
                ])
          ],
        )),
  );
}
