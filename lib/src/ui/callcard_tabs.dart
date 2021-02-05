import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/patinfo_provider.dart';
import 'package:phcapp/src/ui/history.dart';
import 'package:phcapp/src/ui/tabs/patient_list.dart';
import 'package:phcapp/src/ui/tabs/response_team.dart';
import 'package:phcapp/src/ui/tabs/response_time.dart';
import 'package:phcapp/src/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
// import '../blocs/info_bloc.dart';
import 'package:phcapp/src/ui/tabs/call_information.dart';
import '../repositories/repositories.dart';

import 'package:http/http.dart' as http;
// import 'src/tab_screens/patients.dart';
// import 'src/tab_screens/information.dart';
// import 'src/tab_screens/team.dart';
// import 'src/tab_screens/timer.dart';
// import '../models/info_model.dart';
// import '../models/phc_model.dart';
// import '../models/team_model.dart';
// import '../models/timer_model.dart';
import '../models/phc.dart';
import 'list_callcard.dart';

class CallcardTabs extends StatefulWidget {
  final String callcard_no;
  final CallInformation call_information;
  final ResponseTeam response_team;
  final ResponseTime response_time;
  final SceneAssessment scene_assessment;
  final List<Patient> patients;
  // final PhcDao phcDao;

  CallcardTabs(
      {this.callcard_no,
      this.call_information,
      this.response_team,
      this.response_time,
      this.patients,
      this.scene_assessment
      // this.phcDao
      });

  _CallcardTabs createState() => _CallcardTabs();
}

class _CallcardTabs extends State<CallcardTabs> with TickerProviderStateMixin {
  CallInfoBloc callInfoBloc;
  bool isLoading = false;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final PhcRepository phcRepository =
      PhcRepository(phcApiClient: PhcApiClient(httpClient: http.Client()));
  // final PhcRepository phcRepository =
  //     PhcRepository(phcApiClient: PhcApiClient(httpClient: http.Client()));

  // final PhcDaoClient phcDaoClient = new PhcDaoClient(phcDao: new PhcDao());

  PhcBloc phcBloc;
  TimeBloc timeBloc;
  PatientBloc patientBloc;
  TeamBloc teamBloc;
  CallCardTabBloc tabBloc;
  HistoryBloc historyBloc;
  ResponseBloc responseBloc;
  SceneBloc sceneBloc;
  AuthBloc authBloc;

  AnimationController _controller;
  Animation _animation;

  // CallcardTabs(
  //     {this.callcard_no,
  //     this.call_information,
  //     this.response_team,
  //     this.response_time,
  //     this.patients,
  //     this.phcDao});

  // @override

  @override
  void didChangeDependencies() {
    teamBloc = BlocProvider.of<TeamBloc>(context);
    timeBloc = BlocProvider.of<TimeBloc>(context);
    patientBloc = BlocProvider.of<PatientBloc>(context);
    tabBloc = BlocProvider.of<CallCardTabBloc>(context);
    historyBloc = BlocProvider.of<HistoryBloc>(context);
    callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    responseBloc = BlocProvider.of<ResponseBloc>(context);
    sceneBloc = BlocProvider.of<SceneBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);

    super.didChangeDependencies();
  }

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween<double>(
      begin: 20,
      end: 100,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticInOut,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    // callInfoBloc.close();

    callInfoBloc.add(ResetCallInfo());
    teamBloc.add(ResetTeam());
    timeBloc.add(ResetTime());
    sceneBloc.add(ResetScene());
    patientBloc.add(InitPatient());
    responseBloc.add(ResetResponse());

    // if (BlocProvider.of<TeamBloc>(context).response_team != null)
    //   print("dispose response team");
    // BlocProvider.of<TeamBloc>(context).response_team = new ResponseTeam();
    super.dispose();
  }

  showLoading() => showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Callcard is Publishing..."),
            content: Container(
              width: 100,
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
      });

  mandatoryNotFilledError() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Missing required field"),
          content: Text("Call card no should not be empty"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
        );
      });

  showError() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sending Failed"),
          content: Text(
              "Something went wrong. \nWe keep your last sending in History"),
          actions: <Widget>[
            FlatButton(
              child: Text("GOTO HISTORY"),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/history', ModalRoute.withName('/listCallcards'));

                // Navigator.popAndPushNamed(context, '/history');
                // Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => History()))
                //     .then((result) => Navigator.of(context, rootNavigator: true)
                //             .pop(result) //;
                //         );

                // Navigator.pop(context);
              },
            )
          ],
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
        );
      });

  savingError() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Writing Failed"),
          content: Text("We couldn't save in History"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
        );
      });

  showSuccess() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Sync Success",
            textAlign: TextAlign.center,
            // style: TextStyle(fontSize: 14),
          ),
          content: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: _animation,
                      builder: (ctx, child) {
                        return Container(
                          constraints:
                              BoxConstraints(minWidth: 100, minHeight: 100),
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: _animation.value,
                          ),
                        );
                      }
                      // width: 50,
                      // height: 50,
                      // duration: Duration(seconds: 2),
                      // child:

                      ),
                  SizedBox(
                    height: 20,
                  ),
                  // Column(
                  // RichText(
                  //   textAlign: TextAlign.center,
                  //   text: TextSpan(
                  //       style: TextStyle(color: Colors.black),
                  // children: [
                  Text("Call Card No: "),
                  Text(
                      // widget.call_information.callcard_no ??
                      callInfoBloc.state.callInformation != null
                          ? callInfoBloc.state.callInformation.callcard_no
                          : widget.call_information != null
                              ? widget.call_information.callcard_no
                              : '',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10),
                  Text(" has successfully synced"),
                  // TextSpan(
                  //     text: "VIEW LIST CC",
                  //     style: TextStyle(fontWeight: FontWeight.bold)),
                  // TextSpan(text: " to end process"),
                  // ]),
                ]),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  "RETURN TO DASHBOARD",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ListCallcards()),
                      ModalRoute.withName('/listCallcards')); //     context,
                  // )
                  // (
                  //     MaterialPageRoute(
                  //         builder: (context) =>
                  //             ListCallcards())).then((result) =>
                  //     Navigator.of(context, rootNavigator: true).pop(result));
                }),
            // FlatButton(
            //     child: Text("CONTINUE EDITING"),
            //     onPressed: () {
            //       // Navigator.push(context,
            //       //         MaterialPageRoute(builder: (context) => History()))
            //       //     .then((result) {
            //       Navigator.pop(context);
            //     })
          ],
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
        );
      });

  convertDateToStandard(String datetime) {
    // if (datetime != null) {
    if (datetime != null && datetime.contains("-") != true) {
      //dd/MM/yyyy HH:mm:ss to yyyy-MM-dd HH:mm:ss
      var split = datetime.split("/");
      var dd = split[0];
      var MM = split[1];
      var yyyy = split[2].substring(0, 4);

      var time = datetime.substring(11);

      print(time);
      return "$yyyy-$MM-$dd $time:00";
    } else {
      return datetime;
    }
    // }
    // return null;
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit callcard without sync'),
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

  Future<void> _handleSubmit(BuildContext context) async {
    try {
      print("handlesubmit pressed!");
      // Dialogs.showLoadingDialog(context, _keyLoader);

      // Navigator.of(_keyLoader.currentContext, rootNavigator: true)
      //     .pop(); //close the dialoge
      // Navigator.pushReplacementNamed(context, "/listCallcards");
      // print("callInfoBloc state push toserver");

      final call_information = callInfoBloc.state.callInformation ??
          widget.call_information ??
          new CallInformation();
      // if (call_information != null) {
      call_information.callReceived = call_information != null
          ? convertDateToStandard(call_information.call_received)
          : DateTime.now().toString();
      // }

      call_information.assignId = widget.call_information != null
          ? widget.call_information.assign_id
          : null;
      call_information.plateNo = responseBloc.state.vehicleRegNo != null
          ? responseBloc.state.vehicleRegNo
          : widget.response_team != null
              ? widget.response_team.vehicleRegno
              : null;
      // print(call_information.callcard_no);
      // call_information.plateNo =
      //     widget.call_information.plate_no;
      // : convertDateToStandard(
      //     widget.call_information.call_received);

      // print(currentState.toJson());
      print("INSIDE CALL INFO");
      // print(call_information.toJson());
      // print("+=======+");
      // print(responseBloc.state.serviceResponse);
      // print(responseBloc.state.vehicleRegNo);
      // print(widget.call_information.toJson());
      final response_team = new ResponseTeam(
          serviceResponse: responseBloc.state.serviceResponse != null
              ? responseBloc.state.serviceResponse
              : widget.response_team != null
                  ? widget.response_team.serviceResponse
                  : '',
          vehicleRegno: responseBloc.state.vehicleRegNo != null
              ? responseBloc.state.vehicleRegNo
              : widget.call_information != null
                  ? widget.call_information.plate_no
                  : '',
          staffs: teamBloc.state.selectedStaffs != null
              ? teamBloc.state.selectedStaffs
              : widget.response_team != null
                  ? widget.response_team.staffs
                  : []);
      // print(teamState);

      final response_time = timeBloc.state.responseTime;
      // ??
      //     new ResponseTime();
      // print(timeState);

      final scene_assessment = new SceneAssessment(
          ppe: sceneBloc.state.selectedPPE != null
              ? sceneBloc.state.selectedPPE
              : widget.scene_assessment != null
                  ? widget.scene_assessment.ppe
                  : null,
          environment: sceneBloc.state.selectedEnvironment != null
              ? sceneBloc.state.selectedEnvironment
              : widget.scene_assessment != null
                  ? widget.scene_assessment.environment
                  : "",
          caseType: sceneBloc.state.selectedCaseType != null
              ? sceneBloc.state.selectedCaseType
              : widget.scene_assessment != null
                  ? widget.scene_assessment.caseType
                  : "",
          patient: sceneBloc.state.selectedPatient != null
              ? sceneBloc.state.selectedPatient
              : widget.scene_assessment != null
                  ? widget.scene_assessment.patient
                  : "",
          backup: sceneBloc.state.selectedBackup != null
              ? sceneBloc.state.selectedBackup
              : widget.scene_assessment != null
                  ? widget.scene_assessment.backup
                  : "",
          otherServicesAtScene: sceneBloc.state.selectedServices != null
              ? sceneBloc.state.selectedServices
              : widget.scene_assessment != null
                  ? widget.scene_assessment.otherServicesAtScene
                  : null);
      // print(patientState);

      final patientList = patientBloc.state.patients != null
          ? patientBloc.state.patients
          : widget.patients != null
              ? List<dynamic>.from(widget.patients).toList()
              : [];

      // print(patientList.length);
      // print(scene_assessment.toJson());
      // print(patientList.elementAt(0).patientInformation.idNo);

      // print(patientBloc.sceneAssessment.toJson());
      // historyBloc.add(AddHistory(
      //     callcard: new Callcard(
      //         callInformation: call_information,
      //         responseTeam: response_team,
      //         responseTime: response_time,
      //         patients: List<Patient>(),
      //         sceneAssessment: new SceneAssessment())));

      // print("DONE");
      // print(call_information);
      // print(scene_assessment);
      // print(response_team);

      // print(response_time);
      // print(patientList);
      // if (patientList.length > 0) {
      //   print("PATIENT LIST MORE THAN ONE");
      //   patientList.map((f) {
      //     print("what inside patientlist");
      //     // print((f));
      //     print(f.toJson());
      //   }).toList();
      // }
      Staff user = authBloc.getAuthorizedUser;

      // print(patientList);
      if (call_information.callcard_no != null &&
          call_information.callcard_no.isNotEmpty) {
        tabBloc.add(PublishCallcard(
          authorizedUser: user.userId,
          callInformation: call_information,
          // ?? widget.call_information,
          responseTeam: response_team,
          // responseTime: response_time,
          sceneAssessment: scene_assessment,
          patients: patientList != null
              ? List<Patient>.from(patientList).toList()
              : [],
          // responseTeam: response_team,
          responseTime:
              response_time ?? widget.response_time ?? new ResponseTime(),
          // patients: patientList,
          // sceneAssessment:
          //     SceneAssessment(otherServicesAtScene: []
          //     )
        ));
      } else {
        mandatoryNotFilledError();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // var callcard = Provider.of<Callcard>(context);

    // callInfoBloc = BlocProvider.of<CallInfoBloc>(context);
    // var callInfoBloc = Provider.of<CallInfoBloc>(context);

    phcBloc = BlocProvider.of<PhcBloc>(context);

    return WillPopScope(
      onWillPop: _onWillPop,
      child:
          // MultiProvider(
          //     providers: [
          //       BlocProvider(create: (context) => TeamBloc(phcDao: new PhcDao())),
          //       // BlocProvider(
          //       //     create: (context) => StaffBloc(phcRepository: phcRepository))
          //     ],
          //     child:
          DefaultTabController(
        length: 4,
        child: BlocConsumer<CallCardTabBloc, TabState>(
          listener: (context, state) {
            if (state is CallcardToPublishLoading) {
              Dialogs.showLoadingDialog(context, _keyLoader);

              // Navigator.pushReplacementNamed(context, "/listCallcards");
              // setState(() {
              //   isLoading = true;
              // });
              //circular progress alert dialog
              // showLoading();
            } else if (state is CallcardToPublishSuccess) {
              Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                  .pop(); //close the dialoge
              //Callcard success publish dialog with ok
              // if (isLoading == true) {
              //   Navigator.pop(context);
              // }
              showSuccess();

              //start play
              _controller.forward();

              // clear all state to avoid cache
              // callInfoBloc.add(ResetCallInfo());
              // teamBloc.add(ResetTeam());
              // timeBloc.add(ResetTime());
              // sceneBloc.add(ResetScene());
              // patientBloc.add(InitPatient());

              // setState(() {
              //   isLoading = false;
              // });
            } else if (state is CallcardToPublishFailed) {
              //callcard failed to publish dialog error

              // if (isLoading == true) {
              //   Navigator.pop(context);
              // }
              showError();

              // callInfoBloc.add(ResetCallInfo());
              // teamBloc.add(ResetTeam());
              // timeBloc.add(ResetTime());
              // sceneBloc.add(ResetScene());
              // patientBloc.add(InitPatient());

              // setState(() {
              //   isLoading = false;
              // });
            } else if (state is CallcardToSavingError) {
              savingError();
            }
          },
          builder: (context, state) {
            return Scaffold(
              // backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                // shape: ShapeBorder(BorderRadius.only(topLeft:Radius.circular(2.0))),
                // backgroundColor: Colors.white,
                bottom: TabBar(
                  // labelColor: Colors.grey,
                  // unselectedLabelColor: Colors.white,
                  // unselectedLabelStyle: TextStyle(fontFamily: "Poppins"),

                  // indicatorPadding: EdgeInsets.symmetric(vertical: 40),
                  indicatorWeight: 4.0,

                  // indicatorSize: TabBarIndicatorSize.tab,
                  // indicator: BoxDecoration(
                  //     // border: Border.,
                  //     borderRadius: BorderRadius.only(
                  //       // topLeft: Radius.circular(10),
                  //       // topRight: Radius.circular(10),
                  //       bottomLeft: Radius.circular(50),
                  //     ),
                  //     color: Colors.white),

                  // unselectedLabelColor: Colors.red,
                  // labelColor: Colors.blue,
                  // indicatorColor: Colors.white,
                  tabs: [
                    Tab(icon: Icon(Icons.info), text: "CALL INFO"),
                    Tab(icon: Icon(Icons.directions_car), text: "RESPONDER"),
                    Tab(icon: Icon(Icons.timer), text: "TIMING"),
                    Tab(icon: Icon(Icons.person), text: "PATIENT"),
                  ],
                ),
                title: Center(
                  child: StreamBuilder(
                    initialData:
                        widget.callcard_no != null ? widget.callcard_no : '',
                    stream: callInfoBloc.cardNoController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data,
                            style: TextStyle(
                                fontFamily: "OpenSans", fontSize: 20));
                      }
                      return Container();
                    },
                  ),
                ),

                // actions: <Widget>[
                //   Container(
                //     alignment: Alignment.center,
                //     margin: EdgeInsets.all(5),
                //     decoration: BoxDecoration(
                //         color: Colors.blue,
                //         borderRadius: BorderRadius.circular(40.0)),
                //     // padding: EdgeInsets.only(right: 10),
                //     child: InkWell(
                //       onTap: () => _handleSubmit(context),
                //       child:
                //           // )
                //           // FlatButton.icon(

                //           // )
                //           Container(
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.all(10),
                //         child:

                //             // ,)
                //             Row(
                //           // mainAxisAlignment: MainAxisAlignment.center,
                //           // crossAxisAlignment: CrossAxisAlignment.center,
                //           children: <Widget>[
                //             Icon(Icons.cloud_upload),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             // ,)
                //             // tooltip: "Push to Server",
                //             // onPressed: () {
                //             // Navigator.push(context,
                //             //     MaterialPageRoute(builder: (context) => History()));
                //             // },
                //             // ),
                //             Text("Sync HISKKM")
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ],
              ),
              // backgroundColor: Colors.purple),
              body:
                  // Consumer<CallInformation>(builder: (context, info, child) {
                  //   return
                  TabBarView(
                children: <Widget>[
                  CallInformationScreen(
                      call_information: widget.call_information),
                  ResponseTeamScreen(
                      // context: context,
                      response_team: widget.response_team,
                      assign_id: (widget.call_information != null)
                          ? widget.call_information.assign_id
                          : null),
                  ResponseTimeScreen(
                    // responseTime: widget.response_time,
                    responseTime: widget.response_time != null
                        ? widget.response_time
                        : new ResponseTime(),
                    // assign_id: (widget.call_information != null)
                    //     ? widget.call_information.assign_id
                    //     : null
                  ),

                  PatientListScreen(
                    sceneAssessment: widget.scene_assessment,
                    patients: widget.patients,
                    assign_id: (widget.call_information != null)
                        ? widget.call_information.assign_id
                        : null,
                  )
                  // Icon(Icons.ev_station),
                  // Icon(Icons.ev_station),
                  // Team(),
                  // Timer(),
                  // Patients(),
                ],
                // );
                // }
              ),

              persistentFooterButtons: [
                Material(
                  child: Ink(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Send",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.send, color: Colors.white),
                            ]),
                      ),
                      onTap: () => _handleSubmit(context),
                    ),
                  ),
                )
              ],
            );
          },
          // child:
        ),
      ),
    );
    // );
  }

  // });
}
