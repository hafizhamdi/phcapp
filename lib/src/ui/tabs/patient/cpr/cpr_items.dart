import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:phcapp/custom/choice_chip.dart';
import 'package:phcapp/custom/header_section.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
import 'package:phcapp/src/ui/tabs/patient/cpr/bloc_cpr.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class CPRItems extends StatefulWidget {
  final CprLog cprLog;

  CPRItems({this.cprLog});
  _CPRItems createState() => _CPRItems();
}

const WITNESS = ["Yes", "No"];
const RHYTHM = ["VF", "Pulseless VT"];
const INTERV = ["Defibrillation"];
const INTEROT = ["Sync-cardioversion", "Pacing"];
const DRUG = ["Adrenaline", "Amiodarone"];
const DRUOT = ["Atropine"];
const AIRWAY = ["BVM", "LMA", "ETT"];
const RHYTHMNS = ["Asystole", "PEA"];
const RHYTHMOT = ["Tachyarythmias", "Bradyarrythmias"];
const ANALYSIS = ["Non-Shockable", "Shockable", "Other"];
const _cpr = ["Required", "Not Required"];
const _cpr_outcome = ["Transported", "Termination of Resusitation (TOR)"];
const _cpr_not_required = [
  "Algor mortis",
  "Livor mortis",
  "Rigor mortis",
  "Decomposition",
  "Injuries incompatible to life - decapitation",
  "Injuries incompatible to life - transection",
  "Injuries incompatible to life - incineration (>95%)",
  "Injuries incompatible to life - infull thickness mortis",
  "Search and rescue drowning",
  "Presence of DNAR order"
];

const transported = [
  "Victim whom DHRT witness bystander CPR",
  "Victim identified with shockable or organized rhythm",
  "Victim with ROSC",
  "Victim with OHCA mimic",
  "Pregnant patient",
  "Paediatric patient",
  "Lighting injury",
  "Drowning (not SAR case)",
  "Hypothermic related injury",
  "Victim with cardiac device (pace maker, ventilator assisted device)",
];

const not_transported = [
  // "Execution of Termination of Resusitation (TOR)",
  "No transport criteria present",
  "No bystander CPR",
  "No prehospital ROSC after 3 cycles of CPR",
  "Persistent asystole for 3 rhythm analysis",
  "Discussion with online medical control on TOR",
  "Obtaining consent from immediate family for TOR"
];

class _CPRItems extends State<CPRItems>
    with AutomaticKeepAliveClientMixin<CPRItems> {
  @override
  bool get wantKeepAlive => true;

// {  // String selected;
  String onShock = "Shockable";
  String onNonShock;
  String onOther;

  Analysis shockable = new Analysis();
  Analysis nonShockable = new Analysis();
  Analysis other = new Analysis();

  String ddCpr;
  String ddCprOutcomeTransported;
  String ddCprOutcomeTOR;

  CPRProvider cprProvider;

  List<RhythmAnalysis> lsRhythm = new List<RhythmAnalysis>();
  CprLog cprLog = new CprLog(
      log: new Log(),
      witnessCpr: new Cpr(),
      bystanderCpr: new Cpr(),
      cprStart: new Cpr(),
      rosc: new Cpr(),
      cprStop: new Cpr(),
      cprOutcome: new CPROutcome());
  String selectWitness;
  String selectBystander;
  String selectCprStart;
  String selectCprStop;
  String selectRosc;
  String selectAnalysis = "Non-Shockable";
  String selectRhythm;
  String selectRhythmNS;
  String selectRhythmO;
  String selectInter;
  String selectInterNS;
  String selectInterO;
  String selectDrug;
  String selectDrugNS;
  String selectDrugO;
  String selectAirway;
  String selectAirwayNS;
  String selectAirwayO;
  TextEditingController witnessController = new TextEditingController();
  TextEditingController bystanderController = new TextEditingController();
  TextEditingController cprStartController = new TextEditingController();
  TextEditingController cprStopController = new TextEditingController();
  TextEditingController roscController = new TextEditingController();
  TextEditingController rhythmController = new TextEditingController();
  TextEditingController rhythmNoteController = new TextEditingController();
  TextEditingController rhythmNSController = new TextEditingController();
  TextEditingController rhythmNSnoteController = new TextEditingController();
  TextEditingController rhythmOController = new TextEditingController();
  TextEditingController rhythmOnoteController = new TextEditingController();
  TextEditingController intervController = new TextEditingController();
  TextEditingController intervNoteController = new TextEditingController();
  TextEditingController intervNSController = new TextEditingController();
  TextEditingController intervNSnoteController = new TextEditingController();
  TextEditingController intervOController = new TextEditingController();
  TextEditingController intervOnoteController = new TextEditingController();
  TextEditingController drugController = new TextEditingController();
  TextEditingController drugNoteController = new TextEditingController();
  TextEditingController drugNSController = new TextEditingController();
  TextEditingController drugNSnoteController = new TextEditingController();
  TextEditingController drugOController = new TextEditingController();
  TextEditingController drugOnoteController = new TextEditingController();
  TextEditingController airwayController = new TextEditingController();
  TextEditingController airwayNoteController = new TextEditingController();
  TextEditingController airwayNSController = new TextEditingController();
  TextEditingController airwayNSnoteController = new TextEditingController();
  TextEditingController airwayOController = new TextEditingController();
  TextEditingController airwayOnoteController = new TextEditingController();

  CprBloc cprBloc;
  getCurrentTime() {
    return DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now());
  }

  @override
  void dispose() {
    witnessController.dispose();
    bystanderController.dispose();
    cprStartController.dispose();
    cprStopController.dispose();
    roscController.dispose();
    rhythmController.dispose();
    rhythmNoteController.dispose();
    rhythmNSController.dispose();
    rhythmNSnoteController.dispose();
    rhythmOController.dispose();
    rhythmOnoteController.dispose();
    intervController.dispose();
    intervNoteController.dispose();
    intervNSController.dispose();
    intervNSnoteController.dispose();
    intervOController.dispose();
    intervOnoteController.dispose();
    drugController.dispose();
    drugNoteController.dispose();
    drugNSController.dispose();
    drugNSnoteController.dispose();
    drugOController.dispose();
    drugOnoteController.dispose();
    airwayController.dispose();
    airwayNoteController.dispose();
    airwayNSController.dispose();
    airwayNSnoteController.dispose();
    airwayOController.dispose();
    airwayOnoteController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    cprBloc = BlocProvider.of<CprBloc>(context);
    // cprBloc.add(LoadCpr(cprLog: ))

    print("DID CHANGE DEPENDENCIES CPR ITEMS LOGS");
    // check global state if empty try get from widget
    if (cprBloc.state.cprLog != null) {
      // print("cprBlocstate not empty");

      final stateCpr = cprBloc.state.cprLog;
      setState(() {
        witnessController.text =
            stateCpr.witnessCpr != null ? stateCpr.witnessCpr.timestamp : '';
        bystanderController.text = stateCpr.bystanderCpr != null
            ? stateCpr.bystanderCpr.timestamp
            : '';
        cprStartController.text =
            stateCpr.cprStart != null ? stateCpr.cprStart.timestamp : '';
        cprStopController.text =
            stateCpr.cprStop != null ? stateCpr.cprStop.timestamp : '';
        roscController.text =
            stateCpr.rosc != null ? stateCpr.rosc.timestamp : '';

        // cprLog = new CprLog(
        //     cprStart: stateCpr.cprStart,
        //     witnessCpr: stateCpr.witnessCpr,
        //     bystanderCpr: stateCpr.bystanderCpr,
        //     cprStop: stateCpr.cprStop,
        //     rosc: stateCpr.rosc);
      });
    }
    //   // if widget not empty, load it
    //   if (widget.cprLog != null) {
    //     cprBloc.add(
    //       LoadCpr(
    //           cprLog: CprLog(
    //               witnessCpr: widget.cprLog.witnessCpr,
    //               bystanderCpr: widget.cprLog.bystanderCpr,
    //               cprStart: widget.cprLog.cprStart,
    //               rosc: widget.cprLog.rosc,
    //               cprStop: widget.cprLog.cprStop,
    //               rhythmAnalysis: widget.cprLog.rhythmAnalysis)
    //           // widget.cprLog),
    //           ),
    //     );
    //   } else {
    //     // if widget also empty, then initialize global state
    //     cprBloc.add(
    //       LoadCpr(
    //         cprLog: new CprLog(
    //             witnessCpr: new Cpr(),
    //             bystanderCpr: new Cpr(),
    //             cprStart: new Cpr(),
    //             cprStop: new Cpr(),
    //             rosc: new Cpr(),
    //             rhythmAnalysis: []),
    //       ),
    //     );
    //   }
    // }

    //   print(widget.cprLog.toJson());
    //   print("CPR is not empty");
    // } else {
    //   print("widget cpr log empty so initialize zero");
    // }

    // cprBloc.add(LoadCpr());
  }

  void buttonCallback(id, valueSelected) {
    print("button callback");
    final temp = Cpr(value: valueSelected, timestamp: getCurrentTime());
    if (id == "witness_cpr") {
      setState(() {
        cprBloc.add(AddCpr(cpr: temp, id: "witness_cpr"));
        cprLog.witnessCpr = temp;
        // cprBloc.cprLog.witnessCpr = temp;
      });
    }
    if (id == "bystander_cpr") {
      setState(() {
        cprBloc.add(AddCpr(cpr: temp, id: "bystander_cpr"));
        cprLog.bystanderCpr = temp;
      });
    }
    if (id == "cpr_start") {
      setState(() {
        cprBloc.add(AddCpr(cpr: temp, id: "cpr_start"));
        cprLog.cprStart = temp;
      });
    }
    if (id == "rosc") {
      setState(() {
        cprBloc.add(AddCpr(cpr: temp, id: "rosc"));
        cprLog.rosc = temp;
      });
    }
    if (id == "cpr_stop") {
      setState(() {
        cprBloc.add(AddCpr(cpr: temp, id: "cpr_stop"));
        cprLog.cprStop = temp;
      });
    }

    if (id == "srhythm") {
      setState(() {
        // cprBloc.add(AddCpr(cpr: temp, id: "srhythm", rhythm_type: "Shockable"));
        shockable.rhythm = temp;
      });
    }
    if (id == "sdrugs") {
      setState(() {
// cprBloc.add(AddCpr(cpr: temp, id: "witness_cpr"));
        shockable.drugs = temp;
      });
    }
    if (id == "sinterv") {
      setState(() {
        shockable.intervention = temp;
      });
    }
    if (id == "sairway") {
      setState(() {
        shockable.airway = temp;
      });
    }
    if (id == "nsrhythm") {
      setState(() {
        nonShockable.rhythm = temp;
      });
    }
    if (id == "nsdrugs") {
      setState(() {
        nonShockable.drugs = temp;
      });
    }
    if (id == "nsairway") {
      setState(() {
        nonShockable.airway = temp;
      });
    }
    if (id == "oairway") {
      setState(() {
        other.airway = temp;
      });
    }
    if (id == "orhythm") {
      setState(() {
        other.rhythm = temp;
      });
    }
    if (id == "ointerv") {
      setState(() {
        other.intervention = temp;
      });
    }
    if (id == "odrugs") {
      setState(() {
        other.drugs = temp;
      });
    }
  }

  List<String> cprList = new List<String>();

  List<String> cprOutcomeList = new List<String>();

  void callback(String item, List<String> selectedItems) {
    print("callback");

    if (item == "CPR") {
      final tempLog = Log(
          value: selectedItems,
          reason: widget.cprLog != null
              ? widget.cprLog.log != null ? widget.cprLog.log.reason : ''
              : '');
      setState(() {
        cprBloc.add(AddCpr(log: tempLog, id: "log_in_cpr"));
        cprLog.log = tempLog;

        cprList = selectedItems;
      });
    }

    if (item == "CPR Outcome") {
      final tempCPROutcome = CPROutcome(
          value: selectedItems,
          transported: widget.cprLog != null
              ? widget.cprLog.cprOutcome != null
                  ? widget.cprLog.cprOutcome.transported
                  : ''
              : '',
          tor: widget.cprLog != null
              ? widget.cprLog.cprOutcome != null
                  ? widget.cprLog.cprOutcome.tor
                  : ''
              : '');
      setState(() {
        cprBloc.add(AddCpr(cprOutcome: tempCPROutcome, id: "cpr_outcome"));
        cprLog.cprOutcome = tempCPROutcome;

        cprOutcomeList = selectedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    cprBloc = BlocProvider.of<CprBloc>(context);

    return Scaffold(
      body: Container(
        // width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),
            ],
          ),
        ),
        // padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                margin:
                    EdgeInsets.only(left: 12.0, right: 12, top: 40, bottom: 12),
                // child: SingleChildScrollView(
                child:
                    BlocBuilder<CprBloc, CprState>(builder: (context, state) {
                  // print("is it widget got cprlog?");

                  if (state is CprEmpty) {
                    print("Yes im cpremmpty");
                    // if (widget.cprLog != null) {
                    //   print("there is existing cprlog");
                    //   cprBloc.add(
                    //     LoadCpr(
                    //         cprLog: CprLog(
                    //             witnessCpr: widget.cprLog.witnessCpr,
                    //             bystanderCpr: widget.cprLog.bystanderCpr,
                    //             cprStart: widget.cprLog.cprStart,
                    //             rosc: widget.cprLog.rosc,
                    //             cprStop: widget.cprLog.cprStop,
                    //             rhythmAnalysis: widget.cprLog.rhythmAnalysis)
                    //         // widget.cprLog),
                    //         ),
                    //   );
                    // }
                    // } else {
                    //   print("nothing is exist cprlog");
                    //   cprBloc.add(
                    //     LoadCpr(
                    //       cprLog: new CprLog(
                    //           witnessCpr: new Cpr(),
                    //           bystanderCpr: new Cpr(),
                    //           cprStart: new Cpr(),
                    //           cprStop: new Cpr(),
                    //           rosc: new Cpr(),
                    //           rhythmAnalysis: []),
                    //     ),
                    //   );
                    // }
                  }
                  // print(widget.cprLog);
                  // } else
                  else if (state is CprLoaded) {
                    print("CPRLOADED");
                    print(state.cprLog.witnessCpr.toJson());
                    // final stateCpr = state.cprLog;
                    // witnessController.text = stateCpr.witnessCpr != null
                    //     ? stateCpr.witnessCpr.timestamp
                    //     : 'HELLO';
                    // bystanderController.text = stateCpr.bystanderCpr != null
                    //     ? stateCpr.bystanderCpr.timestamp
                    //     : '';
                    // cprStartController.text = stateCpr.cprStart != null
                    //     ? stateCpr.cprStart.timestamp
                    //     : '';
                    // cprStopController.text =
                    //     stateCpr.cprStop != null ? stateCpr.cprStop.timestamp : '';
                    // roscController.text =
                    //     stateCpr.rosc != null ? stateCpr.rosc.timestamp : '';

                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          HeaderSection("CPR Log"),

                          _defaultChips(
                              "CPR",
                              _cpr,
                              _cpr_not_required,
                              callback,
                              state.cprLog.log != null
                                  ? state.cprLog.log.value
                                  : cprList,
                              state.cprLog.log != null
                                  ? state.cprLog.log.reason
                                  : ''),
                          // FlatButton.icon(
                          //   icon: Icon(Icons.remove_red_eye),
                          //   label: Text("VIEW LOG HISTORY"),
                          //   onPressed: () {
                          //     print("View log is pressed!");
                          //     cprBloc.add(PressViewLog());
                          //     Navigator.pop(context);
                          //   },
                          // ),
                          BuildChoiceChip(
                            id: "witness_cpr",
                            listData: WITNESS,
                            selectData: state.cprLog.witnessCpr != null
                                ? state.cprLog.witnessCpr.value
                                : '',
                            txtController: witnessController,
                            callback: buttonCallback,
                          ),
                          BuildChoiceChip(
                            // context,
                            id: "bystander_cpr",
                            listData: WITNESS,
                            selectData: state.cprLog.bystanderCpr != null
                                ? state.cprLog.bystanderCpr.value
                                : '',
                            txtController: bystanderController,
                            callback: buttonCallback,
                          ),
                          BuildChoiceChip(
                            // context,
                            id: "cpr_start",
                            listData: WITNESS,
                            selectData: state.cprLog.cprStart != null
                                ? state.cprLog.cprStart.value
                                : '',
                            txtController: cprStartController,
                            callback: buttonCallback,
                          ),
                          _buildAddCycle(),
                          _buildCounterRhythm(),
                          BuildChoiceChip(
                            // context,
                            id: "rosc",
                            listData: WITNESS,
                            selectData: state.cprLog.rosc != null
                                ? state.cprLog.rosc.value
                                : '',
                            txtController: roscController,
                            callback: buttonCallback,
                          ),
                          BuildChoiceChip(
                            // context,
                            id: "cpr_stop",
                            listData: WITNESS,
                            selectData: state.cprLog.cprStop != null
                                ? state.cprLog.cprStop.value
                                : '',
                            txtController: cprStopController,
                            callback: buttonCallback,
                          ),

                          _cprOutcomeChips(
                              "CPR Outcome",
                              _cpr_outcome,
                              callback,
                              state.cprLog.cprOutcome != null
                                  ? state.cprLog.cprOutcome.value
                                  : cprOutcomeList,
                              state.cprLog.cprOutcome != null
                                  ? state.cprLog.cprOutcome.transported
                                  : null,
                              state.cprLog.cprOutcome != null
                                  ? state.cprLog.cprOutcome.tor
                                  : null),
                        ],
                      ),
                    );
                  }

                  // }

                  // ,)
                  return Container(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // FlatButton.icon(
                        //   icon: Icon(Icons.remove_red_eye),
                        //   label: Text("VIEW LOG HISTORY"),
                        //   onPressed: () {
                        //     Navigator.pop(context);
                        //   },
                        // ),
                        SingleChildScrollView
                            // ScrollChildView(
                            (
                          child: BuildChoiceChip(
                            id: "witness_cpr",
                            listData: WITNESS,
                            selectData: cprLog.witnessCpr.value,
                            txtController: witnessController,
                            callback: buttonCallback,
                          ),
                        ),
                        SingleChildScrollView(
                          child: BuildChoiceChip(
                            // context,
                            id: "bystander_cpr",
                            listData: WITNESS,
                            selectData: cprLog.bystanderCpr.value,
                            txtController: bystanderController,
                            callback: buttonCallback,
                          ),
                        ),
                        BuildChoiceChip(
                          // context,
                          id: "cpr_start",
                          listData: WITNESS,
                          selectData: cprLog.cprStart.value,
                          txtController: cprStartController,
                          callback: buttonCallback,
                        ),
                        _buildAddCycle(),
                        _buildCounterRhythm(),
                        BuildChoiceChip(
                          // context,
                          id: "rosc",
                          listData: WITNESS,
                          selectData: cprLog.rosc.value,
                          txtController: roscController,
                          callback: buttonCallback,
                        ),
                        BuildChoiceChip(
                          // context,
                          id: "cpr_stop",
                          listData: WITNESS,
                          selectData: cprLog.cprStop.value,
                          txtController: cprStopController,
                          callback: buttonCallback,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // onSelected(context, id, value) {
  //   //get cprstart button click state
  //   if (id == "cpr_start") {
  //     print("cpr pressed");
  //     print("what the value now " + value);
  //   }

  //   final cprProvider = Provider.of<CPRProvider>(context, listen: false);

  //   cprProvider.updateValue(id, value);

  //   var item = cprProvider.itemModels
  //       .firstWhere((f) => f.id == id, orElse: () => null);
  //   // ItemModel item = getValue(context, id);

  //   if (value != null) {
  //     String format =
  //         DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
  //             " -- " +
  //             item.name +
  //             " " +
  //             value;

  //     // cprProvider.addLog(format);
  //     confirmAddLog(context, cprProvider, format);
  //   }
  // }

  addRhythmDialog(RhythmAnalysis rhythmAnalysis, index) {
    setState(() {
      selectAnalysis = "Non-Shockable";
    });
    showDialog(
      context: context,
      // builder: (context, <LogModel> logs, child) {
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                  child: _buildAnalysis(rhythmAnalysis, setState, index)
                  // ),
                  ),
            );
          }),
        );
      },
    );
  }

  _buildCounterRhythm() {
    // final provider = Provider.of<CPRProvider>(context);
    return BlocConsumer<CprBloc, CprState>(
      listener: (context, state) {},
      builder: (context, state) {
        // if (state is CprEmpty) {
        // cprBloc.add(
        //   LoadCpr(
        //     cprLog: CprLog(
        //       witnessCpr: new Cpr(),
        //     ),
        //   ),
        // );
        // } else
        if (state is CprLoaded) {
          return SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.cprLog.rhythmAnalysis != null
                  ? state.cprLog.rhythmAnalysis.length
                  : 0,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      width: 60,
                      height: 60,
                      decoration: new BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                    Text(
                      state.cprLog.rhythmAnalysis[index].timestamp != null
                          ? DateFormat("h:mm aa").format(
                              state.cprLog.rhythmAnalysis[index].timestamp)
                          : '',
                    )
                  ]),
                  onTap: () {
                    addRhythmDialog(
                        new RhythmAnalysis(
                            id: index.toString(),
                            rhythm: state.cprLog.rhythmAnalysis[index].rhythm,
                            shockable:
                                state.cprLog.rhythmAnalysis[index].shockable,
                            nonShockable:
                                state.cprLog.rhythmAnalysis[index].nonShockable,
                            other: state.cprLog.rhythmAnalysis[index].other),
                        index);
                  },
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }

  _buildAddCycle() {
    // final provider = Provider.of<CPRProvider>(context);

    cprBloc = BlocProvider.of<CprBloc>(context);
    return Padding(
        padding: EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Rhythm Analysis: "
              //  +
              //     (cprBloc.state.cprLog != null
              //         ? cprBloc.state.cprLog.rhythmAnalysis.length.toString()
              //         : "0"
              // ),
              ),
          RaisedButton.icon(
            label: Text("Add Rhythm Analysis"),
            icon: Icon(Icons.add),
            onPressed: () {
              shockable = new Analysis();
              nonShockable = new Analysis();
              other = new Analysis();

              rhythmController.clear();
              intervController.clear();
              drugController.clear();
              airwayController.clear();

              rhythmNSController.clear();
              intervNSController.clear();
              drugNSController.clear();
              airwayNSController.clear();

              rhythmOController.clear();
              intervOController.clear();
              drugOController.clear();
              airwayOController.clear();
              addRhythmDialog(
                  new RhythmAnalysis(
                      // rhythm: ,
                      shockable: shockable,
                      nonShockable: nonShockable,
                      other: other),
                  null);

              // setState(() {
              //   selectAnalysis = "";
              // });
            },
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              // side: BorderSide(color: Colors.red)
            ),
            // clipBehavior: Clip.hardEdge,
          )
        ]));
  }

  _defaultChips(header, List<String> list, List<String> dropdownList, callback,
      initialData, String dropDownInitialData) {
    StreamController<String> dropDownController =
        new StreamController.broadcast();

    return Container(
      // width: 500,
      margin: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
            title: Padding(
              child: Text(header),
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
            subtitle:
                //  Wrap(
                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SingleOption(
                  header: header,
                  stateList: list,
                  callback: callback,
                  multiple: false,
                  initialData: initialData),
              initialData != null
                  ? initialData.contains("Not Required")
                      ? Container(
                          // width: 250,
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: StreamBuilder<Object>(
                                stream: dropDownController.stream
                                    .asBroadcastStream(),
                                initialData: dropDownInitialData,
                                builder: (context, snapshot) {
                                  return DropdownButtonFormField(
                                    isExpanded: true,
                                    // isDense: true,
                                    items: dropdownList
                                        .map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                          child: Text(dropDownStringItem),
                                          value: dropDownStringItem);
                                    }).toList(),
                                    onChanged: (valueChanged) {
                                      final tempLog = Log(
                                          value: initialData,
                                          reason: valueChanged);

                                      setState(() {
                                        cprBloc.add(AddCpr(
                                            log: tempLog, id: "log_in_cpr"));
                                        cprLog.log = tempLog;
                                        dropDownController.sink
                                            .add(valueChanged);
                                      });

                                      print("WHATS IS INDESIDE:$valueChanged");
                                    },
                                    value: _cpr_not_required
                                            .contains(snapshot.data)
                                        ? snapshot.data
                                        : null,
                                    decoration: InputDecoration(
                                      // labelText: labelText,
                                      fillColor: Colors.white,
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(10.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Container()
                  : Container(),

            ])
            // ],
            ),
      ),
    );
  }

  _cprOutcomeChips(header, List<String> list, callback, initialData,
      transportInitial, torInitial) {
    StreamController<String> transportedController =
        new StreamController.broadcast();
    StreamController<String> torController = new StreamController.broadcast();

    return Container(
      // width: 500,
      margin: EdgeInsets.all(10),
      child: Card(
        child: ListTile(
            title: Padding(
              child: Text(header),
              padding: EdgeInsets.symmetric(vertical: 10.0),
            ),
            subtitle:
                //  Wrap(
                //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SingleOption(
                  header: header,
                  stateList: list,
                  callback: callback,
                  multiple: false,
                  initialData: initialData),
              initialData != null
                  ? initialData.contains("Transported")
                      ? StreamBuilder<Object>(
                          stream:
                              transportedController.stream.asBroadcastStream(),
                          initialData: transportInitial,
                          builder: (context, snapshot) {
                            return Container(
                              // width: 250,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: DropdownButtonFormField(
                                  isExpanded: true,
                                  // isDense: true,
                                  items: transported
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        child: Text(dropDownStringItem),
                                        value: dropDownStringItem);
                                  }).toList(),
                                  onChanged: (valueChanged) {
                                    final tempCprOutcome = CPROutcome(
                                        value: initialData,
                                        transported: valueChanged,
                                        tor: torInitial);

                                    setState(() {
                                      cprBloc.add(AddCpr(
                                          cprOutcome: tempCprOutcome,
                                          id: "cpr_outcome"));
                                      cprLog.cprOutcome = tempCprOutcome;
                                      transportedController.sink
                                          .add(valueChanged);
                                    });
                                    // print("WHATS IS INDESIDE:$valueChanged");
                                    // controller.sink.add(valueChanged);
                                  },
                                  value: transported.contains(snapshot.data)
                                      ? snapshot.data
                                      : null,
                                  decoration: InputDecoration(
                                    // labelText: labelText,
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : Container()
                  : Container(),
              initialData != null
                  ? initialData.contains("Termination of Resusitation (TOR)")
                      ? StreamBuilder<Object>(
                          stream: torController.stream.asBroadcastStream(),
                          initialData: torInitial,
                          builder: (context, snapshot) {
                            return Container(
                              // width: 250,
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: DropdownButtonFormField(
                                  // isDense: true,
                                  isExpanded: true,
                                  items: not_transported
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        child: Text(dropDownStringItem),
                                        value: dropDownStringItem);
                                  }).toList(),
                                  onChanged: (valueChanged) {
                                    final tempCprOutcome = CPROutcome(
                                        value: initialData,
                                        transported: transportInitial,
                                        tor: valueChanged);
                                    setState(() {
                                      cprBloc.add(AddCpr(
                                          cprOutcome: tempCprOutcome,
                                          id: "cpr_outcome"));
                                      cprLog.cprOutcome = tempCprOutcome;
                                      torController.sink.add(valueChanged);
                                    });
                                    // print("WHATS IS INDESIDE:$valueChanged");
                                    // controller.sink.add(valueChanged);
                                  },
                                  value: not_transported.contains(snapshot.data)
                                      ? snapshot.data
                                      : null,
                                  decoration: InputDecoration(
                                    // labelText: labelText,
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : Container()
                  : Container(),
            ])
            // ],
            ),
      ),
    );
  }

  _buildAnalysis(RhythmAnalysis rhythmAnalysis, Function setState, index) {
    // final provider = Provider.of<CPRProvider>(context);
    final timeCreated = DateTime.now();
<<<<<<< HEAD
    print("rhythm");
    print(rhythmAnalysis.rhythm);
<<<<<<< HEAD
    selectAnalysis != null ? selectAnalysis = selectAnalysis : selectAnalysis = rhythmAnalysis.rhythm;
=======
    selectAnalysis != null
        ? selectAnalysis = selectAnalysis
        : selectAnalysis = rhythmAnalysis.rhythm;
>>>>>>> 9a5e4ac3dde5c0a236b8faacc1aa2ad626ee5f49
=======
    // print("rhythm");
    // print(rhythmAnalysis.rhythm);

    // setState(() {
    //   selectAnalysis != null
    //       ? selectAnalysis = selectAnalysis
    //       : selectAnalysis = rhythmAnalysis.rhythm;
    // });
>>>>>>> 52a1e419eb78cb1b88c4382f1f3a62a082ed9650

    return Container(
      // padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "Rhythm Analysis",
            style: TextStyle(letterSpacing: 2.0, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Wrap(
            children: List<Widget>.generate(ANALYSIS.length, (index) {
              return Padding(
                padding: EdgeInsets.only(right: 20),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(ANALYSIS[index]),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: ANALYSIS[index] == selectAnalysis
                                ? Colors.pinkAccent
                                : Colors.transparent,
                            width: 3),
                      ),
                    ),
                  )
                  // ChoiceChip(
                  //   pressElevation: 5.0,
                  //   elevation: 2.0,
                  //   key: UniqueKey(),
                  //   label: Text(ANALYSIS[index]),
                  //   selected: ANALYSIS[index] == selectAnalysis,
                  //   onSelected: (bool selected) {
                  //     setState(() {
                  //       selectAnalysis = ANALYSIS[index];
                  //     });
                  //   },
                  //   selectedColor: Colors.pink[200],
                  ,
                  onTap: () {
                    setState(() {
                      selectAnalysis = ANALYSIS[index];
                    });
                  },
                ),
              );
            }),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          (selectAnalysis != null && selectAnalysis == "Shockable")
              ? _buildShockable(rhythmAnalysis.shockable, setState)
              : (selectAnalysis != null && selectAnalysis == "Non-Shockable")
                  ? _buildNonShockable(rhythmAnalysis.nonShockable, setState)
                  : (selectAnalysis != null && selectAnalysis == "Other")
                      ? _buildOther(rhythmAnalysis.other, setState)
                      : Container(),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              (index != null)
                  ? RaisedButton(
                      child: Text("DELETE"),
                      onPressed: () {
                        print("Im pressed!");

                        setState(() {
                          cprBloc.add(RemoveRhythmAnalysis(index: index));
                        });

                        Navigator.pop(context);
                      },
                    )
                  : RaisedButton(
                      child: Text("CANCEL"),
                      onPressed: () {
                        // print("Im pressed!");

                        // setState(() {
                        //   cprBloc.add(RemoveRhythmAnalysis(index: index));
                        // });

                        Navigator.pop(context);
                      },
                    ),
              SizedBox(
                width: 20,
              ),
              (index == null)
                  ? RaisedButton.icon(
                      icon: Icon(Icons.add),
                      // shape: ,
                      color: Colors.green,
                      label: Text("ADD"),
                      onPressed: () {
                        print("Im pressed!");

                        // print(shockable.toJson());
                        // print(nonShockable.toJson());
                        // print(other.toJson());
                        print(selectAnalysis);

                        setState(() {
                          cprBloc.add(
                            AddRhythmAnalysis(
                              rhythmAnalysis: RhythmAnalysis(
                                  id: index.toString(),
                                  timestamp: timeCreated,
                                  rhythm: selectAnalysis,
                                  shockable: shockable,
                                  nonShockable: nonShockable,
                                  other: other),
                            ),
                          );
                          // shockable = new Analysis();
                          // nonShockable = new Analysis();
                          // other = new Analysis();
                        });

                        //restate
                        //     // setState(() {});
                        //     setState(() {
                        //   selectAnalysis = "Non-Shockable";
                        // });

                        Navigator.pop(context);
                      },
                    )
                  : RaisedButton.icon(
                      icon: Icon(Icons.add),
                      // shape: ,
                      color: Colors.blue,
                      label: Text("UPDATE"),
                      onPressed: () {
                        setState(() {
                          cprBloc.add(
                            UpdateRhythmAnalysis(
                                rhythmAnalysis: RhythmAnalysis(
                                    id: index.toString(),
                                    timestamp: timeCreated,
                                    rhythm: selectAnalysis,
                                    shockable: shockable,
                                    nonShockable: nonShockable,
                                    other: other),
                                index: index),
                          );
                          // shockable = new Analysis();
                          // nonShockable = new Analysis();
                          // other = new Analysis();
                        });

                        //restate
                        // setState(() {
                        //   selectAnalysis = "Shockable";
                        // });

                        Navigator.pop(context);
                      },
                    )
            ],
          )
        ],
      ),
    );
  }

  _buildShockable(Analysis myshockable, setState) {
    setState(() {
      if (myshockable != null) {
        rhythmController.text =
            myshockable.rhythm != null ? myshockable.rhythm.timestamp : '';
        intervController.text = myshockable.intervention != null
            ? myshockable.intervention.timestamp
            : '';
        drugController.text =
            myshockable.drugs != null ? myshockable.drugs.timestamp : '';
        airwayController.text =
            myshockable.airway != null ? myshockable.airway.timestamp : '';
      }
      // shockable = myshockable;
    });
    // final provider = Provider.of<CPRProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          BuildChoiceAnalysis(
            setState: setState,
            id: "srhythm",
            listData: RHYTHM,
            selectData:
                myshockable.rhythm != null ? myshockable.rhythm.value : null,
            txtController: rhythmController,
            noteController: rhythmNoteController,
            callback: buttonCallback,
          ),
          BuildChoiceAnalysis(
            setState: setState,
            id: "sinterv",
            listData: INTERV,
            selectData: myshockable.intervention != null
                ? myshockable.intervention.value
                : null,
            txtController: intervController,
            noteController: intervNoteController,
            callback: buttonCallback,

            // setState
          ),
          BuildChoiceAnalysis(
            setState: setState,
            // context,
            id: "sdrugs",
            listData: DRUG,
            selectData:
                myshockable.drugs != null ? myshockable.drugs.value : null,
            txtController: drugController,
            noteController: drugNoteController,
            callback: buttonCallback,
            // setState
          ),
          BuildChoiceAnalysis(
            setState: setState,
            // context,
            id: "sairway",
            listData: AIRWAY,
            callback: buttonCallback,
            // selectData: selectAirway,
            selectData:
                myshockable.airway != null ? myshockable.airway.value : null,
            txtController: airwayController,
            noteController: airwayNoteController,
            // setState
          ),
        ],
      ),
    );
  }

  _buildNonShockable(Analysis mynonShock, setState) {
    // final provider = Provider.of<CPRProvider>(context);
    setState(() {
      // nonShockable = mynonShock;
      if (mynonShock != null) {
        rhythmNSController.text =
            mynonShock.rhythm != null ? mynonShock.rhythm.timestamp : '';
        drugNSController.text =
            mynonShock.drugs != null ? mynonShock.drugs.timestamp : '';
        airwayNSController.text =
            mynonShock.airway != null ? mynonShock.airway.timestamp : '';
      }
    });
    return Container(
      child: Column(
        children: <Widget>[
          BuildChoiceAnalysis(
              // context,
              id: "nsrhythm",
              listData: RHYTHMNS,
              selectData:
                  mynonShock.rhythm != null ? mynonShock.rhythm.value : null,
              txtController: rhythmNSController,
              noteController: rhythmNSnoteController,
              callback: buttonCallback,
              setState: setState),
          BuildChoiceAnalysis(
              // context,
              id: "nsdrugs",
              listData: DRUG,
              selectData:
                  mynonShock.drugs != null ? mynonShock.drugs.value : null,
              txtController: drugNSController,
              noteController: drugNSnoteController,
              callback: buttonCallback,
              setState: setState
              // setState
              ),
          BuildChoiceAnalysis(
              // context,
              id: "nsairway",
              listData: AIRWAY,
              selectData:
                  mynonShock.airway != null ? mynonShock.airway.value : null,
              txtController: airwayNSController,
              noteController: airwayNSnoteController,
              callback: buttonCallback,
              setState: setState
              // setState
              ),
        ],
      ),
    );
  }

  _buildOther(Analysis myother, setState) {
    setState(() {
      // other = myother;
      if (myother != null) {
        rhythmOController.text =
            myother.rhythm != null ? myother.rhythm.timestamp : '';
        intervOController.text =
            myother.intervention != null ? myother.intervention.timestamp : '';
        drugOController.text =
            myother.drugs != null ? myother.drugs.timestamp : '';
        airwayOController.text =
            myother.airway != null ? myother.airway.timestamp : '';
      }
    });
    // final provider = Provider.of<CPRProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          BuildChoiceAnalysis(
              // context,
              id: "orhythm",
              listData: RHYTHMOT,
              selectData: myother.rhythm != null ? myother.rhythm.value : null,
              txtController: rhythmOController,
              noteController: rhythmOnoteController,
              callback: buttonCallback,
              setState: setState),
          // ),
          BuildChoiceAnalysis(
              // context,
              id: "ointerv",
              listData: INTEROT,
              selectData: myother.intervention != null
                  ? myother.intervention.value
                  : null,
              txtController: intervOController,
              noteController: intervOnoteController,
              callback: buttonCallback,
              setState: setState

              // setState
              // ),
              ),
          BuildChoiceAnalysis(
              // context,
              id: "odrugs",
              listData: DRUG,
              selectData: myother.drugs != null ? myother.drugs.value : null,
              txtController: drugOController,
              noteController: drugOnoteController,
              callback: buttonCallback,
              setState: setState

              // setState
              // ),
              ),
          BuildChoiceAnalysis(
              // context,

              id: "oairway",
              listData: AIRWAY,
              selectData: myother.airway != null ? myother.airway.value : null,
              txtController: airwayOController,
              noteController: airwayOnoteController,
              callback: buttonCallback,
              setState: setState

              // setState
              ),
          // )
        ],
      ),
    );
  }
}

class BuildChoiceChip extends StatelessWidget {
  final id;
  final listData;
  final selectData;
  final txtController;
  final noteController;
  final Function callback;
  // final Function setState;

  BuildChoiceChip(
      {this.id,
      this.listData,
      this.selectData,
      this.txtController,
      this.callback,
      this.noteController
      // this.setState
      });
  String selectWitness;

  getCurrentTime() {
    return DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    ItemModel item = getItem(context, id);

    print("INCHOICE CHIP______");
    print(selectData);
    return Padding(
      padding: EdgeInsets.all(10),
      // child: Expanded(
      // child: SingleChildScrollView(
      //   scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(item.name),
              width: 100,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      children: List<Widget>.generate(listData.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            pressElevation: 5.0,
                            elevation: 2.0,
                            key: UniqueKey(),
                            label: Text(listData[index]),
                            selected: listData[index] == (selectData ?? ''),
                            onSelected: (bool selected) {
                              print("IN CHOICE CHIPS");
                              print(selected);
                              // setState(() {
                              txtController.text = getCurrentTime();
                              // });
                              callback(id, listData[index]);
                            },
                            selectedColor: Colors.pink[200],
                          ),
                        );
                      }),
                    ),
                    Container(
                      width: 170,
                      child: TextField(controller: txtController),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 170,
                      child: TextField(
                        controller: noteController,
                        decoration: InputDecoration(hintText: "Notes"),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
      // ),
      // ),
    );
  }

  ItemModel getItem(context, id) {
    var myProvider = Provider.of<CPRProvider>(context);
    var result =
        myProvider.itemModels.firstWhere((f) => f.id == id, orElse: () => null);

    if (result == null)
      return null;
    else
      return result;
  }
}

class BuildChoiceAnalysis extends StatelessWidget {
  final id;
  final listData;
  final selectData;
  final txtController;
  final noteController;
  final Function callback;
  final Function setState;

  BuildChoiceAnalysis(
      {this.id,
      this.listData,
      this.selectData,
      this.txtController,
      this.noteController,
      this.callback,
      this.setState});
  String selectWitness;

  getCurrentTime() {
    return DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now());
  }

  var timestampFormater = MaskTextInputFormatter(
      mask: "##/##/#### ##:##:## -- ", filter: {"#": RegExp(r'[a-zA-Z0-9]')});

  @override
  Widget build(BuildContext context) {
    print("selectData====={$selectData}");
    ItemModel item = getItem(context, id);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(width: 100, child: Text(item.name)),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      children: List<Widget>.generate(
                        listData.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: ChoiceChip(
                              pressElevation: 5.0,
                              elevation: 2.0,
                              key: UniqueKey(),
                              label: Text(listData[index]),
                              selected: listData[index] == (selectData ?? ''),
                              onSelected: (bool selected) {
                                setState(() {
                                  txtController.text = getCurrentTime();
                                });
                                callback(id, listData[index]);
                              },
                              selectedColor: Colors.pink[200],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 170,
                      child: TextField(
                        controller: txtController,
                        // inputFormatters: [timestampFormater],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 170,
                      child: TextField(
                        controller: noteController,
                        decoration: InputDecoration(hintText: "Notes"),

                        // controller: noteController
                        // inputFormatters: [timestampFormater],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
    );
  }

  ItemModel getItem(context, id) {
    var myProvider = Provider.of<CPRProvider>(context);
    var result =
        myProvider.itemModels.firstWhere((f) => f.id == id, orElse: () => null);

    if (result == null)
      return null;
    else
      return result;
  }
}
