import 'package:intl/intl.dart';
import 'package:phcapp/src/database/app_database.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/models/history.dart';
import 'package:sembast/sembast.dart';
import 'dart:convert';
import 'package:sembast/utils/value_utils.dart';

class PhcDao {
  static const String PHC_STORE_NAME = "phcStore";
  static const String HISTORY_STORE_NAME = "historyStore";

  final _phcStore = intMapStoreFactory.store(PHC_STORE_NAME);
  final _historyStore = intMapStoreFactory.store(HISTORY_STORE_NAME);
  int key;

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Phc phc) async {
    print("insert phc");
    key = await _phcStore.add(await _db, {'phc': phc.toJson()});

    print("key");
    print(key);
    print("-----");
    return key;
    // setKey(key);
  }

  void setKey(key) => key;

  int get getKey => key;

  Future update(Phc phc) async {
    await _phcStore.update(await _db, phc.toJson());
  }

  Future updateCallInformation(CallInformation call) async {
    print("updateCallInformation");
    var records = await _phcStore.record(getKey).getSnapshot(await _db);

    var listCallcards = records["phc.callcards"]; // as List;

    var result = listCallcards.map((data) {
      if (Callcard.fromJson(data).call_information.assign_id ==
          call.assign_id) {
        print("inside list");
        print(data);
        var temp = cloneMap(Callcard.fromJson(data).call_information.toJson());
        temp["caller_contactno"] = call.caller_contactno;
        print(temp);
        return temp;
      } else
        return data;
    });

    print(result);
  }

  Future getCallInformation(assign_id) async {
    print("getCallInformation");
    print(assign_id);

    var finder = Finder(
        filter: Filter.equals('assign_id', assign_id),
        sortOrders: [SortOrder(Field.key, false)]);

    var record = await _phcStore.findFirst(await _db, finder: finder);
    print(record.value);
    return record.value;
  }

  Future<CallInformation> getPhcCallInformation(assign_id) async {
    int mykey = getKey;
    print('mykey[$mykey]');
    var records = await _phcStore.record(mykey).getSnapshot(await _db);

    var listCallcards = records["phc.callcards"] as List;

    var result = listCallcards.firstWhere(
      (data) => Callcard.fromJson(data).call_information.assign_id == assign_id,
    );

    // listCallcards/
    // .
    // print(result.call_information);
    print(Callcard.fromJson(result).call_information);
    // print(CallInformation.fromJson(result).toJson());
    var callcard = Callcard.fromJson(result);
    print(callcard.toJson());
    return callcard.call_information;
  }

  Future getAllPhc() async {
    var now = DateFormat("yyyy-MM-dd HH:mm:ss").format(new DateTime.now());
    print(now);
    var finder = Finder(
        filter: Filter.lessThanOrEquals('phc.lastUpdated', now),
        sortOrders: [SortOrder(Field.key, false)]);

    var record = await _phcStore.findFirst(await _db, finder: finder);
    print(record);
    print(record.value["phc"]);

    return Phc.fromJson(record.value["phc"]);
  }

  Future insertCallInformation(CallInformation call_info) async {
    print("insert callinfor ----");
    print(call_info);
    var result = await _phcStore.add(await _db, call_info.toJson());
    var records = await _phcStore.record(result).get(await _db);

    print(result);
    print(records);
  }

  Future<ResponseTeam> getPhcResponseTeam(assign_id) async {
    int mykey = getKey;
    print('mykey[$mykey]');
    var records = await _phcStore.record(mykey).getSnapshot(await _db);

    var listCallcards = records["phc.callcards"] as List;

    var result = listCallcards.firstWhere(
        (data) =>
            Callcard.fromJson(data).call_information.assign_id == assign_id,
        orElse: () => null);

    // print(result.call_information);
    // print(Callcard.fromJson(result).response_team);
    // print(CallInformation.fromJson(result).toJson());
    var callcard = Callcard.fromJson(result);
    // print(callcard.toJson());
    return callcard.response_team;
  }

  Future insertResponseTeam(ResponseTeam responseTeam, assignId) async {
    print("insert responseteam ----");

    var response = responseTeam.toJson();
    response["assign_id"] = assignId;
    response["record_type"] = "ResponseTeam";

    print("response");
    print(response);
    // print(call_info);
    var result = await _phcStore.add(await _db, response);
    var records = await _phcStore.record(result).get(await _db);

    print(result);
    print(records);
  }

  Future<ResponseTeam> getResponseTeam(assign_id) async {
    print("getResponseTeam");
    print(assign_id);

    var finder = Finder(
        filter: Filter.and([
          Filter.equals('assign_id', assign_id),
          Filter.equals('record_type', "ResponseTeam")
        ]),
        sortOrders: [SortOrder(Field.key, false)]);

    var record = await _phcStore.findFirst(await _db, finder: finder);
    print("record.value");
    print(record);

    var listStaffs = record["staffs"] as List;
    // print(data.length);

    var result = listStaffs.map((data) {
      return Staff.fromJson(data);
    }).toList();

    print(result);

    print(record["service_response"]);
    ResponseTeam copy = new ResponseTeam(
        serviceResponse: record["service_response"],
        vehicleRegno: record["vehicle_regno"],
        staffs: result);
    return copy;
  }

  Future<ResponseTime> getResponseTime(assign_id) async {
    print("getResponseTime");
    print(assign_id);

    var finder = Finder(
        filter: Filter.and([
          Filter.equals('assign_id', assign_id),
          Filter.equals('record_type', "ResponseTime")
        ]),
        sortOrders: [SortOrder(Field.key, false)]);

    var record = await _phcStore.findFirst(await _db, finder: finder);
    print("record.value");
    print(record);

    // var result = record["staffs"];
    // print(data.length);

    // var result = listStaffs.map((data) {
    //   return Staff.fromJson(data);
    // }).toList();

    // print(result);

    print(record.value["dispatch_time"]);
    ResponseTime copy = new ResponseTime(
      dispatchTime: record.value["dispatch_time"],
      enrouteTime: record.value["enroute_time"],
      atSceneTime: record.value["atScene_time"],
      atPatientTime: record.value["atPatient_time"],
      transportingTime: record.value["transporting_time"],
      atHospitalTime: record.value["atHospital_time"],
      rerouteTime: record.value["reroute_time"],
      reasonAbort: record.value["reason_abort"],
      // serviceResponse: record["service_response"],
      // vehicleRegno: record["vehicle_regno"],
      // staffs: result
    );
    return copy;
  }

  Future<ResponseTime> getPhcResponseTime(assign_id) async {
    int mykey = getKey;
    print('mykey[$mykey]');
    var records = await _phcStore.record(mykey).getSnapshot(await _db);

    var listCallcards = records["phc.callcards"] as List;

    var result = listCallcards.firstWhere(
        (data) =>
            Callcard.fromJson(data).call_information.assign_id == assign_id,
        orElse: () => null);

    // print(result.call_information);
    // print(Callcard.fromJson(result).response_team);
    // print(CallInformation.fromJson(result).toJson());
    var callcard = Callcard.fromJson(result);
    // print(callcard.toJson());
    return callcard.response_time;
  }

  Future insertResponseTime(ResponseTime responseTime, assignId) async {
    print("insert responsetime ----");

    var response = responseTime.toJson();
    response["assign_id"] = assignId;
    response["record_type"] = "ResponseTime";

    print("response");
    print(response);
    // print(call_info);
    var result = await _phcStore.add(await _db, response);
    var records = await _phcStore.record(result).get(await _db);

    print("keygenerated=${result}");
    print(records["assign_id"]);

    final newResult = ResponseTime(
        dispatchTime: records["dispatch_time"],
        enrouteTime: records["enroute_time"],
        atSceneTime: records["atScene_time"],
        atPatientTime: records["atPatient_time"],
        atHospitalTime: records["atHospital_time"],
        transportingTime: records["transporting_time"],
        rerouteTime: records["reroute_time"],
        reasonAbort: records["reason_abort"]);

    return newResult;
  }

  Future<List<Patient>> getPhcPatientList(assign_id) async {
    int mykey = getKey;
    print('mykey[$mykey]');
    var records = await _phcStore.record(mykey).getSnapshot(await _db);

    var listCallcards = records["phc.callcards"] as List;

    var result = listCallcards.firstWhere(
        (data) =>
            Callcard.fromJson(data).call_information.assign_id == assign_id,
        orElse: () => null);
    var callcard = Callcard.fromJson(result);

    print(callcard.patients);

    return List<Patient>.from(callcard.patients).toList();
  }

  Future insertHistory(Callcard callcard, statusSend) async {
    print("insert callcard history");
    print("statusSend: " + statusSend.toString());
    final List<History> listHistory = await showAllHistory();
    // print(listHistory);
    print("*&@&@&@&@(@((@");
    print(listHistory.length);
    // final newlist = List.from(listHistory).map((data) {
    //   // print("****************");
    //   print(data.timestamp);
    //   return data;
    //   // print(data.historyCallcard.call_information.callcard_no);
    // });
    // print(newlist);

    // listHistory.firstWhere(test)
    final isExist = listHistory.firstWhere(
        (data) =>
            data.historyCallcard.call_information.callcard_no ==
            callcard.call_information.callcard_no, orElse: () {
      //  await _historyStore.add(await _db, {
      //     "history": callcard.toJson(),
      //     "status_send": 0,
      //     "timestamp": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())
      //   });
      return null;
      // }
    });
    // });

    print(callcard.call_information.callcard_no);
    // if (isExist != null) {
    // } else {}

    // if (listHistory.firstWhere(
    //   // (data) => data.historyCallcard.call_information.callcard_no ==
    //   //         callcard.call_information.callcard_no ,

    //     // },
    //     () async {
    // }) !=
    // null)

    // {
    // )
    //   print("****************");
    //   print(data.historyCallcard.call_information.callcard_no);
    //   // return data.historyCallcard.call_information.callcard_no ==
    //   //     callcard.call_information.callcard_no;
    // }))
    if (isExist != null) {
      //this callcard already exist in history list, so update
      print("im in history contains");
      var finder = Finder(
        filter:
            // Filter.and([
            Filter.equals('history.call_information.callcard_no',
                callcard.call_information.callcard_no),
        // Filter.equals('record_type', "ResponseTime")
        // ]
        // ),
        // sortOrders: [SortOrder(Field.key, false)]
      );

      var findRecord = await _historyStore.findFirst(await _db, finder: finder);
      var key = findRecord.key;

      var record = _historyStore.record(key);
      // var test = _historyStore.record(key);
      // test.ge
      print("record found in history which exist before");
      print(findRecord);

      final update = await record.put(await _db, {
        'history': callcard.toJson(),
        'timestamp': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        "status_send": statusSend
      });

      print("update----");
      print(update);
    } else {
      print("Create new in history");

      // final history = new History(
      //     historyCallcard: Callcard(
      //         callInformation: callcard.call_information,
      //         responseTeam: callcard.response_team,
      //         responseTime: callcard.response_time,
      //         patients: List<Patient>(),
      //         sceneAssessment: new SceneAssessment()),
      //     statusSend: statusSend,
      //     timestamp: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
      // create new in history
      final mykey = await _historyStore.add(await _db, //history.toJson()
          {
            "history": callcard.toJson(),
            "status_send": statusSend,
            "timestamp":
                DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())
          });

      print("mykey---+" + mykey.toString());
      print("satussend---+" + statusSend.toString());

      return mykey;
      // if (key != null) {
      //   print("new key ---history generated");
      //   print(key);
      //   print("-----");
      // }
    }

    // ))

    // print(data);

    // return key;
    // setKey(key);
  }

  Future<List<History>> showAllHistory() async {
    var finder = Finder(
        //   filter: Filter.equals('call_information.assign_id', assign_id),
        //   // Filter.equals('record_type', "ResponseTime")
        // );
        sortOrders: [SortOrder('timestamp', false)]);

    var records = await _historyStore.find(await _db, finder: finder);

    print("SHOWALL HISTORY");
    // print(records);
    return List.from(records).map((data) {
      // print(data.value);
      return History(
          historyCallcard: Callcard.fromJson(data.value["history"]),
          statusSend: data.value["status_send"],
          timestamp: data.value["timestamp"]);
      // return Callcard.fromJson(data.value);
    }).toList();
  }

  Future<List<History>> clearAllSuccessHistory() async {
    var finder = Finder(
      filter:
          // Filter.and([
          Filter.equals('status_send', 1),
      // Filter.equals('record_type', "ResponseTime")
      // ]
      // ),
    );

    final deleteAll = await _historyStore.delete(await _db, finder: finder);

    return showAllHistory();

    // print(deleteAll);
  }

  Future updateHistory(Callcard callcard, statusSend) async {
    var finder = Finder(
      filter:
          // Filter.and([
          Filter.equals('history.call_information.callcard_no',
              callcard.call_information.callcard_no),
      // Filter.equals('record_type', "ResponseTime")
      // ]
      // ),
      // sortOrders: [SortOrder(Field.key, false)]
    );

    var findRecord = await _historyStore.findFirst(await _db, finder: finder);
    var key = findRecord.key;

    var record = _historyStore.record(key);
    // var test = _historyStore.record(key);
    // test.ge
    print("record found in history which exist before");
    print(findRecord);

    final update = await record.put(await _db, {
      'history': callcard.toJson(),
      'timestamp': DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
      'status_send': statusSend
    });

    print(update);
  }
}

final phcDao = PhcDao();
