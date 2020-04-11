import 'dart:async';
import 'phc_api_provider.dart';
import 'info_api_provider.dart';
import '../models/phc_model.dart';
import '../models/info_model.dart';

class Repository {
  final phcApiProvider = PhcApiProvider();
  final infoApiProvider = InfoApiProvider();
  
  Future<PhcModel> fetchAllCallcards() => phcApiProvider.fetchPhcList();
  Future addCallInfo(InfoModel info) => infoApiProvider.addCallInfo(info.toJson());


}
