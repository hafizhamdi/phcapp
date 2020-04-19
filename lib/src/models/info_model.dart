import 'dart:convert';

import 'package:flutter/cupertino.dart';

class InfoModel extends ChangeNotifier {
  String callcard_no;
  String call_received;
  String caller_contactno;
  String event_code;
  String priority;
  String incident_desc;
  String incident_location;
  String landmark;
  String location_type;
  String distance_toscene;
  String plate_no;
  String assign_id;

  InfoModel(
      {this.callcard_no,
      this.call_received,
      this.caller_contactno,
      this.event_code,
      this.priority,
      this.incident_desc,
      this.incident_location,
      this.landmark,
      this.location_type,
      this.distance_toscene,
      this.plate_no,
      this.assign_id});

  factory InfoModel.fromJson(Map<String, dynamic> data) => InfoModel(
        callcard_no: data["callcard_no"],
        call_received: data["call_received"],
        caller_contactno: data["caller_contactno"],
        event_code: data["event_code"],
        priority: data["priority"],
        incident_desc: data["incident_desc"],
        incident_location: data["incident_location"],
        landmark: data["landmark"],
        location_type: data["location_type"],
        distance_toscene: data["distance_toscene"],
        plate_no: data["plate_no"],
        assign_id: data["assign_id"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['callcard_no'] = this.callcard_no;
    data['call_received'] = this.call_received;
    data['caller_contactno'] = this.caller_contactno;
    data['event_code'] = this.event_code;
    data['priority'] = this.priority;
    data['incident_desc'] = this.incident_desc;
    data['incident_location'] = this.incident_location;
    data['landmark'] = this.landmark;
    data['location_type'] = this.location_type;
    data['distance_toscene'] = this.distance_toscene;
    data['plate_no'] = this.plate_no;
    data['assign_id'] = this.assign_id;

    return data;
  }

  // String get callcard_no => _callcard_no;
  // DateTime get call_received => _call_received;
  // String get caller_contact_no => _caller_contactno;
  // String get event_code => _event_code;
  // String get priority => _priority;
  // String get incident_description => _incident_desc;
  // String get incident_location => _incident_location;
  // String get landmark => _landmark;
  // String get location_type => _location_type;
  // String get distance_to_scene => _distance_toscene;
  // String get plate_no => _plate_no;
  // String get assign_id => _assign_id;
}
