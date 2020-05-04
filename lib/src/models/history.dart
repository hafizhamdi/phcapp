// import 'package:phcapp/src/ui/history.dart';

import 'dart:convert';
import 'phc.dart';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  Callcard historyCallcard;
  int statusSend;
  String timestamp;

  History({this.historyCallcard, this.statusSend, this.timestamp});

  factory History.fromJson(Map<String, dynamic> json) => History(
        historyCallcard: json["history"],
        statusSend: json["status_send"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "history": historyCallcard,
        "status_send": statusSend,
        "timestamp": timestamp,
      };
}
