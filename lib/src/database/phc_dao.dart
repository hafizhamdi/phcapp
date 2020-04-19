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
    // var record = await _phcStore.record(key).getSnapshot(db);
    // var finder = Finder(

    print("updateCallInformation");
    // var phc = await _phcStore.record(59).get(await _db);
    var records = await _phcStore.record(getKey).getSnapshot(await _db);

    // _phcStore.record(getKey).

    // var finder = Finder(filter: Filter.byKey(getKey));
    // var phc = await _phcStore.find(await _db, finder: finder);
    // _phcStore.record(key)

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

    // var updated = _phcStore.record(getKey).update(await _db, )
    // print(updated);
    // var temp = cloneMap(Callcard.fromJson(result).call_information.toJson());
    print("temp");
    // print(temp);
    print("after");
    // temp["caller_contactno"] = call.caller_contactno;
    // print(temp);
    // print("resultListCallcard");
    // print(Callcard.fromJson(result).call_information);

    // var newList = listCallcards.map((data) {
    //   if (CallInformation.fromJson(data).assign_id == call.assign_id) {
    //     var temp = cloneMap(data);
    //     print(temp);
    //     // temp["call_information"] = call;
    //   }
    //   return data;
    // });

    // print(newList);
    // print(phc);
    // var records = _phcStore.find(await _db, finder:finder);
    // var records = await store.find(db, finder: finder);

    // var phcRecord = await _phcStore.record(key).getSnapshot(await _db);

    // await _phcStore.update(await _db, call.toJson());
  }

  Future getCallInformation(assign_id) async {
    print("getCallInformation");
    print(assign_id);

    var finder = Finder(
        filter: Filter.equals('assign_id', assign_id),
        sortOrders: [SortOrder(Field.key, false)]);

    // var finder =
    //     Finder(filter: Filter.matches('callcards', '^C', anyInList: true))
    // int mykey = getKey;
    // print('mykey[$mykey]');
    // var records = await _phcStore.record(mykey).getSnapshot(await _db);

    // var finder = Finder(filter: Filter.("phc.callcards.call_information.assign_id", assign_id));

    // final phc = Phc.fromJson(records["phc"]);

    // CallInformation
    // var records = _phcStore.record(key).get(await _db);
    var record = await _phcStore.findFirst(await _db, finder: finder);
    print(record.value);
    // var listCallcards = records["phc.callcards"] as List;

    // var result = listCallcards.firstWhere(
    //     (data) =>
    //         Callcard.fromJson(data).call_information.assign_id == assign_id,
    //     orElse: () => null);

    // print("resultListCallcard");
    // print(result);
    // print(Callcard.fromJson(result).call_information);
    // listCallcards.
    // var call_info = listCallcards.((data) {
    //   if (data.call_information.assign_id == assign_id)
    //     return data.call_information;
    // });

    // print(CallInformation.fromJson(call_info));

    // var phcRecord = await _phcStore.record(key).getSnapshot(await _db);
    // print("records");
    // print(records);
    return record.value;
    // return Callcard.fromJson(result).call_information;

    // phcRecord
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

//test ok
    // var phcRecord = await _phcStore.record(getKey).getSnapshot(await _db);
    // print("getALLphc");
    // print(phcRecord["phc"]);

    // print(phcRecord["phc"]);
    // print(phcRecord.toString());
    return Phc.fromJson(record.value["phc"]);

    // return Phc.fromJson(phcRecord["phc"]);
  }

  Future insertCallInformation(CallInformation call_info) async {
    print("insert callinfor ----");
    print(call_info);
    var result = await _phcStore.add(await _db, call_info.toJson());
    var records = await _phcStore.record(result).get(await _db);

    print(result);
    print(records);
  }
}
