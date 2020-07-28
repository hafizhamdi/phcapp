import 'dart:async';

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
    // final themeProvider = Provider.of<ThemeProvider>(context);

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: TopOtherMenu(),
          title: Text("Call Cards"),
          actions: <Widget>[
            Padding(padding: EdgeInsets.only(right: 10), child: TopUserMenu()),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxWidth: 700),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: TextField(
                  decoration: InputDecoration(
                      hasFloatingPlaceholder: false,
                      labelText: "Search Call Card No",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(40.0),
                        borderSide: new BorderSide(),
                      ),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () => searchController.clear(),
                          icon: Icon(Icons.cancel))),
                  controller: searchController,
                ),
              ),
              Expanded(
                child: BlocProvider(
                  create: (context) => PhcBloc(
                      phcRepository: phcRepository,
                      phcDao: phcDaoClient.phcDao),
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
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 700),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    left: 30,
                                    right: 20,
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Last updates at ",
                                            // style: TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                              DateFormat(
                                                      "dd MMM yyyy, h:mm aa ")
                                                  .format(DateTime.parse(
                                                      phc.lastUpdated)),
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          Text(" with "
                                              // style:
                                              //     TextStyle(color: Colors.grey),
                                              ),
                                          Text(phc.callcards.length.toString(),
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          Text(" Results"
                                              // style:
                                              //     TextStyle(color: Colors.grey),
                                              )
                                        ],
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.info),
                                        tooltip:
                                            "Pull downward to get latest call cards",
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(child: _buildList(phc))
                              ],
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ],
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
      itemCount: phc.callcards.length,
      itemBuilder: (BuildContext context, int index) {
        final callInfo = phc.callcards[index].callInformation;

        return (filter == null || filter == "")
            ? ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        callInfo.callcard_no,
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: <Widget>[
                              Row(children: [
                                Icon(
                                  Icons.person,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(phc.callcards[index].patients.length
                                        .toString() +
                                    ' Patient')
                              ]),
                              SizedBox(
                                width: 40,
                              ),
                              Row(children: [
                                Icon(
                                  Icons.group,
                                  color: Colors.grey,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(phc.callcards[index].responseTeam.staffs
                                        .length
                                        .toString() +
                                    ' Team')
                              ])
                              // ),
                            ]),

                            // ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Icon(Icons.call_received,
                                  color: Colors.grey, size: 16),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                DateFormat("d MMM yyyy, h:mm aaa").format(
                                    DateTime.parse(callInfo.call_received)),
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              )
                            ])
                          ]),
                      Container(
                          width: 120,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(5),
                          decoration: new BoxDecoration(
                              // color: Colo,
                              border:
                                  Border.all(width: 1.5, color: Colors.orange),
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(5.0))),
                          child: Row(children: [
                            Icon(Icons.label_important, color: Colors.orange),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Text((callInfo.plate_no != null)
                                    ? callInfo.plate_no
                                    : ""))
                          ]))
                    ]),

                leading: Container(
                  // alignment: Alignment.centerLeft,
                  width: 60,
                  height: 60,
                  decoration: new BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.headset_mic, color: Colors.white),
                ),
                // trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
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
                  // Navigator.pushNamed(context, "/callcarddetail");
                },
              )
            : phc.callcards[index].callInformation.callcard_no
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase())
                ? ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          callInfo.callcard_no,
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        )),
                        Text(
                          DateFormat("d MMM yyyy, hh:mm aaa")
                              .format(DateTime.parse(callInfo.call_received)),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(children: [
                            Row(children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(
                                    Icons.person,
                                    size: 16,
                                    color: Colors.grey,
                                  )),
                              Text(phc.callcards[index].patients.length
                                      .toString() +
                                  ' Patient'),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(
                                    Icons.group,
                                    color: Colors.grey,
                                    size: 16,
                                  )),
                              Text(phc.callcards[index].responseTeam.staffs
                                      .length
                                      .toString() +
                                  ' Team')
                            ])
                          ]),
                          Container(
                              width: 100,
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(5),
                              decoration: new BoxDecoration(
                                  // color: Colo,
                                  border: Border.all(
                                      width: 1.5, color: Colors.orange),
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(5.0))),
                              child: Text((callInfo.plate_no != null)
                                  ? callInfo.plate_no
                                  : ""))
                        ]),
                    leading: Container(
                      // alignment: Alignment.centerLeft,
                      width: 60,
                      height: 60,
                      decoration: new BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.headset, color: Colors.white),
                    ),
                    // trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
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
                      // Navigator.pushNamed(context, "/callcarddetail");
                    },
                  )
                : Container();
      },
    );
    // );
  }

  Widget TopUserMenu() {
    Staff user = authBloc.getAuthorizedUser;
    return PopupMenuButton<WhatTodo>(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              "Welcome, " + user.userId,
              style: TextStyle(fontFamily: "Raleway"),
            )),
        Container(
            // alignment: Alignment.centerLeft,
            width: 30,
            height: 30,
            decoration: new BoxDecoration(
              color: Colors.pinkAccent,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.person)),
        SizedBox(
          width: 10,
        )
      ]),
      onSelected: (WhatTodo result) {
        if (result == WhatTodo.logout) {
          //  authBloc.add (LogoutButtonPressed());
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
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<WhatTodo>>[
        const PopupMenuItem<WhatTodo>(
          value: WhatTodo.logout,
          child: Text("LOGOUT      "),
        ),
      ],
    );
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
              context, MaterialPageRoute(builder: (context) => History()));
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
              selectedPPE: [],
              selectedEnvironment: [],
              selectedCaseType: [],
              selectedPatient: [],
              selectedBackup: [],
              selectedServices: []));

          final patientBloc = BlocProvider.of<PatientBloc>(context);
          patientBloc.add(InitPatient());

          Navigator.push(
              context,
              MaterialPageRoute(
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
          child: Text("NEW CALLCARD"),
        ),
        const PopupMenuItem<WhatTodo>(
          value: WhatTodo.history,
          child: Text("HISTORY"),
        )
      ],
    );
    // ]);
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          width: double.infinity,
          child: SvgPicture.asset("assets/town.svg"),
        ),
        Container(
          width: double.infinity,
          child: Center(
            child: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Text(
                "MySliverAppBar",
                style: TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ),
          ),
        ),
        // Positioned(
        //   top: expandedHeight / 2 - shrinkOffset,
        //   left: MediaQuery.of(context).size.width / 4,
        //   child: Opacity(
        //     opacity: (1 - shrinkOffset / expandedHeight),
        //     child: Card(
        //       elevation: 10,
        //       child: SizedBox(
        //         height: expandedHeight,
        //         width: MediaQuery.of(context).size.width / 2,
        //         child: FlutterLogo(),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
