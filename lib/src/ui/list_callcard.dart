import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/blocs/setting_bloc.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/repositories/phc_dao_client.dart';
import 'package:phcapp/src/repositories/repositories.dart';
import 'package:phcapp/src/ui/history.dart';
import 'package:phcapp/src/widgets/card_list.dart';
import 'package:phcapp/src/widgets/stats_card.dart';
import 'package:phcapp/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'callcard_tabs.dart';

enum WhatTodo { logout, history, newCallcard }

class ListCallcards extends StatefulWidget {
  PhcDao phcDao;

  ListCallcards({this.phcDao});

  _ListCallcards createState() => _ListCallcards();
}

class _ListCallcards extends State<ListCallcards> {
  Completer<void> _refreshCompleter;
  PhcBloc phcBloc;
  LoginBloc loginBloc;
  AuthBloc authBloc;
  SettingBloc settingBloc;

  PhcRepository phcRepository;
  PhcDaoClient phcDaoClient;

  TextEditingController searchController = TextEditingController();
  String filter;
  // PhcDao phcDao;

  @override
  void didChangeDependencies() {
    phcBloc = BlocProvider.of<PhcBloc>(context);
    loginBloc = BlocProvider.of<LoginBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    settingBloc = BlocProvider.of<SettingBloc>(context);

    phcRepository = PhcRepository(
        phcApiClient: PhcApiClient(
            httpClient: http.Client(),
            environment: settingBloc.state.environment));

    phcDaoClient = new PhcDaoClient(phcDao: new PhcDao());

    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final historyBloc = Provider.of<HistoryBloc>(context);

    historyBloc.add(LoadHistory());

    final user = authBloc.getAuthorizedUser;

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          // textTheme: themeProvider.getThemeData.textTheme,
          leading: TopOtherMenu(),
          title: Text(
            "PH Care",
            style: TextStyle(fontFamily: "Poppins", fontSize: 24),
          ),
          actions: <Widget>[
            Padding(padding: EdgeInsets.only(right: 10), child: TopUserMenu()),
          ],
        ),
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(20),
            child:
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                // SizedBox(
                //   height: 20,
                // ),

                // Expanded(
                //   child:

                BlocProvider(
              create: (context) => PhcBloc(
                  phcRepository: phcRepository, phcDao: phcDaoClient.phcDao),
              child: BlocConsumer<PhcBloc, PhcState>(
                listener: (context, state) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                },
                builder: (context, state) {
                  phcBloc = BlocProvider.of<PhcBloc>(context);

                  if (state is PhcEmpty) {
                    phcBloc.add(FetchPhc());
                  } else if (state is PhcLoaded) {
                    final phc = state.phc;

                    return RefreshIndicator(
                        onRefresh: () {
                          BlocProvider.of<PhcBloc>(context).add(
                            RefreshPhc(),
                          );
                          return _refreshCompleter.future;
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Dashboard(
                                username: user.name,
                                lastUpdated: phc.lastUpdated,
                                totalCount: phc.callcards.length,
                                successCount: historyBloc.state.listHistory
                                    .where((f) => f.statusSend == 1)
                                    .toList()
                                    .length,
                                failedCount: historyBloc.state.listHistory
                                    .where((f) => f.statusSend == 0)
                                    .toList()
                                    .length,
                              ),

                              // SizedBox(
                              //   height: 20,
                              // ),

                              Container(
                                padding: EdgeInsets.symmetric(
                                    //     horizontal: 20,
                                    vertical: 20),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: 1.0),
                                  decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(left: 18, right: 10),
                                      child: Icon(
                                        Icons.search,
                                        size: 30,
                                      ),
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 14),
                                      child: IconButton(
                                        onPressed: () =>
                                            searchController.clear(),
                                        icon: Icon(
                                          Icons.clear,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: "Search Call Card No",
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  controller: searchController,
                                ),
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),

                              // Expanded(
                              //   child:
                              _buildList(phc),
                              // )
                            ])
                        //   Expanded(
                        // child: ListView.builder(
                        //   itemCount: 5,
                        //   itemBuilder: (ctx, idx) {
                        //     return Expanded(
                        //       child: Container(
                        //         width: 10,
                        //         height: 20,
                        //         color: Colors.red,
                        //       ),
                        //     );
                        // },
                        // ),
                        // ),
                        // ),
                        // ),
                        // ]),
                        // Container(
                        //   // constraints: BoxConstraints(maxWidth: 700),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: <Widget>[
                        //       // Expanded(child: _buildList(phc))
                        //     ],
                        //   ),
                        // ),
                        // ),
                        );
                  }
                  return Dashboard();
                  // return Center(
                  //   child: SizedBox(
                  //     width: 50,
                  //     height: 50,
                  //     child: CircularProgressIndicator(
                  //       // strokeWidth: .0,
                  //       backgroundColor: Provider.of<ThemeProvider>(context)
                  //           .getThemeData
                  //           .primaryColor,
                  //     ),
                  //   ),
                  // );
                },
              ),
              // ),
              // ),
              // ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to logout'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('NO'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('YES'),
              ),
            ],
          ),
        )) ??
        false;
  }

  Widget _buildList(phc) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      // separatorBuilder: (ctx, idx) => Divider(),
      itemCount: phc.callcards.length,
      itemBuilder: (BuildContext context, int index) {
        final callInfo = phc.callcards[index].callInformation;

        return (filter == null || filter == "")
            ? CardList(
                callcardNo: callInfo.callcard_no,
                receivedCall: callInfo.call_received,
                plateNo: callInfo.plate_no,
                address: callInfo.incident_location,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) {
                        final timeBloc = BlocProvider.of<TimeBloc>(context);
                        timeBloc.add(ResetTime());

                        final sceneBloc = BlocProvider.of<SceneBloc>(context);

                        print("OPEN CALLCARD SCENE ASSESMNT");
                        print(phc.callcards[index].sceneAssessment
                            .otherServicesAtScene);
                        sceneBloc.add(
                          LoadScene(
                              selectedPPE:
                                  phc.callcards[index].sceneAssessment.ppe,
                              selectedEnvironment: phc
                                  .callcards[index].sceneAssessment.environment,
                              selectedCaseType:
                                  phc.callcards[index].sceneAssessment.caseType,
                              selectedPatient:
                                  phc.callcards[index].sceneAssessment.patient,
                              selectedBackup:
                                  phc.callcards[index].sceneAssessment.backup,
                              selectedServices: phc.callcards[index]
                                  .sceneAssessment.otherServicesAtScene),
                        );

                        final patientBloc =
                            BlocProvider.of<PatientBloc>(context);
                        patientBloc.add(
                          LoadPatient(patients: phc.callcards[index].patients),
                        );

                        final teamBloc = BlocProvider.of<TeamBloc>(context);
                        teamBloc.add(LoadTeam(
                            selectedStaffs:
                                phc.callcards[index].responseTeam.staffs));

                        return CallcardTabs(
                          callcard_no: callInfo.callcard_no,
                          call_information:
                              phc.callcards[index].callInformation,
                          response_team: phc.callcards[index].responseTeam,
                          response_time: phc.callcards[index].responseTime,
                          patients: phc.callcards[index].patients,
                          scene_assessment:
                              phc.callcards[index].sceneAssessment,
                          // phcDao: widget.phcDao,
                        );
                      },
                    ),
                  );
                },
              )

            // ListTile(
            //     contentPadding:
            //         EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            //     title: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         Expanded(
            //           // child:
            //           // Hero(
            //           //   tag: callInfo.callcard_no,
            //           child: Text(
            //             callInfo.callcard_no,
            //             style: TextStyle(
            //                 fontFamily: "OpenSans",
            //                 letterSpacing: 1,
            //                 fontWeight: FontWeight.bold),
            //           ),
            //           // ),
            //         ),
            //       ],
            //     ),
            //     subtitle: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: <Widget>[
            //           Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(children: <Widget>[
            //                   Row(children: [
            //                     Icon(
            //                       Icons.person,
            //                       size: 16,
            //                       color: Colors.grey,
            //                     ),
            //                     SizedBox(
            //                       width: 8,
            //                     ),
            //                     Text(phc.callcards[index].patients.length
            //                             .toString() +
            //                         ' Patient')
            //                   ]),
            //                   SizedBox(
            //                     width: 40,
            //                   ),
            //                   Row(children: [
            //                     Icon(
            //                       Icons.group,
            //                       color: Colors.grey,
            //                       size: 16,
            //                     ),
            //                     SizedBox(
            //                       width: 8,
            //                     ),
            //                     Text(phc.callcards[index].responseTeam.staffs
            //                             .length
            //                             .toString() +
            //                         ' Team')
            //                   ])
            //                   // ),
            //                 ]),

            //                 // ),
            //                 SizedBox(
            //                   height: 5,
            //                 ),
            //                 Row(children: [
            //                   Icon(Icons.call_received,
            //                       color: Colors.grey, size: 16),
            //                   SizedBox(
            //                     width: 8,
            //                   ),
            //                   Text(
            //                     DateFormat("d MMM yyyy, h:mm aaa").format(
            //                         DateTime.parse(callInfo.call_received)),
            //                     style:
            //                         TextStyle(color: Colors.grey, fontSize: 14),
            //                   )
            //                 ])
            //               ]),
            //           Container(
            //               width: 120,
            //               alignment: Alignment.center,
            //               padding: EdgeInsets.all(5),
            //               decoration: new BoxDecoration(
            //                   // color: Colo,
            //                   border:
            //                       Border.all(width: 1.5, color: Colors.orange),
            //                   borderRadius:
            //                       new BorderRadius.all(Radius.circular(5.0))),
            //               child: Row(children: [
            //                 Icon(Icons.label_important, color: Colors.orange),
            //                 SizedBox(
            //                   width: 5,
            //                 ),
            //                 Expanded(
            //                     child: Text((callInfo.plate_no != null)
            //                         ? callInfo.plate_no
            //                         : ""))
            //               ]))
            //         ]),

            //     leading: Container(
            //       // alignment: Alignment.centerLeft,
            //       width: 60,
            //       height: 60,
            //       decoration: new BoxDecoration(
            //         color: Colors.grey,
            //         shape: BoxShape.circle,
            //       ),
            //       child: Icon(Icons.headset_mic, color: Colors.white),
            //     ),
            //     // trailing: Icon(Icons.arrow_forward_ios),
            //     onTap: () {

            // Navigator.pushNamed(context, "/callcarddetail");
            //   },
            // )
            : phc.callcards[index].callInformation.callcard_no
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase())
                ? CardList(
                    callcardNo: callInfo.callcard_no,
                    receivedCall: callInfo.call_received,
                    plateNo: callInfo.plate_no,
                    address: callInfo.incident_location,
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) {
                            final timeBloc = BlocProvider.of<TimeBloc>(context);
                            timeBloc.add(ResetTime());

                            final sceneBloc =
                                BlocProvider.of<SceneBloc>(context);

                            print("OPEN CALLCARD SCENE ASSESMNT");
                            print(phc.callcards[index].sceneAssessment
                                .otherServicesAtScene);
                            sceneBloc.add(
                              LoadScene(
                                  selectedPPE:
                                      phc.callcards[index].sceneAssessment.ppe,
                                  selectedEnvironment: phc.callcards[index]
                                      .sceneAssessment.environment,
                                  selectedCaseType: phc.callcards[index]
                                      .sceneAssessment.caseType,
                                  selectedPatient: phc
                                      .callcards[index].sceneAssessment.patient,
                                  selectedBackup: phc
                                      .callcards[index].sceneAssessment.backup,
                                  selectedServices: phc.callcards[index]
                                      .sceneAssessment.otherServicesAtScene),
                            );

                            final patientBloc =
                                BlocProvider.of<PatientBloc>(context);
                            patientBloc.add(
                              LoadPatient(
                                  patients: phc.callcards[index].patients),
                            );

                            final teamBloc = BlocProvider.of<TeamBloc>(context);
                            teamBloc.add(LoadTeam(
                                selectedStaffs:
                                    phc.callcards[index].responseTeam.staffs));

                            return CallcardTabs(
                              callcard_no: callInfo.callcard_no,
                              call_information:
                                  phc.callcards[index].callInformation,
                              response_team: phc.callcards[index].responseTeam,
                              response_time: phc.callcards[index].responseTime,
                              patients: phc.callcards[index].patients,
                              scene_assessment:
                                  phc.callcards[index].sceneAssessment,
                              // phcDao: widget.phcDao,
                            );
                          },
                        ),
                      );
                    },
                  )
                // ListTile(
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                //     title: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: <Widget>[
                //         Expanded(
                //           child: Hero(
                //             tag: callInfo.callcard_no,
                //             child: Text(
                //               callInfo.callcard_no,
                //               style: TextStyle(
                //                   fontFamily: "OpenSans",
                //                   letterSpacing: 1,
                //                   fontWeight: FontWeight.bold),
                //             ),
                //           ),
                //         ),
                //         // Text(
                //         //   DateFormat("d MMM yyyy, hh:mm aaa")
                //         //       .format(DateTime.parse(callInfo.call_received)),
                //         //   style: TextStyle(color: Colors.grey, fontSize: 14),
                //         // )
                //       ],
                //     ),
                //     subtitle: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: <Widget>[
                //           Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Row(children: <Widget>[
                //                   Row(children: [
                //                     Icon(
                //                       Icons.person,
                //                       size: 16,
                //                       color: Colors.grey,
                //                     ),
                //                     SizedBox(
                //                       width: 8,
                //                     ),
                //                     Text(phc.callcards[index].patients.length
                //                             .toString() +
                //                         ' Patient')
                //                   ]),
                //                   SizedBox(
                //                     width: 40,
                //                   ),
                //                   Row(children: [
                //                     Icon(
                //                       Icons.group,
                //                       color: Colors.grey,
                //                       size: 16,
                //                     ),
                //                     SizedBox(
                //                       width: 8,
                //                     ),
                //                     Text(phc.callcards[index].responseTeam
                //                             .staffs.length
                //                             .toString() +
                //                         ' Team')
                //                   ])
                //                   // ),
                //                 ]),

                //                 // ),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 Row(children: [
                //                   Icon(Icons.call_received,
                //                       color: Colors.grey, size: 16),
                //                   SizedBox(
                //                     width: 8,
                //                   ),
                //                   Text(
                //                     DateFormat("d MMM yyyy, h:mm aaa").format(
                //                         DateTime.parse(callInfo.call_received)),
                //                     style: TextStyle(
                //                         color: Colors.grey, fontSize: 14),
                //                   )
                //                 ])
                //               ]),
                //           Container(
                //               width: 120,
                //               alignment: Alignment.center,
                //               padding: EdgeInsets.all(5),
                //               decoration: new BoxDecoration(
                //                   // color: Colo,
                //                   border: Border.all(
                //                       width: 1.5, color: Colors.orange),
                //                   borderRadius: new BorderRadius.all(
                //                       Radius.circular(5.0))),
                //               child: Row(children: [
                //                 Icon(Icons.label_important,
                //                     color: Colors.orange),
                //                 SizedBox(
                //                   width: 5,
                //                 ),
                //                 Expanded(
                //                     child: Text((callInfo.plate_no != null)
                //                         ? callInfo.plate_no
                //                         : ""))
                //               ]))
                //         ]),
                //     leading: Container(
                //       // alignment: Alignment.centerLeft,
                //       width: 60,
                //       height: 60,
                //       decoration: new BoxDecoration(
                //         color: Colors.grey,
                //         shape: BoxShape.circle,
                //       ),
                //       child: Icon(Icons.headset, color: Colors.white),
                //     ),
                //     // trailing: Icon(Icons.arrow_forward_ios),
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         CupertinoPageRoute(
                //           builder: (context) {
                //             final timeBloc = BlocProvider.of<TimeBloc>(context);
                //             timeBloc.add(ResetTime());

                //             final sceneBloc =
                //                 BlocProvider.of<SceneBloc>(context);

                //             print("OPEN CALLCARD SCENE ASSESMNT");
                //             print(phc.callcards[index].sceneAssessment
                //                 .otherServicesAtScene);
                //             sceneBloc.add(
                //               LoadScene(
                //                   selectedPPE:
                //                       phc.callcards[index].sceneAssessment.ppe,
                //                   selectedEnvironment: phc.callcards[index]
                //                       .sceneAssessment.environment,
                //                   selectedCaseType: phc.callcards[index]
                //                       .sceneAssessment.caseType,
                //                   selectedPatient: phc
                //                       .callcards[index].sceneAssessment.patient,
                //                   selectedBackup: phc
                //                       .callcards[index].sceneAssessment.backup,
                //                   selectedServices: phc.callcards[index]
                //                       .sceneAssessment.otherServicesAtScene),
                //             );

                //             final patientBloc =
                //                 BlocProvider.of<PatientBloc>(context);
                //             patientBloc.add(
                //               LoadPatient(
                //                   patients: phc.callcards[index].patients),
                //             );

                //             final teamBloc = BlocProvider.of<TeamBloc>(context);
                //             teamBloc.add(LoadTeam(
                //                 selectedStaffs:
                //                     phc.callcards[index].responseTeam.staffs));

                //             return CallcardTabs(
                //               callcard_no: callInfo.callcard_no,
                //               call_information:
                //                   phc.callcards[index].callInformation,
                //               response_team: phc.callcards[index].responseTeam,
                //               response_time: phc.callcards[index].responseTime,
                //               patients: phc.callcards[index].patients,
                //               scene_assessment:
                //                   phc.callcards[index].sceneAssessment,
                //               // phcDao: widget.phcDao,
                //             );
                //           },
                //         ),
                //       );
                //       // Navigator.pushNamed(context, "/callcarddetail");
                //     },
                //   )
                : Container();
      },
    );
    // );
  }

  Widget TopUserMenu() {
    // Staff user = authBloc.getAuthorizedUser;
    // return PopupMenuButton<WhatTodo>(
    //   child:

    return FlatButton.icon(
      icon: Icon(
        Icons.exit_to_app,
        color: Colors.white,
      ),
      label: Text(
        "Log Out",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to logout?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('NO'),
              ),
              new FlatButton(
                onPressed: () {
                  loginBloc.add(LogoutButtonPressed());

                  // Navigator.of(context).pop(true);
                },
                child: new Text('YES'),
              ),
            ],
          ),
        );
      },
    );
    // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    // Padding(
    //     padding: EdgeInsets.only(right: 20),
    //     child: Text(
    //       "Welcome, " + user.userId,
    //       style: TextStyle(fontFamily: "Raleway"),
    //     )),
    // Container(
    //     // alignment: Alignment.centerLeft,
    //     width: 30,
    //     height: 30,
    //     decoration: new BoxDecoration(
    //       color: Colors.pinkAccent,
    //       shape: BoxShape.circle,
    //     ),
    //     child: Icon(Icons.person)),
    // SizedBox(
    //   width: 10,
    // )
    // ]),
    // onSelected: (WhatTodo result) {
    //   if (result == WhatTodo.logout) {
    //  authBloc.add (LogoutButtonPressed());
    // showDialog(
    //   context: context,
    //   builder: (context) => new AlertDialog(
    //     title: new Text('Are you sure?'),
    //     content: new Text('Do you want to logout?'),
    //     actions: <Widget>[
    //       new FlatButton(
    //         onPressed: () => Navigator.of(context).pop(false),
    //         child: new Text('NO'),
    //       ),
    //       new FlatButton(
    //         onPressed: () {
    //           loginBloc.add(LogoutButtonPressed());

    //           // Navigator.of(context).pop(true);
    //         },
    //         child: new Text('YES'),
    //       ),
    //     ],
    //   ),
    // );
    //     }
    //   },
    //   itemBuilder: (BuildContext context) => <PopupMenuEntry<WhatTodo>>[
    //     const PopupMenuItem<WhatTodo>(
    //       value: WhatTodo.logout,
    //       child: Text("LOGOUT      "),
    //     ),
    //   ],
    // );
    // ]);
  }

  Widget TopOtherMenu() {
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
        if (result == WhatTodo.history) {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => History()));
        } else if (result == WhatTodo.newCallcard) {
          // initialization
          final responseBloc = BlocProvider.of<ResponseBloc>(context);
          responseBloc.add(ResetResponse());

          final infoBloc = BlocProvider.of<CallInfoBloc>(context);
          infoBloc.add(ResetCallInfo());

          final teamBloc = BlocProvider.of<TeamBloc>(context);
          teamBloc.add(ResetTeam());

          final timeBloc = BlocProvider.of<TimeBloc>(context);
          timeBloc.add(ResetTime());

          final sceneBloc = BlocProvider.of<SceneBloc>(context);
          sceneBloc.add(LoadScene(
              selectedPPE: new PPE(),
              selectedEnvironment: [],
              selectedCaseType: [],
              selectedPatient: [],
              selectedBackup: [],
              selectedServices: new OtherServices()));

          final patientBloc = BlocProvider.of<PatientBloc>(context);
          patientBloc.add(InitPatient());

          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CallcardTabs(
                      // callcard_no: "",
                      // call_information: new CallInformation(),
                      // response_time: new ResponseTime(),
                      // response_team: new ResponseTeam(),
                      // patients: List(),
                      )));
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhatTodo>>[
        const PopupMenuItem<WhatTodo>(
            value: WhatTodo.newCallcard,
            child: ListTile(
              title: Text(
                "New Callcard",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              leading: Icon(Icons.add),
            )),
        const PopupMenuItem<WhatTodo>(
            value: WhatTodo.history,
            child: ListTile(
              title: Text(
                "Show History",
                style: TextStyle(fontFamily: "Poppins"),
              ),
              leading: Icon(Icons.history),
            ))
      ],
    );
    // ]);
  }
}

// class MySliverAppBar extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;

//   MySliverAppBar({@required this.expandedHeight});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Stack(
//       fit: StackFit.expand,
//       overflow: Overflow.visible,
//       children: [
//         Container(
//           width: double.infinity,
//           child: SvgPicture.asset("assets/town.svg"),
//         ),
//         Container(
//           width: double.infinity,
//           child: Center(
//             child: Opacity(
//               opacity: shrinkOffset / expandedHeight,
//               child: Text(
//                 "MySliverAppBar",
//                 style: TextStyle(
//                   // color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 23,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // Positioned(
//         //   top: expandedHeight / 2 - shrinkOffset,
//         //   left: MediaQuery.of(context).size.width / 4,
//         //   child: Opacity(
//         //     opacity: (1 - shrinkOffset / expandedHeight),
//         //     child: Card(
//         //       elevation: 10,
//         //       child: SizedBox(
//         //         height: expandedHeight,
//         //         width: MediaQuery.of(context).size.width / 2,
//         //         child: FlutterLogo(),
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }

//   @override
//   double get maxExtent => expandedHeight;

//   @override
//   double get minExtent => 100;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }

class Dashboard extends StatelessWidget {
  final username;
  final lastUpdated;
  final phc;
  final totalCount;
  final successCount;
  final failedCount;

  Dashboard(
      {this.lastUpdated,
      this.username,
      this.phc,
      this.totalCount,
      this.successCount,
      this.failedCount});

  @override
  build(BuildContext context) {
    return Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          username != null
              ? Text(
                  "Welcome, $username",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                )
              : GreyBox(),
          SizedBox(
            height: 20,
          ),
          Text(
            "Dashboard",
            style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 5,
          ),
          lastUpdated != null
              ? Text(
                  DateFormat("dd MMM yyyy, h:mm aa ").format(
                    DateTime.parse(lastUpdated),
                  ),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              : GreyBox(),
          SizedBox(
            height: 20,
          ),
          // SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          // child:
          Row(
            children: [
              Flexible(
                flex: 1,
                child: StatsCard(
                  labelText: "Total",
                  count: totalCount,
                  color: Colors.blue[200],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: StatsCard(
                  labelText: "Success",
                  count: successCount,
                  color: Colors.green[200],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 1,
                child: StatsCard(
                  labelText: "Failed",
                  count: failedCount,
                  color: Color(0xffFF5B5B),
                ),
              ),
            ],
          ),
          // ),

          // Expanded(
          //   // height: MediaQuery.of(context).size.height / 2,
          //   child:
          // ListView.builder(
          //   // scrollDirection: Axis.horizontal,
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: 100,
          //   itemBuilder: (ctx, idx) {
          //     return Container(
          //       width: 100,
          //       height: 20,
          //       child: Text("Hello"),
          //     );
          //   },
          // ),
          // )
          // Container(
          //   padding: EdgeInsets.symmetric(
          //       //     horizontal: 20,
          //       vertical: 20),
          //   child: TextFormField(
          //     style: TextStyle(
          //         fontFamily: "Poppins",
          //         fontWeight: FontWeight.w700,
          //         fontSize: 18,
          //         letterSpacing: 1.0),
          //     decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.search),
          //       suffixIcon: IconButton(
          //         onPressed: () => searchController.clear(),
          //         icon: Icon(Icons.cancel),
          //       ),
          //       floatingLabelBehavior: FloatingLabelBehavior.never,
          //       labelText: "Search Call Card No",
          //       labelStyle: TextStyle(
          //         fontWeight: FontWeight.w500,
          //       ),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(40),
          //         borderSide: new BorderSide(),
          //       ),
          //     ),
          //     controller: searchController,
          //   ),
          // )

          // phc!=null? _buildList(phc)
        ]);
    // );
  }
}

class GreyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 100,
      height: 50,
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.rectangle),
    );
  }
}
