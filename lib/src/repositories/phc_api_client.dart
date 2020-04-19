import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:phcapp/src/models/phc.dart';

class PhcApiClient {
  static const baseUrl = "http://202.171.33.109/phc-mobile/api/v1";
  final http.Client httpClient;

  PhcApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Phc> fetchPhc() async {
    final phcUrl = '$baseUrl/callcards';
    final phcResponse = await this.httpClient.get(phcUrl);

    if (phcResponse.statusCode != 200) {
      throw Exception("Error getting phc dataset from server");
    }
    final phcJson = jsonDecode(phcResponse.body);
    return Phc.fromJson(phcJson);
  }

  Future<Callcard> postCallcard(Callcard callcard) async {
    assert(callcard != null);

    print("post callcard masuk");
    print(jsonEncode(callcard.call_information));

    var internal_callcard = {};
    internal_callcard["call_information"] = callcard.call_information;
    final postResponse =
        await this.httpClient.post("$baseUrl/upload_result/call_card",
            // headers: {"Content-Type": "application/json"},
            //   headers: <String, String>{
            // 'Content-Type': 'application/json; charset=UTF-8',
            // },
            body: jsonEncode(internal_callcard));
    // body: {'result':callcard.toJson()});

    print("post-status-code:");
    print(postResponse.statusCode);
    if (postResponse.statusCode == 200) {
      final resultResponse = jsonDecode(postResponse.body);
      return Callcard.fromJson(resultResponse);
    } else {
      print("htrow excemptions");
      throw Exception("Failed to post call card");
    }
  }
}
