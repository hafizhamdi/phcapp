import 'dart:async';
import 'package:http/http.dart' as http; // show Client;
import 'dart:convert';
import '../models/phc_model.dart';

class PhcApiProvider {
  // Client client = Client();
  final http.Client httpClient = http.Client();

  Future<PhcModel> fetchPhcList() async {
    print("fetch callcards entered");
    final response = await this
        .httpClient
        .get("http://202.171.33.109/phc-mobile/api/v1/callcards");

    print(response.body.toString());

    if (response.statusCode == 200) {
      return PhcModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load callcards');
    }
  }
}
