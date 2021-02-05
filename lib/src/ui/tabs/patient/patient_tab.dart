import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:phcapp/src/providers/medication_provider.dart';
import 'package:phcapp/src/providers/patinfo_provider.dart';
import 'package:phcapp/src/providers/vital_provider.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/intervention_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/medication_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/otherinfo_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/outcome_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/pat_ass_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/reporting_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/sampler_bloc.dart';
import 'package:phcapp/src/ui/tabs/patient/asessments/blocs/trauma_bloc.dart';
// import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_detail.dart';
import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_items.dart';
import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_timelog.dart';
import 'package:provider/provider.dart';
import 'asessments/main_assessment.dart';
// import 'main_assessment.dart';
import 'information.dart';
// import 'cprlog.dart';
// import 'assessment.dart';
import 'vitalsign_list.dart';

enum Action { cancel, delete }

class PatientTab extends StatefulWidget {
  final Patient patient;
  final index;

  PatientTab({this.patient, this.index});

  _PatientTab createState() => _PatientTab();
}

class _PatientTab extends State<PatientTab> {
  PatientBloc patientBloc;
  PatientInformation patientInformation;
  VitalBloc vitalBloc;
  AssPatientBloc assPatientBloc;
  InterBloc interBloc;
  TraumaBloc traumaBloc;
  MedicationBloc medicationBloc;
  ReportingBloc reportingBloc;
  OutcomeBloc outcomeBloc;
  CprBloc cprBloc;
  SamplerBloc samplerBloc;
  OtherBloc otherBloc;

  Action getAction(index) {
    if (index == null)
      return Action.cancel;
    else
      return Action.delete;
  }

  @override
  void didChangeDependencies() {
    print("DID DEPENDENCY");
    // print(widget.patient.toJson());

    patientBloc = BlocProvider.of<PatientBloc>(context);

    assPatientBloc = BlocProvider.of<AssPatientBloc>(context);
    interBloc = BlocProvider.of<InterBloc>(context);
    traumaBloc = BlocProvider.of<TraumaBloc>(context);
    medicationBloc = BlocProvider.of<MedicationBloc>(context);
    reportingBloc = BlocProvider.of<ReportingBloc>(context);
    outcomeBloc = BlocProvider.of<OutcomeBloc>(context);
    cprBloc = BlocProvider.of<CprBloc>(context);
    samplerBloc = BlocProvider.of<SamplerBloc>(context);
    otherBloc = BlocProvider.of<OtherBloc>(context);

    vitalBloc = BlocProvider.of<VitalBloc>(context);

    vitalBloc.add(ResetVital());
    // final provider = Provider.of<PatInfoProvider>(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  convertDOBtoStandard(data) {
    print("CONVERT DOB");
    if (data == "") return null;

    var split = data.split('/');
    var dd = split[0];
    var MM = split[1];
    var yyyy = split[2];

    print(data);
    print("$yyyy-$MM-$dd");
    return "$yyyy-$MM-$dd";
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to go back without create note?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('NO'),
              ),
              new FlatButton(
                onPressed: () {
                  // cprBloc.add(ResetCprLog());

                  Navigator.of(context).pop(true);
                },
                child: new Text('YES'),
              ),
            ],
          ),
        )) ??
        false;
  }

  invalidInputError() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cannot create note"),
          content: Text("Please fill required fields."),
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

  @override
  Widget build(BuildContext context) {
    final vitalBloc = BlocProvider.of<VitalBloc>(context);
    final action = getAction(widget.index);
    // final patProvider = Provider.of<PatInfoProvider>(context, listen: false);

    PatientInformation preparingResultPatientInformation(BuildContext context) {
      final patProvider = Provider.of<PatInfoProvider>(context, listen: false);

      print("PATPROVIDER VALUES===");
      print(patProvider.getName);
      PatientInformation patInfo = new PatientInformation(
          name: patProvider.getName,
          idNo: patProvider.getId,
          idType: patProvider.getIdtype,
          age: patProvider.getAge,
          dob: convertDOBtoStandard(patProvider.getDob),
          gender: patProvider.getGender);

      print(patProvider.getName);

      return patInfo;
    }

    // CprLog preparingResultCPRlog(BuildContext context) {
    // final logProvider = Provider.of<CPRProvider>(context, listen: false);

    // final logs = logProvider.items;
    // final newCpr = new CprLog(id: "1", created: DateTime.now(), logs: logs);
    // print("PREPARING RESULT CPRLOG");
    // print(newCpr.toJson());

    // List<CprLog> list = List<CprLog>(1);
    // list[0] = newCpr;

    // return newCpr;
    // }

    List<VitalSign> preparingResultVitalSigns(BuildContext context) {
      // print(vitalBloc.state.listVitals);
      // print(vitalBloc.state.listVitals.length);
      return vitalBloc.state.listVitals;
    }

    createButton(BuildContext context, action, index) => InkWell(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0), color: Colors.green),
            // color: Colors.green,
            child: Text((action == Action.delete) ? "SAVE NOTE" : "CREATE NOTE",
                style: TextStyle(color: Colors.white)),
          ),

          // FlatButton(
          onTap: () {
            final patProvider =
                Provider.of<PatInfoProvider>(context, listen: false);

            //         if (patientBloc.formKey.currentState!=null
            // )
            // {
              if(patientBloc.formKey.currentState.validate()) {
            // final provider =
            //     Provider.of<PatInfoProvider>(context, listen: false);
            // if (provider.formKey.currentState.validate()) {
            final patInfo = preparingResultPatientInformation(context);
            // final cprlog = preparingResultCPRlog();

            final traumaBloc = BlocProvider.of<TraumaBloc>(context);

            print("trauma state");
            // print(traumaBloc.state);

            // print(cprlog)

            // final cprBloc = BlocProvider.of<CprBloc>(context);
            print("CPR RESULT WOHOW");
            // print(cprBloc.state.cprLog.toJson());
            // final cprlog = preparingResultCPRlog(context);
            // print(cprlog);

            // final vitalSigns = BlocProvider.of<VitalBloc>(context);
            // final vitalsigns = preparingResultVitalSigns(context);
            if (action == Action.delete) {
              //TODO:Update
              patientBloc.add(UpdatePatient(
                  patient: new Patient(
                      // cprLog: cprBloc.state.cpr,
                      patientInformation: patInfo,
                      cprLog: cprBloc.state.cprLog ?? widget.patient.cprLog,
                      vitalSigns: vitalBloc.state.listVitals ??
                          widget.patient.vitalSigns,
                      patientAssessment:
                          assPatientBloc.state.patientAssessment ??
                              widget.patient.patientAssessment,
                      intervention:
                          interBloc.state.inter ?? widget.patient.intervention,
                      traumaAssessment: traumaBloc.state.traumaAssessment ??
                          widget.patient.traumaAssessment,
                      medicationAssessment:
                          medicationBloc.state.medicationAssessment ??
                              widget.patient.medicationAssessment,
                      incidentReporting:
                          reportingBloc.state.incidentReporting ??
                              widget.patient.incidentReporting,
                      outcome:
                          outcomeBloc.state.outcome ?? widget.patient.outcome,
                      samplerAssessment: samplerBloc.state.samplerAssessment ??
                          widget.patient.samplerAssessment,
                      otherAssessment: otherBloc.state.otherAssessment ??
                          widget.patient.otherAssessment),
                  index: widget.index));

              // print(patien)
            } else {
              print("ADD PATIENT BLOC");
              patientBloc.add(AddPatient(
                patient: new Patient(
                    // cpr: cprBloc.state.cpr,

                    patientInformation: patInfo,
                    cprLog: cprBloc.state.cprLog ?? widget.patient.cprLog,
                    vitalSigns:
                        vitalBloc.state.listVitals ?? widget.patient.vitalSigns,
                    patientAssessment: assPatientBloc.state.patientAssessment ??
                        widget.patient.patientAssessment,
                    intervention:
                        interBloc.state.inter ?? widget.patient.intervention,
                    traumaAssessment: traumaBloc.state.traumaAssessment ??
                        widget.patient.traumaAssessment,
                    medicationAssessment:
                        medicationBloc.state.medicationAssessment ??
                            widget.patient.medicationAssessment,
                    incidentReporting: reportingBloc.state.incidentReporting ??
                        widget.patient.incidentReporting,
                    outcome:
                        outcomeBloc.state.outcome ?? widget.patient.outcome,
                    samplerAssessment: samplerBloc.state.samplerAssessment ??
                        widget.patient.samplerAssessment,
                    otherAssessment: otherBloc.state.otherAssessment ??
                        widget.patient.otherAssessment),
              ));
            }
            print("patient created");

            // final vitalBloc = BlocProvider.of<VitalBloc>(context);
            vitalBloc.add(ResetVital());

            // final interBloc = BlocProvider.of<InterBloc>(context);
            interBloc.add(ResetInter());

            // final patBloc = BlocProvider.of<AssPatientBloc>(context);
            assPatientBloc.add(ResetAssPatient());

            // final traumaBloc = BlocProvider.of<TraumaBloc>(context);
            traumaBloc.add(ResetTrauma());

            // final medicationBloc = BlocProvider.of<MedicationBloc>(context);
            medicationBloc.add(ResetMedication());
            // final reportingBloc = BlocProvider.of<ReportingBloc>(context);
            reportingBloc.add(ResetReporting());
            // final outcomeBloc = BlocProvider.of<OutcomeBloc>(context);
            outcomeBloc.add(ResetOutcome());

            samplerBloc.add(ResetSampler());

            otherBloc.add(ResetOther());
            // cprBloc.add(ResetCprLog());

            Navigator.pop(context);
            // }
            // } else {
            //   invalidInputError();
            }
          },
          // child: Text(
          //   (action == Action.delete) ? "SAVE" : "CREATE",
          //   style: TextStyle(color: Colors.white),
          // )
        );

    print("patient_TAB");
    print(widget.patient.vitalSigns);
    // print(index);
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PatInfoProvider()),

          // BlocProvider(
          //   create: (context) => TraumaBloc(),
          // )
          // Provider<PatInfoProvider>(create: (context) => PatInfoProvider())
        ],
        child: DefaultTabController(
          length: 4,
          child: Consumer<PatInfoProvider>(
            builder: (context, data, child) {
              return Scaffold(
                // backgroundColor: Colors.grey,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    // labelColor: Colors.pinkAccent,
                    // unselectedLabelColor: Colors.white,
                    indicatorWeight: 4.0,

                    // indicatorColor: Colors.white,

                    // indicatorPadding: EdgeInsets.symmetric(vertical: 40),
                    // indicatorWeight: 4.0,
                    // indicatorSize: TabBarIndicatorSize.tab,
                    // indicator: BoxDecoration(
                    //     // border: Border.,
                    //     borderRadius: BorderRadius.only(
                    //       // topLeft: Radius.circular(10),
                    //       // topRight: Radius.circular(10),
                    //       bottomLeft: Radius.circular(50),
                    //     ),
                    //     color: Colors.white),
                    // )
                    // bottom: TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.account_box), text: "PATIENT INFO"),
                      Tab(icon: Icon(Icons.airline_seat_flat), text: "CPRLOG"),
                      Tab(icon: Icon(Icons.favorite), text: "VITALS"),
                      Tab(icon: Icon(Icons.assessment), text: "ASSESSMENT"),
                    ],
                  ),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Patient Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey)),
                        widget.patient.patientInformation.name != null
                            ? Text(widget.patient.patientInformation.name)
                            : Container()

                        // RichText(
                        //   text: TextSpan(style: TextStyle(fontSize: 18), children: [
                        //     TextSpan(text: 'Patient Note : '),
                        //     (widget.patient.patientInformation != null)
                        //         ? TextSpan(
                        //             text: widget.patient.patientInformation.name)
                        //         : TextSpan(text: '')
                        //   ]),
                        // ),
                      ]),
                  actions: <Widget>[
                    deleteButton(context, action),
                    createButton(context, action, widget.index)
                  ],
                  // backgroundColor: Color(0xFF11249F),
                ),
                body: TabBarView(
                  children: <Widget>[
                    PatientInformationScreen(
                        patient_information: widget.patient.patientInformation),
                    // ),

                    CPRItems(cprLog: widget.patient.cprLog),
                    // CPRTimeLog(),
                    // ),
                    // CPRPage(),

                    // CPRDetail(),
                    VitalSignList(
                        listVitals: widget.patient.vitalSigns,
                        index: widget.index),
                    MainAssessment(
                      patientAssessment: widget.patient.patientAssessment,
                      interventionAssessment: widget.patient.intervention,
                      traumaAssessment: widget.patient.traumaAssessment,
                      medicationAssessment: widget.patient.medicationAssessment,
                      reportingAssessment: widget.patient.incidentReporting,
                      outcomeAssessment: widget.patient.outcome,
                      samplerAssessment: widget.patient.samplerAssessment,
                      otherAssessment: widget.patient.otherAssessment,
                      // context: context
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    // PatInfoProvider(),
    // );
  }

  Widget deleteButton(BuildContext context, action) => FlatButton(
      onPressed: () {
        if (action == Action.delete) {
          patientBloc.add(RemovePatient(index: widget.index));
        }
        Navigator.pop(context);
      },
      child: Text((action == Action.delete) ? "DELETE" : "CANCEL",
          style: TextStyle(color: Colors.white)));
}

class CPRPage extends StatefulWidget {
  _CPRPage createState() => _CPRPage();
}

class _CPRPage extends State<CPRPage> {
  String _selected = "";
  String _cprNote,
      _witnessNote,
      _bystanderNote,
      _dnarNote,
      _startNote,
      _roscNote,
      _stopNote,
      _outcomeNote;
  String _time;

  List<String> _listCPR = new List<String>();
  List<String> _listWitness = new List<String>();
  List<String> _listBystander = new List<String>();
  List<String> _listDNAR = new List<String>();
  List<String> _listStart = new List<String>();
  List<String> _listRosc = new List<String>();
  List<String> _listStop = new List<String>();
  List<String> _listOutcome = new List<String>();

  @override
  void initState() {
    // _listSelected.add("YES");
    super.initState();
  }

  _btnCallback(data, id) {
    print(data);
    if (id == "cprrequired") {
      setState(() {
        _listCPR = List<String>.from(data).toList();
      });
    }
  }

  _onNote(data, id) {
    if (id == "cprrequired") {
      setState(() {
        _cprNote = data;
      });
    }
    if (id == "witnesscpr") {
      setState(() {
        _witnessNote = data;
      });
    }
    if (id == "bystandercpr") {
      setState(() {
        _bystanderNote = data;
      });
    }
    if (id == "dnar") {
      setState(() {
        _dnarNote = data;
      });
    }
    if (id == "cprstart") {
      setState(() {
        _startNote = data;
      });
    }
    if (id == "rosc") {
      setState(() {
        _roscNote = data;
      });
    }
    if (id == "cprstop") {
      setState(() {
        _stopNote = data;
      });
    }
    if (id == "cproutcome") {
      setState(() {
        _outcomeNote = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.blue[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
                title: "CPR Required",
                listButton: ["YES", "NO"],
                listSelected: _listCPR,
                timeSetted: "15/9/2020 12:34",
                noteSetted: _cprNote,
                callback: _btnCallback,
                onNote: _onNote),
          ),
          _listCPR.contains("NO")
              ? Row(
                  children: [
                    Container(width: 100, child: Text("Reason")),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: 300,
                      child: DropdownButtonFormField(
                        value: _selected,
                        onChanged: (selected) {
                          setState(() {
                            _selected = selected;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: "",
                            child: Text(""),
                          ),
                          DropdownMenuItem(
                            value: "Hello",
                            child: Text("Hello"),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
              title: "Witness CPR",
              listButton: ["YES", "NO"],
              listSelected: _listWitness,
              noteSetted: _witnessNote,
              timeSetted: "15/9/2020 12:34",
              onNote: _onNote,
              callback: _btnCallback,
              // noteSetted: "Add patient sick",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
              title: "Bystander CPR",
              listButton: ["YES", "NO"],
              listSelected: _listBystander,
              noteSetted: _bystanderNote,
              timeSetted: "15/9/2020 12:34",
              onNote: _onNote,
              callback: _btnCallback,
              // noteSetted: "Add patient sick",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
              title: "DNAR",
              listButton: ["YES", "NO"],
              listSelected: _listDNAR,
              noteSetted:  _dnarNote,
              timeSetted: "15/9/2020 12:34",
              onNote: _onNote,
              callback: _btnCallback,
              // noteSetted: "Add patient sick",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
              title: "CPR Start",
              listButton: ["YES", "NO"],
              listSelected: _listStart,
              noteSetted: _startNote,
              timeSetted: "15/9/2020 12:34",
              onNote: _onNote,
              callback: _btnCallback,
              // noteSetted: "Add patient sick",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
              title: "ROSC",
              listButton: ["YES", "NO"],
              listSelected: _listRosc,
              noteSetted: _roscNote,
              timeSetted: "15/9/2020 12:34",
              onNote: _onNote,
              callback: _btnCallback,
              // noteSetted: "Add patient sick",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
              title: "CPR Stop",
              listButton: ["YES", "NO"],
              listSelected: _listStop,
              noteSetted: _stopNote,
              timeSetted: "15/9/2020 12:34",
              onNote: _onNote,
              callback: _btnCallback,
              // noteSetted: "Add patient sick",
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 50,
            child: SelectableRow(
              title: "Transported",
              listButton: ["YES", "NO"],
              listSelected: _listOutcome,
              noteSetted: _outcomeNote,
              timeSetted: "15/9/2020 12:34",
              onNote: _onNote,
              callback: _btnCallback,
              // noteSetted: "Add patient sick",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _listOutcome.contains("NO")
              ? Row(
                  children: [
                    Container(width: 100, child: Text("Reason")),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: 300,
                      child: DropdownButtonFormField(
                        value: _selected,
                        onChanged: (selected) {
                          setState(() {
                            _selected = selected;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: "",
                            child: Text(""),
                          ),
                          DropdownMenuItem(
                            value: "Hello",
                            child: Text("Hello"),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

class SelectableRow extends StatefulWidget {
  final title;
  final List<String> listSelected;
  final listButton;
  final timeSetted;
  final noteSetted;
  final Function callback;
  final Function onNote;

  SelectableRow(
      {this.title,
      this.listSelected,
      this.listButton,
      this.timeSetted,
      this.noteSetted,
      this.callback,
      this.onNote});

  _SelectableRow createState() => _SelectableRow();
}

class _SelectableRow extends State<SelectableRow> {
  TextEditingController timeController;
  TextEditingController noteController;
  var timeFormater = MaskTextInputFormatter(
      mask: "##/##/#### ##:##", filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    timeController = TextEditingController(text: widget.timeSetted);
    noteController = TextEditingController(text: widget.noteSetted);
    // timeController.addListener(_timeCallback);
    super.initState();
  }

  // _timeCallback() {

  // }

  @override
  void dispose() {
    timeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(width: 100, child: Text(widget.title)),
      // SizedBox(
      //   width: 100,
      // ),
      Container(
        width: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.listButton.length,
          itemBuilder: (context, idx) {
            return InkWell(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: BoxDecoration(
                    color: widget.listSelected.contains(widget.listButton[idx])
                        ? Colors.blue[500]
                        : Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  widget.listButton[idx],
                  style: TextStyle(
                      color:
                          widget.listSelected.contains(widget.listButton[idx])
                              ? Colors.white
                              : Colors.black),
                ),
              ),
              onTap: () {
                setState(() {
                  // isPressed = !isPressed;
                  if (widget.listSelected.contains(widget.listButton[idx])) {
                    widget.listSelected.remove(widget.listButton[idx]);

                    timeController.text = "";
                  } else {
                    timeController.text =
                        DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now());
                    widget.listSelected.add(widget.listButton[idx]);
                    if (widget.listSelected.length > 1)
                      widget.listSelected.removeLast();
                  }
                });

                print("try to pass back widgetlistselected to parent");
                widget.callback(widget.listSelected,
                    widget.title.replaceAll(' ', '').toLowerCase());
              },
            );
          },
        ),
      ),

      Container(
        width: 150,
        child:
            // ),
            TextField(
          controller: timeController,
          // keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: "dd/MM/yyyy HH:mm"),
        ),
      ),
      Container(
        child: IconButton(
          icon: Icon(
            widget.noteSetted != null ? Icons.receipt : Icons.note_add,
            color: widget.noteSetted != null ? Colors.green : Colors.blue,
          ),
          onPressed: () {
            var id = widget.title.replaceAll(" ", "").toLowerCase();

            showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                      title: new Text(
                        widget.noteSetted != null ? "View note" : "Enter note",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      content: new TextFormField(
                          controller: noteController,
                          // initialValue: widget.noteSetted,
                          style: TextStyle(
                              // fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              letterSpacing: 1.0),
                          // keyboardType:
                          //     TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(hintText: "...")),
                      actions: <Widget>[
                        widget.noteSetted == null
                            ? FlatButton(
                                child: Text('ADD'),
                                onPressed: () {
                                  widget.onNote(noteController.text, id);
                                  Navigator.of(context).pop();
                                },
                              )
                            : FlatButton(
                                child: Text('DELETE'),
                                onPressed: () {
                                  noteController.clear();
                                  widget.onNote(null, id);
                                  Navigator.of(context).pop();
                                },
                              )
                      ],
                    ));
          },
          tooltip: widget.noteSetted != null ? "View note" : "Add note",
        ),
      )
    ]);
    // );
  }
}
