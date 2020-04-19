import 'package:flutter/material.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/repositories/phc_api_client.dart';

class PhcRepository {
  final PhcApiClient phcApiClient;

  PhcRepository({@required this.phcApiClient}) : assert(phcApiClient != null);

  Future<Phc> getPhc() async {
    return phcApiClient.fetchPhc();
  }

  Future<Callcard> sendingCallcard(callcard) async {
    print("sendingCallcard");
    print(callcard);
    return phcApiClient.postCallcard(callcard);
  }
}
