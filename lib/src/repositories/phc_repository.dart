import 'package:flutter/material.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/repositories/phc_api_client.dart';

class PhcRepository {
  final PhcApiClient phcApiClient;

  PhcRepository({@required this.phcApiClient}) : assert(phcApiClient != null);

  Future getPhc() async {
    return phcApiClient.fetchPhc();
  }

  Future sendingCallcard(callcard) async {
    print("sendingCallcard");
    // print(callcard.toJson());
    return phcApiClient.postCallcard(callcard);
  }

  Future getAvailableStaffs() async {
    print("getavailablestaffs");
    return phcApiClient.fetchAvailableStaffs();
  }

  Future getAvailablePlateNo() async {
    print("getAvailablePlateNo");
    
    return phcApiClient.fetchAvailablePlateNo();
  }
}
