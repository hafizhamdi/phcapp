class TimerModel {
  String _dispatch_time;
  String _enroute_time;
  String _atScene_time;
  String _atPatient_time;
  String _transporting_time;
  String _atHospital_time;
  String _reroute_time;
  String _reason_abort;

  TimerModel.fromJson(Map<String, dynamic> data) {
    _dispatch_time = parsingTime(data["dispatch_time"]);
    _enroute_time = parsingTime(data["enroute_time"]);
    _atScene_time = parsingTime(data["atScene_time"]);
    _atPatient_time = parsingTime(data["atPatient_time"]);
    _transporting_time = parsingTime(data["transporting_time"]);
    _atHospital_time = parsingTime(data["atHospital_time"]);
    _reroute_time = parsingTime(data["reroute_time"]);
    _reason_abort = data["reason_abort"];
  }

  String get dispatch_time => _dispatch_time;
  String get enroute_time => _enroute_time;
  String get at_scene_time => _atScene_time;
  String get at_patient_time => _atPatient_time;
  String get transporting_time => _transporting_time;
  String get at_hospital_time => _atHospital_time;
  String get reroute_time => _reroute_time;
  String get reason_abort => _reason_abort;
}

String parsingTime(String time) {
  // time.substring()
  if (time == null || time == '') return '';
  // print(time);

  // print(time.length);
  return time.substring(0, time.length - 2);
  // return (time != null || time != '')
  //     ? time.substring(0, -2)
  //     : ''; //remove .0 extension from datetime format in db
}
