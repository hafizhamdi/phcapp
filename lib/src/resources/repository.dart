import 'dart:async';
import 'phc_api_provider.dart';
import 'info_api_provider.dart';
import '../models/phc.dart';
import '../models/info_model.dart';
import 'dart:convert';

class Repository {
  final phcApiProvider = PhcApiProvider();
  final infoApiProvider = InfoApiProvider();

  Future<Phc> fetchAllCallcards() => phcApiProvider.fetchPhcList();
  Future addCallInfo(InfoModel info) =>
      infoApiProvider.addCallInfo(json.encode(info));

  // Future updateCallcard (callcard) => phcApiProvider.postCallcard(callcard);

}
