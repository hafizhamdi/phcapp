import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:phcapp/src/models/phc.dart';

// class CPRProvider extends ChangeNotifier {
//   List<LogMeasurement> _items = <LogMeasurement>[
//     // LogMeasurement(item: 'CPR Start')
//   ];

//   set setLogs(logs) {
//     _items = logs;
//     notifyListeners();
//   }

//   /// An unmodifiable view of the items in the cart.
//   // UnmodifiableListView<LogMeasurement> get items =>
//   //     UnmodifiableListView(_items);
//   List<LogMeasurement> get items => _items;

//   /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
//   /// cart from the outside.
//   void add(LogMeasurement item) {
//     _items.add(item);
//     // This call tells the widgets that are listening to this model to rebuild.
//     notifyListeners();
//   }

//   /// Removes all items from the cart.
//   void removeAll() {
//     _items.clear();
//     // This call tells the widgets that are listening to this model to rebuild.
//     notifyListeners();
//   }

//   void remove(int index) {
//     _items.removeAt(index);

//     notifyListeners();
//   }
// }

class CPRProvider extends ChangeNotifier {
  List<String> _commonCPR = List();
  String witnessCPR;
  String byStanderCPR;
  String cprStart;
  int cycleCounter = 0;
  // List<CprSection> _listCPRs = new List();
  String rosc;
  String cprStop;
  Analysis shockable = new Analysis();
  Analysis nonShockable = new Analysis();
  Analysis other = new Analysis();

  List<ItemModel> itemModels = <ItemModel>[
    ItemModel(id: "witness_cpr", name: "Witness CPR"),
    ItemModel(id: "bystander_cpr", name: "Bystander CPR"),
    ItemModel(id: "cpr_start", name: "CPR Start"),
    ItemModel(id: "rosc", name: "ROSC"),
    ItemModel(id: "cpr_stop", name: "CPR Stop"),
    ItemModel(id: "srhythm", name: "Rhythm"),
    ItemModel(id: "sinterv", name: "Intervention"),
    ItemModel(id: "sdrugs", name: "Drugs"),
    ItemModel(id: "sairway", name: "Airway"),
    ItemModel(id: "nsrhythm", name: "Rhythm"),
    ItemModel(id: "nsinterv", name: "Intervention"),
    ItemModel(id: "nsdrugs", name: "Drugs"),
    ItemModel(id: "nsairway", name: "Airway"),
    ItemModel(id: "orhythm", name: "Rhythm"),
    ItemModel(id: "ointerv", name: "Intervention"),
    ItemModel(id: "odrugs", name: "Drugs"),
    ItemModel(id: "oairway", name: "Airway"),
    ItemModel(id: "analysis", name: "Analysis"),
  ];

  // List<Analysis> itemAnalysis = <Analysis>[
  //   Analysis(id: "shockable", name: "Shockable"),
  //   Analysis(id: "non_shockable", name: "Non Shockable"),
  //   Analysis(id: "other", name: "Other")
  // ];

  void setWitnessCPR(value) {
    witnessCPR = value;
    // notifyListeners();
  }

  // Analysis getAnalysis(id) {
  //   var selected =
  //       itemAnalysis.firstWhere((f) => f.id == id, orElse: () => null);

  //   if (selected != null) return selected;
  //   return null;
  // }

  String getValue(id) {
    var selected = itemModels.firstWhere((f) => f.id == id, orElse: () => null);
    if (selected != null) return selected.value;
    return null;
  }

  void updateValue(id, value) {
    var selected = itemModels.firstWhere((f) => f.id == id, orElse: () => null);
    if (selected != null) {
      selected.value = value;
      // if (id == "witness_cpr") {
      //   selected.value = value;
      // }
      // if (id == "bystander_cpr") {
      //   selected.value = value;
      // }
      // if(id == "cpr_start"){
      //   selected.value = value;
      // }
      // notifyListeners();
    }
  }

  void resetRhythmAnalysis() {
    itemModels.map((f) {
      if (f.id == "cpr_start")
        f.value = f.value;
      else if (f.id == "bystander_cpr")
        f.value = f.value;
      else if (f.id == "witness_cpr")
        f.value = f.value;
      else if (f.id == "rosc")
        f.value = f.value;
      else if (f.id == "cpr_stop")
        f.value = f.value;
      else
        f.value = null;

      return f;
    }).toList();

    notifyListeners();
  }

  // UnmodifiableListView<CprSection> get listCPRs =>
  //     UnmodifiableListView(_listCPRs);
  // List<CPR> get listCPRs => _listCPRs;

  // UnmodifiableListView<String> get items => UnmodifiableListView(_commonCPR);
  List<String> get items => _commonCPR;

  // UnmodifiableListView<String set setLogs(logs) => UnmodifiableListView()
  List<String> get allLogs => _commonCPR;

  void setLogs(logs) {
    _commonCPR = List<String>.from(logs).toList();
    // notifyListeners();
  }

  void addCycle() {
    cycleCounter++;

    notifyListeners();
  }

  void addLog(String value) {
    _commonCPR.add(value);

    notifyListeners();
  }

  void resetLogs() {
    cycleCounter = 0;

    // itemModels.map((f) {
    //   f.value = null;
    // }).toList();

    _commonCPR = new List<String>();
    notifyListeners();
  }

  void removeLog(int index) {
    _commonCPR.removeAt(index);

    notifyListeners();
  }

  // void addCPR(CprSection cpr) {
  //   _listCPRs.add(cpr);

  //   notifyListeners();
  // }

  // void updateCPR(CprSection cpr) {
  //   witnessCPR = cpr.witnessCpr;
  //   byStanderCPR = cpr.bystanderCpr;
  //   rosc = cpr.rosc;
  //   cprStart = cpr.cprStart;
  //   cprStop = cpr.cprStop;
  //   shockable.rhythm = cpr.shockable.rhythm;
  //   shockable.intervention = cpr.shockable.intervention;
  //   shockable.drugs = cpr.shockable.drugs;
  //   shockable.airway = cpr.shockable.airway;

  //   nonShockable.rhythm = cpr.nonShockable.rhythm;
  //   nonShockable.intervention = cpr.nonShockable.intervention;
  //   nonShockable.drugs = cpr.nonShockable.drugs;
  //   nonShockable.airway = cpr.nonShockable.airway;

  //   other.rhythm = cpr.other.rhythm;
  //   other.intervention = cpr.other.intervention;
  //   other.drugs = cpr.other.drugs;
  //   other.airway = cpr.other.airway;

  //   _commonCPR = cpr.logs;

  //   notifyListeners();
  // }
}

// class CPR {
//   Analysis shockable;
//   Analysis nonShockable;
//   Analysis other;

//   CPR({this.shockable, this.nonShockable, this.other});
// }

// class Analysis {
//   String typeCPR;
//   String rhythm;
//   String intervention;
//   String drugs;
//   String airway;
// }
