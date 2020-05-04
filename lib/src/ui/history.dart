import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/blocs/history_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
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
          child: Text("CLEAR ALL HISTORY"),
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
        appBar: AppBar(
          title: Text("History"),
          actions: <Widget>[topOtherMenu(context)],
        ),
        body: BlocConsumer<HistoryBloc, HistoryState>(
          listener: (context, state) {
            if (state is CallcardToPublishEmpty) {
              historyBloc.add(LoadHistory());
            }
          },
          builder: (context, state) {
            print(state);
            print("historystate");
            if (state is HistoryLoaded) {
              return ListView.builder(
                // separatorBuilder: (context, index) => Divider(
                //   color: Colors.grey,
                // ),
                itemCount: state.listHistory.length,
                itemBuilder: (context, index) {
                  final data = state.listHistory[index];
                  return
                      // Container();
                      //  Container(
                      //     padding: EdgeInsets.all(20),
                      //     child:

                      ListTile(
                          title: Text(data
                              .historyCallcard.call_information.callcard_no),
                          subtitle: data.statusSend == 1
                              ? Text("Sending successful at " + data.timestamp)
                              : Text(
                                  "Sending unsuccessful at " + data.timestamp),
                          trailing: data.statusSend == 1
                              ? null
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CallcardTabs(
                                                        callcard_no: data
                                                            .historyCallcard
                                                            .call_information
                                                            .callcard_no,
                                                        call_information: data
                                                            .historyCallcard
                                                            .call_information,
                                                        response_team: data
                                                            .historyCallcard
                                                            .response_team,
                                                        response_time: data
                                                            .historyCallcard
                                                            .response_time,
                                                        patients: data
                                                            .historyCallcard
                                                            .patients,

                                                        // phcDao: widget.phcDao,
                                                      )));
                                        }),
                                    FlatButton(
                                      child: Text("RESEND"),
                                      color: Colors.green,
                                      onPressed: () {
                                        print("RESEND============");
                                        tabBloc.add(RepublishCallcard(
                                            callInformation: data
                                                .historyCallcard
                                                .call_information,
                                            responseTeam: data
                                                .historyCallcard.response_team,
                                            responseTime: data
                                                .historyCallcard.response_time,
                                            patients: List<Patient>(),
                                            sceneAssessment:
                                                new SceneAssessment()));

                                        // setState(() {
                                        //   print("Setstate is pressed");
                                        // });
                                        // historyBloc.add(LoadHistory());
                                      },
                                    )
                                  ],
                                ));
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
        ));
  }
}
