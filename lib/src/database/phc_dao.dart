import 'package:intl/intl.dart';
import 'package:phcapp/src/database/app_database.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:sembast/sembast.dart';
import 'dart:convert';
import 'package:sembast/utils/value_utils.dart';

class PhcDao {
  static const String PHC_STORE_NAME = "phcStore";

  final _phcStore = intMapStoreFactory.store(PHC_STORE_NAME);
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
        (data) =>
            Callcard.fromJson(data).call_information.assign_id == assign_id,
        orElse: () => null);

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
        staffs: result
        );
    return copy;
  }
}

final phcDao = PhcDao();
