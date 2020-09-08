import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/blocs/history_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/widgets/transaction_card.dart';
import 'package:provider/provider.dart';

import 'callcard_tabs.dart';

enum WhatTodo { clearAllHistory }

class History extends StatefulWidget {
  _History createState() => _History();
}

class _History extends State<History> {
  @override
  void didChangeDependencies() {
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    historyBloc.add(LoadHistory());

    super.didChangeDependencies();
  }
  // @override
  // void initState() {
  //   super.initState();
  // }

  topOtherMenu(BuildContext context) {
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    // Staff user = loginBloc.getAuthorizedUser;
    return PopupMenuButton<WhatTodo>(
      // child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //   Padding(padding: EdgeInsets.only(right: 10), child: Text(user.userid)),
      //   Container(
      //       // alignment: Alignment.centerLeft,
      //       width: 30,
      //       height: 30,
      //       decoration: new BoxDecoration(
      //         color: Colors.orange,
      //         shape: BoxShape.circle,
      //       ),
      //       child: Icon(Icons.person))
      // ]),
      onSelected: (WhatTodo result) {
        if (result == WhatTodo.clearAllHistory) {
          historyBloc.add(RemoveAllHistory());
          historyBloc.add(LoadHistory());

          setState(() {
            print("RIght you press me CLEAR ARLL");
          });
          // Navigator.push(

          //     context, MaterialPageRoute(builder: (context) => History()));
        }
        // else if (result == WhatTodo.newCallcard) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CallcardTabs(
        //               callcard_no: "",
        //               call_information: new CallInformation(),
        //               response_time: new ResponseTime(),
        //               response_team: new ResponseTeam(),
        //               patients: List(),
        //             )));
        // }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhatTodo>>[
        const PopupMenuItem<WhatTodo>(
          value: WhatTodo.clearAllHistory,
          child: ListTile(
            title: Text(
              "CLEAR ALL HISTORY",
              style: TextStyle(fontFamily: "Poppins"),
            ),
            leading: Icon(Icons.delete),
          ),
        ),
        // const PopupMenuItem<WhatTodo>(
        //   value: WhatTodo.history,
        //   child: Text("HISTORY"),
        // )
      ],
    );
    // ]);
  }

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<CallCardTabBloc>(context);
    final historyBloc = BlocProvider.of<HistoryBloc>(context);
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          "History",
          style: TextStyle(fontFamily: "Poppins", fontSize: 24),
        ),
        actions: <Widget>[topOtherMenu(context)],
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          constraints: BoxConstraints(maxWidth: 700),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // SizedBox(
            //   height: 20,
            // ),
            Text(
              "Last Transaction",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.w900),
            ),
            // Container(
            //   // padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: <Widget>[
            //       Expanded(
            //         child: Container(
            //           color: Colors.black54,
            //           padding: EdgeInsets.all(10),
            //           child: Text(
            //             "Call Card No",
            //             style: TextStyle(fontSize: 18, color: Colors.white),
            //           ),
            //         ),
            //       ),
            //       // Expanded(
            //       // child:
            //       Container(
            //         width: 200,
            //         color: Colors.black87,
            //         padding: EdgeInsets.all(10),
            //         child: Text(
            //           "Action",
            //           style: TextStyle(fontSize: 18, color: Colors.white),
            //         ),
            //       ),
            //       // ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocConsumer<HistoryBloc, HistoryState>(
                listener: (context, state) {
                  if (state is CallcardToPublishSuccess) {
                    historyBloc.add(LoadHistory());
                  }
                },
                builder: (context, state) {
                  print(state);
                  print("historystate");
                  if (state is HistoryLoaded) {
                    return ListView.builder(
                      // separatorBuilder: (context, index) => Divider(),
                      // color: Colors.grey,
                      // ),
                      itemCount: state.listHistory.length,
                      itemBuilder: (context, index) {
                        final data = state.listHistory[index];
                        return TransactionCard(
                          callcardNo:
                              data.historyCallcard.callInformation.callcard_no,
                          receivedCall: data.timestamp,
                          personCount: data.historyCallcard.patients.length,
                          plateNo:
                              data.historyCallcard.responseTeam.vehicleRegno,
                          status: data.statusSend,
                          onPressed: data.statusSend == 0
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CallcardTabs(
                                                callcard_no: data
                                                    .historyCallcard
                                                    .callInformation
                                                    .callcard_no,
                                                call_information: data
                                                    .historyCallcard
                                                    .callInformation,
                                                response_team: ResponseTeam(
                                                    staffs: data.historyCallcard
                                                        .responseTeam.staffs,
                                                    vehicleRegno: data
                                                        .historyCallcard
                                                        .callInformation
                                                        .plate_no,
                                                    serviceResponse: data
                                                        .historyCallcard
                                                        .responseTeam
                                                        .serviceResponse),
                                                response_time: data
                                                    .historyCallcard
                                                    .responseTime,
                                                patients: data
                                                    .historyCallcard.patients,
                                                scene_assessment: data
                                                    .historyCallcard
                                                    .sceneAssessment,
                                                // phcDao: widget.phcDao,
                                              )));
                                }
                              : () {},
                        );
                        // Container();
                        //  Container(
                        //     padding: EdgeInsets.all(20),
                        //     child:

                        // ListTile(
                        //     title: Text(data.historyCallcard.callInformation
                        //         .callcard_no),
                        //     subtitle: data.statusSend == 1
                        //         ? RichText(
                        //             text: TextSpan(
                        //               style: new TextStyle(
                        //                 // fontSize: 14.0,
                        //                 color: Colors.black,
                        //               ),
                        //               children: [
                        //                 TextSpan(
                        //                     text: "Sent ",
                        //                     style: TextStyle(
                        //                         color: Colors.green,
                        //                         fontWeight:
                        //                             FontWeight.bold)),
                        //                 TextSpan(
                        //                     text: "at " + data.timestamp)
                        //               ],
                        //             ),
                        //           )
                        //         : RichText(
                        //             text: TextSpan(
                        //               style: new TextStyle(
                        //                 // fontSize: 14.0,
                        //                 color: Colors.black,
                        //               ),
                        //               children: [
                        //                 TextSpan(
                        //                     text: "Failed sending ",
                        //                     style: TextStyle(
                        //                         color: Colors.red,
                        //                         fontWeight:
                        //                             FontWeight.bold)),
                        //                 TextSpan(
                        //                     text: "at " + data.timestamp)
                        //               ],
                        //             ),
                        //           ),
                        //     trailing: data.statusSend == 1
                        //         ? Text(
                        //             "Success",
                        //             style: TextStyle(color: Colors.green),
                        //           )
                        //         : Row(
                        //             mainAxisSize: MainAxisSize.min,
                        //             children: <Widget>[
                        //               IconButton(
                        //                   icon: Icon(
                        //                     Icons.edit,
                        //                     color: Colors.blue,
                        //                   ),
                        //                   onPressed: () {
                        //                     print("EDIT=HISTORY");
                        //                     print(jsonEncode(data));
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               CallcardTabs(
                        //                 callcard_no: data
                        //                     .historyCallcard
                        //                     .callInformation
                        //                     .callcard_no,
                        //                 call_information: data
                        //                     .historyCallcard
                        //                     .callInformation,
                        //                 response_team: ResponseTeam(
                        //                     staffs: data
                        //                         .historyCallcard
                        //                         .responseTeam
                        //                         .staffs,
                        //                     vehicleRegno: data
                        //                         .historyCallcard
                        //                         .callInformation
                        //                         .plate_no,
                        //                     serviceResponse: data
                        //                         .historyCallcard
                        //                         .responseTeam
                        //                         .serviceResponse),
                        //                 response_time: data
                        //                     .historyCallcard
                        //                     .responseTime,
                        //                 patients: data
                        //                     .historyCallcard
                        //                     .patients,
                        //                 scene_assessment: data
                        //                     .historyCallcard
                        //                     .sceneAssessment,
                        //                 // phcDao: widget.phcDao,
                        //               )));
                        // }),
                        // FlatButton(
                        //   child: Text("RESEND"),
                        //   color: Colors.green,
                        //   onPressed: () {
                        //     print("RESEND============");
                        //     print(data.historyCallcard.toJson());
                        //     tabBloc.add(RepublishCallcard(
                        //       callInformation: data
                        //           .historyCallcard.callInformation,
                        //       responseTeam:
                        //           data.historyCallcard.responseTeam,
                        //       responseTime:
                        //           data.historyCallcard.responseTime,
                        //       patients:
                        //           data.historyCallcard.patients,
                        //       // sceneAssessment: data
                        //       //     .historyCallcard
                        //       //     .scene_assessment
                        //     ));

                        //     // setState(() {
                        //     //   print("Setstate is pressed");
                        //     // });
                        //     // historyBloc.add(LoadHistory());
                        //   },
                        // )
                        //   ],
                        // ));
                        // )
                        // );
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   // crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: <Widget>[
                        //     Text(state.listHistory[index].statusSend.toString())
                        //   ],
                        // ));
                      },
                    );
                  }
                  return Center(
                    child: Icon(Icons.pin_drop),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
