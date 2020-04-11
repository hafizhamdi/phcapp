import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/info_model.dart';

class InfoApiProvider {
  final _url = "http://202.171.33.109/phc-mobile/api/v1";
  Client client = Client();
  // final http.Client httpClient = http.Client();

  Future addCallInfo(call_info) async {
    print(call_info);
    final response = await client.post("$_url/upload_result", body: call_info);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception("Failed to add call info");
    }
  }
  // Future<InfoModel> postInfo() async {
  //   print("post information entered");

  // final response = await this
  //     .httpClient
  //     .get("http://202.171.33.109/phc-mobile/api/v1/callcards");

  // print(response.body.toString());

  // if (response.statusCode == 200) {
  //   return PhcModel.fromJson(json.decode(response.body));
  // } else {
  //   throw Exception('Failed to load callcards');
  // }
  // }
}
