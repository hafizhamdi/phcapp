import 'dart:async';
import 'package:http/http.dart' as http; // show Client;
import 'dart:convert';
import '../models/phc.dart';

class PhcApiProvider {
  // Client client = Client();
  final baseUrl = "http://202.171.33.109/phc-mobile/api/v1";
  final http.Client httpClient = http.Client();

  Future<Phc> fetchPhcList() async {
    print("fetch callcards entered");
    final response = await this.httpClient.get("$baseUrl/callcards");

    print(response.body.toString());

    if (response.statusCode == 200) {
      return Phc.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load callcards');
    }
  }

  // Future postCallcard(callcard) async {
  //   final postResponse = await this.httpClient.post("$baseUrl/upload_result/call_card", body: callcard);
  //   if (postResponse.statusCode == 200) {
  //     return postResponse;
  //   } else {
  //     throw Exception("Failed to post call card");
  //   }
  // }
}
