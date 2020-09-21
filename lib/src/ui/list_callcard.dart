import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          leading: TopOtherMenu(),
          title: Text(
            "PH Care",
            style: TextStyle(fontFamily: "Poppins", fontSize: 30),
          ),
          actions: <Widget>[
            Padding(padding: EdgeInsets.only(right: 10), child: TopUserMenu()),
          ],
        ),
        body: RefreshIndicator(
          // displacement: 20,
          onRefresh: () {
            BlocProvider.of<PhcBloc>(context).add(
              RefreshPhc(),
            );

            // Timer timer = new Timer(new Duration(seconds: 3), () {
            //   _refreshCompleter.complete();
            // });
            print("REfreshIndicator===========");
            print("what is state now:");
            print(phcBloc.state);
            // if (phcBloc.state is PhcLoaded) {
            //   _refreshCompleter?.complete();
            //   _refreshCompleter = Completer();
            // }
            return _refreshCompleter.future;
          },
          child: SingleChildScrollView(
            // physics: AlwaysScrollableScrollPhysics(),
            // physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(20),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     SizedBox(
              //       height: 20,
              //     ),

              // Expanded(
              child: BlocProvider(
                create: (context) => PhcBloc(
                    phcRepository: phcRepository, phcDao: phcDaoClient.phcDao),
                child: BlocConsumer<PhcBloc, PhcState>(
                  listener: (context, state) {
                    if (state is PhcLoaded) {
                      // //   print("Phcloaded----in listener");
                      _refreshCompleter.complete();
                      _refreshCompleter = Completer();
                    }
                  },
                  builder: (context, state) {
                    phcBloc = BlocProvider.of<PhcBloc>(context);

                    print(state);

                    if (state is PhcEmpty) {
                      phcBloc.add(FetchPhc());
                    } else if (state is PhcLoaded) {
                      // _refreshCompleter.isCompleted
                      //     ? _refreshCompleter = Completer()
                      //     : _refreshCompleter.complete();
                      // _refreshCompleter.complete();
                      // _refreshCompleter = Completer();
                      final phc = state.phc;

                      return Column(
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

                            SizedBox(
                              height: 10,
                            ),

                            Container(
                              // margin: EdgeInsets.symmetric(
                              //     // horizontal: 20,
                              //     vertical: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkTheme
                                    ? Colors.grey[900]
                                    : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x80000000).withOpacity(0.2),
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.0),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    letterSpacing: 1.0),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(bottom: 20),
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
                                    border: InputBorder.none),
                                controller: searchController,
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            // Expanded(
                            //   child:
                            _buildList(phc),
                            // )
                          ]);
                    }
                    return Dashboard();
                  },
                ),
              ),
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
      itemCount: phc.callcards.length,
      itemBuilder: (BuildContext context, int index) {
        final callInfo = phc.callcards[index].callInformation;

        return (filter == null || filter == "")
            ? CardList(
                callcardNo: callInfo.callcard_no,
                receivedCall: callInfo.call_received,
                plateNo: callInfo.plate_no,
                address: callInfo.incident_location,
                updatedDate: callInfo.updated_date,
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
                        );
                      },
                    ),
                  );
                },
              )
            : phc.callcards[index].callInformation.callcard_no
                    .toLowerCase()
                    .toString()
                    .contains(filter.toLowerCase())
                ? CardList(
                    callcardNo: callInfo.callcard_no,
                    receivedCall: callInfo.call_received,
                    plateNo: callInfo.plate_no,
                    address: callInfo.incident_location,
                    updatedDate: callInfo.updated_date,
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
                : Container();
      },
    );
  }

  Widget TopUserMenu() {
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
  }

  Widget TopOtherMenu() {
    return PopupMenuButton<WhatTodo>(
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
              builder: (context) => CallcardTabs(),
            ),
          );
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        height: 10,
      ),
      Text(
        "Dashboard",
        style: TextStyle(
            fontFamily: "Poppins", fontSize: 24, fontWeight: FontWeight.w900),
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
        height: 10,
      ),
      Row(
        children: [
          Flexible(
            flex: 1,
            child: StatsCard(
              labelText: "Total",
              count: totalCount,
              color: Colors.blue,
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
              color: Colors.green,
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
              color: Color(0xffED3B47),
            ),
          ),
        ],
      ),
      // ),
    ]);
  }
}

class GreyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 30,
      decoration:
          BoxDecoration(color: Colors.grey[300], shape: BoxShape.rectangle),
    );
  }
}
