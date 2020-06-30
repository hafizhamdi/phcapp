// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/providers/cpr_provider.dart';
// import 'package:phcapp/src/ui/tabs/patient/cpr/cpr_timelog.dart';
import 'package:provider/provider.dart';

// import 'cpr_tabs.dart';

class CPRItems extends StatefulWidget {
  // final BuildContext context;
  final CprSection cprSection;

  CPRItems({this.cprSection});
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

  CPRProvider cprProvider;

  // @override
  // void initState() {
  //   super.initState();
  // }

  ItemModel getValue(context, id) {
    var myProvider = Provider.of<CPRProvider>(context);
    var result =
        myProvider.itemModels.firstWhere((f) => f.id == id, orElse: () => null);

    if (result == null)
      return null;
    else
      return result;
  }

  @override
  void didChangeDependencies() {
    //   if (widget.cprSection != null) {

    //     // setState(() {
    // var myProvider = Provider.of<CPRProvider>(context);

    // CprSection cprSection = new CprSection(
    //     witnessCpr: getValue(context, 'witness_cpr').value,
    //     bystanderCpr: getValue(context, 'bystander_cpr').value,
    //     cprStart: getValue(context, 'cpr_start').value,
    //     cprStop: getValue(context, 'cpr_stop').value,
    //     rosc: getValue(context, 'rosc').value,
    //     shockable: shockable,
    //     nonShockable: nonShockable,
    //     other: other,
    //     logs: myProvider.allLogs);
    // print("DID CHANGES");
    // myProvider.updateCPR(cprSection);
    // //     // });
    // // cprProvider = Provider.of<CPRProvider>(context);

    // super.didChangeDependencies();
  }

  // }

  @override
  Widget build(BuildContext context) {
    // if (widget.cprSection != null) {
    //   final cpr = widget.cprSection;
    //   witnessCpr = cpr.witnessCpr;
    //   bystanderCpr = cpr.bystanderCpr;
    //   cprStart = cpr.cprStart;
    //   cprStop = cpr.cprStop;
    //   rosc = cpr.rosc;

    //   shockable = cpr.shockable;
    //   nonShockable = cpr.nonShockable;
    //   other = cpr.other;
    // }

    // if (widget.cprSection != null) {
    // final cprProvider = Provider.of<CPRProvider>(context);
    //   cprProvider.setLogs(widget.cprSection.logs);
    // }

    // final provider = Provider.of<CPRProvider>(context);
    // var myProvider = Provider.of<CPRProvider>(context);
    // if (widget.cprSection != null) {
    //   // setState(() {

    //   // markNeedBuild() {
    //   myProvider.updateCPR(widget.cprSection);
    //   // }
    //   // setState(() {});
    //   // });
    // }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                child: Text("VIEW LOG HISTORY"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              _buildChoiceChip(context, "witness_cpr", WITNESS),
              _buildChoiceChip(context, "bystander_cpr", WITNESS),
              _buildChoiceChip(
                context,
                "cpr_start",
                WITNESS,
              ),
              _buildAddCycle(),
              _buildCounterRhythm(),
              _buildAnalysis(),
              _buildChoiceChip(context, "rosc", WITNESS),
              _buildChoiceChip(
                context,
                "cpr_stop",
                WITNESS,
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  onSelected(context, id, value) {
    //get cprstart button click state
    if (id == "cpr_start") {
      print("cpr pressed");
      print("what the value now " + value);
    }

    final cprProvider = Provider.of<CPRProvider>(context, listen: false);

    cprProvider.updateValue(id, value);

    var item = cprProvider.itemModels
        .firstWhere((f) => f.id == id, orElse: () => null);
    // ItemModel item = getValue(context, id);

    if (value != null) {
      String format =
          DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
              " -- " +
              item.name +
              " " +
              value;

      // cprProvider.addLog(format);
      confirmAddLog(context, cprProvider, format);
    }
    // selected.value = value;
// ItemModel item = getValue(context, id);
  }

  // onSelected(labelText, value) {
  //   print("IM in ONSELECTED WHY NOT TRIGGER");
  //   final cprProvider = Provider.of<CPRProvider>(context, listen: false);

  //   if (labelText == "Witness CPR") {
  //     // setState(() {
  //     witnessCpr = value;
  //     // cprProvider.setWitnessCPR(value);
  //     // });
  //   }
  //   if (labelText == "Bystander CPR") {
  //     // setState(() {
  //     bystanderCpr = value;
  //     // provider.byStanderCPR = value;
  //     // });
  //   }
  //   if (labelText == "CPR Start") {
  //     // setState(() {
  //     cprStart = value;
  //     // });
  //   }
  //   if (labelText == "ROSC") {
  //     // setState(() {
  //     rosc = value;
  //     // });
  //   }

  //   if (labelText == "CPR Stop") {
  //     // setState(() {
  //     cprStop = value;
  //     // });
  //   }
  //   if (labelText == "Rhythm") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.rhythm = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.rhythm = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.rhythm = value;
  //       // });
  //     }
  //   }

  //   if (labelText == "Intervention") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.intervention = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.intervention = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.intervention = value;
  //       // });
  //     }
  //   }

  //   if (labelText == "Drugs") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.drugs = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.drugs = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.drugs = value;
  //       // });
  //     }
  //   }

  //   if (labelText == "Airway") {
  //     if (onShock != null) {
  //       // setState(() {
  //       shockable.airway = value;
  //       // });
  //     } else if (onNonShock != null) {
  //       // setState(() {
  //       nonShockable.airway = value;
  //       // });
  //     } else if (onOther != null) {
  //       // setState(() {
  //       other.airway = value;
  //       // });
  //     }
  //   }

  //   CprSection cpr = new CprSection(
  //     witnessCpr: witnessCpr,
  //   );

  //   cprProvider.updateCPR(cpr);

  //   if (value != null) {
  //     String format =
  //         DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
  //             " -- " +
  //             labelText +
  //             " " +
  //             value;

  //     cprProvider.addLog(format);
  //     // confirmLog(format);
  //   }
  // }

  _buildChoiceChip(context, id, data) {
    ItemModel item = getValue(context, id);
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(item.name),
            Wrap(
                children: List<Widget>.generate(data.length, (index) {
              return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    pressElevation: 5.0,
                    elevation: 2.0,
                    key: UniqueKey(),
                    label: Text(data[index]),
                    selected: data[index] == item.value,
                    onSelected: (bool selected) {
                      // providerSelected.updateValue(labelText, data[index]);
                      // if (data[index] != null) {
                      //   String format = DateFormat("dd/MM/yyyy @ hh:mm aa")
                      //           .format(DateTime.now()) +
                      //       " -- " +
                      //       labelText +
                      //       " " +
                      //       data[index];

                      //   cprProvider.addLog(format);
                      //   // confirmLog(format);
                      // }
                      onSelected(context, id, data[index]);
                    },
                    selectedColor: Colors.pink[200],
                  ));
            }))
          ],
        ));
  }

  _buildCounterRhythm() {
    final provider = Provider.of<CPRProvider>(context);
    return SizedBox(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.cycleCounter,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(5),
              alignment: Alignment.center,
              width: 60,
              height: 60,
              decoration: new BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Text(
                "${index + 1}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white.withOpacity(0.8)),
              ),
            );
          }),
    );
  }

  _buildAddCycle() {
    final provider = Provider.of<CPRProvider>(context);
    return Padding(
        padding: EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Rhythm Analysis: " + provider.cycleCounter.toString()),
          RaisedButton.icon(
            label: Text("Add Rhythm Analysis"),
            icon: Icon(Icons.add),
            onPressed: () {
              provider.resetRhythmAnalysis();
              provider.addCycle();
              provider.addLog(
                  "Rhythm Analysis > " + provider.cycleCounter.toString());
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

  _buildAnalysis() {
    final provider = Provider.of<CPRProvider>(context);
    return Container(
        // padding: EdgeInsets.all(10),
        child: Column(children: [
      Card(
        margin: EdgeInsets.all(10),
        elevation: 2.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _customButton("Shockable", onShock),
                _customButton("Non Shockable", onNonShock),
                _customButton("Other", onOther),
              ],
            ),
            _showButtonChoices(onShock, onNonShock, onOther),
          ],
        ),
      ),
    ]));
  }

  onPressed(label) {
    if (label == "Shockable") {
      setState(() {
        onShock = label;
        onNonShock = null;
        onOther = null;
      });
    } else if (label == "Non Shockable") {
      setState(() {
        onShock = null;
        onNonShock = label;
        onOther = null;
      });
    } else {
      setState(() {
        onShock = null;
        onNonShock = null;
        onOther = label;
      });
    }

    if (label != null) {
      final provider = Provider.of<CPRProvider>(context, listen: false);
      String format =
          DateFormat("dd/MM/yyyy @ hh:mm aa").format(DateTime.now()) +
              " -- " +
              label +
              " start"; // +
      // " " +
      // value;

      provider.addLog(format);
    }
  }

  _customButton(label, selected) {
    return Container(
      width: 100,
      height: 50,
      // alignment: Alignment.center,
      child: RaisedButton(
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          onPressed(label);
        },
        color: selected != null ? Theme.of(context).accentColor : Colors.white,
        textColor:
            selected != null ? Colors.white : Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Theme.of(context).accentColor)),
      ),
    );
  }

  _showButtonChoices(onShock, onNonShock, onOther) {
    // if (onShock != null) {
    if (onNonShock != null) {
      return _buildNonShockable();
    } else if (onOther != null) {
      return _buildOther();
    }
    // return Container(
    return _buildShockable();
    //   padding: EdgeInsets.all(10),
    //   child: Text("No analysis start"),
    // );
  }

  _buildShockable() {
    // final provider = Provider.of<CPRProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          _buildChoiceChip(context, "srhythm", RHYTHM),
          _buildChoiceChip(context, "sinterv", INTERV),
          _buildChoiceChip(context, "sdrugs", DRUG),
          _buildChoiceChip(context, "sairway", AIRWAY),
        ],
      ),
    );
  }

  _buildNonShockable() {
    // final provider = Provider.of<CPRProvider>(context);

    return Container(
      child: Column(
        children: <Widget>[
          _buildChoiceChip(context, "nsrhythm", RHYTHMNS),
          _buildChoiceChip(context, "nsdrugs", DRUG),
          _buildChoiceChip(context, "nsairway", AIRWAY),
        ],
      ),
    );
  }

  _buildOther() {
    // final provider = Provider.of<CPRProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          _buildChoiceChip(context, "orhythm", RHYTHMOT),
          _buildChoiceChip(context, "ointerv", INTEROT),
          _buildChoiceChip(context, "odrugs", DRUG),
          _buildChoiceChip(context, "oairway", AIRWAY)
        ],
      ),
    );
  }

  _buildButtonChip(labelText, data) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(labelText),
            Column(
                children: List<Widget>.generate(data.length, (index) {
              return Container(
                  // padding: EdgeInsets.only(right: 10),
                  child: RaisedButton(
                child: Text(data[index]),
                onPressed: () {},
                textColor: Colors.white,
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.pink[200])),
              ));
            }))
          ],
        ));
  }

  confirmAddLog(context, logs, value) {
    TextEditingController commentController =
        new TextEditingController(text: value);
    // final provider = Provider.of<CPRProvider>(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add log"),
            content: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Log description",
                      style: TextStyle(
                          // fontSize: 21,
                          color: Colors.grey),
                    ),
                    TextField(
                      controller: commentController,
                    )
                  ],
                )),
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                // color: Colors.lightGreen,
                child: Text(
                  "CANCEL",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                color: Colors.lightGreen,
                child: Text(
                  "ADD LOG",
                ),
                onPressed: () {
                  logs.addLog(value);

                  Navigator.pop(context);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
          );
        });
  }
}
