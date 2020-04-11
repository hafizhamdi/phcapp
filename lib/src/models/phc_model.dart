// import 'package:phcapp/src/tab_screens/patients.dart';

import 'team_model.dart';
import 'timer_model.dart';
import 'info_model.dart';
import 'patient_model.dart';

class PhcModel {
  List<_Callcard> _callcards = [];
  DateTime _lastUpdated;

  PhcModel.fromJson(Map<String, dynamic> data) {
    List<_Callcard> temp = [];
    print(data["callcards"].length);
    for (int i = 0; i < data["callcards"].length; i++) {
      _lastUpdated = DateTime.parse(data["lastUpdated"]);
      _Callcard _callcard = _Callcard(data["callcards"][i]);
      temp.add(_callcard);
    }

    _callcards = temp;
  }

  List<_Callcard> get callcards => _callcards;
  DateTime get last_updated => _lastUpdated;
}

class _Callcard {
  InfoModel _call_information;
  TeamModel _response_team;
  TimerModel _response_time;
  // _ResponseTime _response_time;
  // _SceneAssessment _scene_assessment;
  List<PatientModel> _patients = [];

  _Callcard(data) {
    // _call_information = _CallInformation.fromJson(data['call_information']);
    _call_information = InfoModel.fromJson(data['call_information']);
    _response_team = TeamModel.fromJson(data['response_team']);
    _response_time = TimerModel.fromJson(data['response_time']);
    // _response_time = _ResponseTime.fromJson(data['response_time']);
    // _scene_assessment = _SceneAssessment.fromJson(data['scene_asssessment']);

    // // _CallInformation(_call_information);
    for (int i = 0; i < data["patients"].length; i++) {
      // print(data["patients"]);
      // if (data["patients"][i] != null) {
      // PatientModel model = new data["patients"][i]);
      PatientModel _patientModel = PatientModel(data["patients"][i]);

      _patients.add(_patientModel);
      // }
    }
  }

  InfoModel get call_information => _call_information;
  TeamModel get response_team => _response_team;
  TimerModel get response_time => _response_time;
  // _SceneAssessment get scene_assessment => _scene_assessment;
  List<PatientModel> get patients => _patients;
}

// class _CallInformation {
//   String _callcard_no;
//   DateTime _call_received;
//   String _caller_contactno;
//   String _event_code;
//   String _priority;
//   String _incident_desc;
//   String _incident_location;
//   String _landmark;
//   String _location_type;
//   String _distance_toscene;
//   String _plate_no;
//   String _assign_id;

//   _CallInformation.fromJson(Map<String, dynamic> data) {
//     _callcard_no = data["callcard_no"];
//     _call_received = DateTime.parse(data["call_received"]);
//     _caller_contactno = data["caller_contactno"];
//     _event_code = data["event_code"];
//     _priority = data["priority"];
//     _incident_desc = data["incident_desc"];
//     _landmark = data["landmark"];
//     _location_type = data["location_type"];
//     _distance_toscene = data["distance_toscene"];
//     _plate_no = data["plate_no"];
//     _assign_id = data["assign_id"];
//   }

//   String get callcard_no => _callcard_no;
//   DateTime get call_received => _call_received;
//   String get caller_contact_no => _caller_contactno;
//   String get event_code => _event_code;
//   String get priority => _priority;
//   String get incident_description => _incident_desc;
//   String get landmark => _landmark;
//   String get location_type => _location_type;
//   String get distance_to_scene => _distance_toscene;
//   String get plate_no => _plate_no;
//   String get assign_id => _assign_id;
// }

// class _ResponseTeam {
//   String _service_response;
//   String _vehicle_regno;
//   List<_Staff> _staffs;

//   _ResponseTeam.fromJson(Map<String, dynamic> data) {
//     _service_response = data['service_response'];
//     _vehicle_regno = data["vehicle_regno"];

//     List<_Staff> temp_staff = [];
//     for (int i = 0; i < data["staffs"].length; i++) {
//       _Staff staff = _Staff(data["staffs"][i]);
//       temp_staff.add(staff);
//     }

//     _staffs = temp_staff;
//   }

//   String get service_response => _service_response;
//   String get vehicle_regno => _vehicle_regno;
//   List<_Staff> get staffs => _staffs;
// }

// class _Staff {
//   String _name;
//   String _position;

//   _Staff(data) {
//     _name = data["name"];
//     _position = data["position"];
//   }

//   String get name => _name;
//   String get position => _position;
// }

// class _ResponseTime {
//   DateTime _dispatch_time;
//   DateTime _enroute_time;
//   DateTime _atScene_time;
//   DateTime _atPatient_time;
//   DateTime _transporting_time;
//   DateTime _atHospital_time;
//   DateTime _reroute_time;
//   String _reason_abort;

//   _ResponseTime.fromJson(Map<String, dynamic> data) {
//     _dispatch_time = data["dispatch_time"];
//     _enroute_time = data["enroute_time"];
//     _atScene_time = data["atScene_time"];
//     _atPatient_time = data["atPatient_time"];
//     _transporting_time = data["transporting_time"];
//     _atHospital_time = data["atHospital_time"];
//     _reroute_time = data["reroute_time"];
//     _reason_abort = data["reason_abort"];
//   }

//   DateTime get dispatch_time => _dispatch_time;
//   DateTime get enroute_time => _enroute_time;
//   DateTime get at_scene_time => _atScene_time;
//   DateTime get at_patient_time => _atPatient_time;
//   DateTime get transporting_time => _transporting_time;
//   DateTime get at_hospital_time => _atHospital_time;
//   DateTime get reroute_time => _reroute_time;
//   String get reason_abort => _reason_abort;
// }

class _SceneAssessment {
  String _type_response;
  List<String> _other_services_atScene;

  _SceneAssessment.fromJson(Map<String, dynamic> data) {
    _type_response = data["type_response"];

    for (int i = 0; i < data["other_services_atScene"].length; i++) {
      _other_services_atScene.add(data["other_services_atScene"][i]);
    }
  }

  String get type_response => _type_response;
  List<String> get other_services_at_scene => _other_services_atScene;
}

// class _Patient {
//   List<_CPRLog> _cpr_logs;
//   _PatientInformation _patient_information;
//   _PatientAssesment _patient_assessment;
//   _TraumaAssessment _trauma_assessment;
//   _Intervention _intervention;
//   _Medication _medication;
//   List<_VitalSign> _vital_signs;
//   _IncidentReporting _incident_reporting;
//   _Outcome _outcome;

//   _Patient.fromJson(Map<String, dynamic> data) {
//     _patient_information =
//         _PatientInformation.fromJson(data["patient_information"]);
//     _patient_assessment =
//         _PatientAssesment.fromJson(data["patient_assessment"]);
//     _trauma_assessment = _TraumaAssessment.fromJson(data["trauma_assessment"]);
//     // _intervention = _Intervention.fromJson(data["intervention"]);
//     // _medication = _Medication.fromJson(data["medication"]);
//     // _incident_reporting =
//     //     _IncidentReporting.fromJson(data["incident_reporting"]);
//     // _outcome = _Outcome.fromJson(data["outcome"]);

//     List<_VitalSign> temp_vitals = [];
//     for (int i = 0; i < data["vital_signs"].length; i++) {
//       _VitalSign vital = _VitalSign(data["vital_signs"][i]);
//       temp_vitals.add(vital);
//     }

//     _vital_signs = temp_vitals;

//     List<_CPRLog> temp_cprlog = [];
//     for (int t = 0; t < data["cpr_logs"].length; t++) {
//       _CPRLog cprlog = _CPRLog(data["cpr_logs"][t]);
//       temp_cprlog.add(cprlog);
//     }

//     _cpr_logs = temp_cprlog;
//   }

//   _PatientInformation get patient_information => _patient_information;
//   _PatientAssesment get patient_assessment => _patient_assessment;
//   _TraumaAssessment get trauma_assessment => _trauma_assessment;
//   _Intervention get intevention => _intervention;
//   _Medication get medication => _medication;

//   List<_VitalSign> get vital_signs => _vital_signs;
//   List<_CPRLog> get cpr_logs => _cpr_logs;
// }

// class _CPRLog {
//   int _id;
//   DateTime _created;
//   List<_Log> _logs;

//   _CPRLog(data) {
//     _id = data["id"];
//     _created = data["created"];
//     List<_Log> temp_logs = [];
//     for (int i = 0; i < data["logs"].length; i++) {
//       _Log log = _Log(data["logs"][i]);
//       temp_logs.add(log);
//     }
//     _logs = temp_logs;
//   }
// }

// class _Log {
//   String _message;
//   DateTime _timestamp;

//   _Log(data) {
//     _message = data["message"];
//     _timestamp = data["timestamp"];
//   }

//   String get message => _message;
//   DateTime get timestamp => _timestamp;
// }

// class _PatientInformation {
//   String _name;
//   String _id_no;
//   String _id_type;
//   String _age;
//   String _dob;
//   String _gender;

//   _PatientInformation.fromJson(Map<String, dynamic> data) {
//     _name = data["name"];
//     _id_no = data["id_no"];
//     _id_type = data["id_type"];
//     _age = data["age"];
//     _dob = data["dob"];
//     _gender = data["gender"];
//   }

//   String get name => _name;
//   String get id_no => _id_no;
//   String get id_type => _id_type;
//   String get age => _age;
//   String get dob => _dob;
//   String get gender => _gender;
// }

// class _PatientAssesment {
//   String _disaster_triage;
//   String _apprearance;
//   String _level_responsive;
//   String _airway_patency;
//   String _heart_sound;
//   String _ecg;
//   String _abdomen_palpation;
//   String _abdomen_abnorm_location;
//   String _stroke_scale_face;
//   String _stroke_scale_arm;
//   String _stroke_scale_speech;

//   _Lung _air_entry;
//   _Lung _breath_sound;
//   List<String> _skin;

//   _PatientAssesment.fromJson(Map<String, dynamic> data) {
//     _disaster_triage = data["disaster_triage"];
//     _apprearance = data["appearance"];
//     _level_responsive = data["level_responsive"];
//     _airway_patency = data["airway_patency"];
//     _heart_sound = data["heart_sound"];
//     _ecg = data["ecg"];
//     _abdomen_palpation = data["abdomen_palpation"];
//     _abdomen_abnorm_location = data["abdomen_abnorm_location"];
//     _stroke_scale_face = data["stroke_scale_face"];
//     _stroke_scale_arm = data["stroke_scale_arm"];
//     _stroke_scale_speech = data["stroke_scale_speech"];

//     for (int i = 0; i < data["skin"].length; i++) {
//       _skin.add(data["skin"][i]);
//     }

//     _air_entry = _Lung(data);
//     _breath_sound = _Lung(data);
//   }
// }

// class _Lung {
//   String _right_lung;
//   String _left_lung;

//   _Lung(data) {
//     _right_lung = data["right_lung"];
//     _left_lung = data["left_lung"];
//   }

//   String get right_lung => _right_lung;
//   String get left_lung => _left_lung;
// }

// class _TraumaAssessment {
//   List<String> _head;
//   List<String> _face;
//   List<String> _neck;
//   List<String> _neck_abnorm_location;
//   List<String> _back;
//   List<String> _back_abnorm_location;
//   List<String> _spine;
//   List<String> _spine_abnorm_location;
//   List<String> _right_chest;
//   List<String> _left_chest;
//   _Abdomen _abdomen;
//   _Limb _limb;

//   _TraumaAssessment.fromJson(Map<String, dynamic> data) {
//     //head
//     List<String> temp_head = [];
//     for (int i = 0; i < data["head"].length; i++) {
//       temp_head.add(data["head"][i]);
//     }
//     _head = temp_head;

//     //face
//     List<String> temp_face = [];
//     for (int i = 0; i < data["face"].length; i++) {
//       temp_face.add(data["face"][i]);
//     }
//     _face = temp_face;

//     //neck
//     List<String> temp_neck = [];
//     for (int i = 0; i < data["neck"].length; i++) {
//       temp_neck.add(data["neck"][i]);
//     }
//     _neck = temp_neck;

//     //neck_abnorm_location
//     List<String> temp_nal = [];
//     for (int i = 0; i < data["neck_abnorm_location"].length; i++) {
//       temp_nal.add(data["neck_abnorm_location"][i]);
//     }
//     _neck_abnorm_location = temp_nal;

//     //back
//     List<String> temp_back = [];
//     for (int i = 0; i < data["back"].length; i++) {
//       temp_back.add(data["back"][i]);
//     }
//     _back = temp_back;

//     //back_abnorm_location
//     List<String> temp_bal = [];
//     for (int i = 0; i < data["back_abnorm_location"].length; i++) {
//       temp_bal.add(data["back_abnorm_location"][i]);
//     }
//     _back_abnorm_location = temp_bal;

//     //spine
//     List<String> temp_spine = [];
//     for (int i = 0; i < data["spine"].length; i++) {
//       temp_spine.add(data["spine"][i]);
//     }
//     _spine = temp_spine;

//     //spine_abnorm_location
//     List<String> temp_sal = [];
//     for (int i = 0; i < data["spine_abnorm_location"].length; i++) {
//       temp_sal.add(data["spine_abnorm_location"][i]);
//     }
//     _spine_abnorm_location = temp_sal;

//     //right_chest
//     List<String> temp_rchest = [];
//     for (int i = 0; i < data["right_chest"].length; i++) {
//       temp_rchest.add(data["right_chest"][i]);
//     }
//     _right_chest = temp_rchest;

//     //left_chest
//     List<String> temp_lchest = [];
//     for (int i = 0; i < data["left_chest"].length; i++) {
//       temp_lchest.add(data["left_chest"][i]);
//     }
//     _left_chest = temp_lchest;

//     _abdomen = _Abdomen(data["abdomen"]);
//     _limb = _Limb(data["limb"]);
//   }
// }

// class _Abdomen {
//   List<String> _right_upper_quadrant;
//   List<String> _left_upper_quadrant;
//   List<String> _right_lower_quadrant;
//   List<String> _left_lower_quadrant;

//   _Abdomen(data) {
//     //right_upper_quadrant
//     List<String> temp_ruq = [];
//     for (int i = 0; i < data["right_upper_quadrant"].length; i++) {
//       temp_ruq.add(data["right_upper_quadrant"][i]);
//     }
//     _right_upper_quadrant = temp_ruq;

//     //left_upper_quadrant
//     List<String> temp_luq = [];
//     for (int i = 0; i < data["left_upper_quadrant"].length; i++) {
//       temp_luq.add(data["left_upper_quadrant"][i]);
//     }
//     _left_upper_quadrant = temp_luq;

//     //right_lower_quadrant
//     List<String> temp_rlq = [];
//     for (int i = 0; i < data["right_lower_quadrant"].length; i++) {
//       temp_rlq.add(data["right_lower_quadrant"][i]);
//     }
//     _right_lower_quadrant = temp_rlq;

//     //left_lower_quadrant
//     List<String> temp_llq = [];
//     for (int i = 0; i < data["left_lower_quadrant"].length; i++) {
//       temp_llq.add(data["left_lower_quadrant"][i]);
//     }
//     _left_lower_quadrant = temp_llq;
//   }

//   List<String> get right_upper_quadrant => _right_upper_quadrant;
//   List<String> get left_upper_quadrant => _left_upper_quadrant;
//   List<String> get right_lower_quadrant => _right_lower_quadrant;
//   List<String> get left_lower_quadrant => _left_lower_quadrant;
// }

// class _Limb {
//   List<String> right_arm;
//   List<String> left_arm;
//   List<String> right_forearm;
//   List<String> left_forearm;
//   List<String> right_hand;
//   List<String> left_hand;
//   List<String> right_femur;
//   List<String> right_leg;
//   List<String> left_leg;
//   List<String> right_feet;
//   List<String> left_feet;

//   _Limb(data) {
//     //TODO: to be continue exhausted!!!
//   }
// }

// class _Intervention {
//   String airway_device;
//   String oxygen;
//   List<String> ext_haemorrhage;
//   List<String> vascular_access;
//   String vascular_access_location;

//   List<String> immobilization;
//   List<String> special_care;
// }

// class _Medication {
//   String name;
//   String dosage;
//   DateTime timestamp;
// }

// class _VitalSign {
//   int _id;
//   DateTime _created;
//   double _bp_systolic;
//   double _bp_diastolic;
//   double _map;
//   double _pr;
//   double _pulse_pressure;
//   String _pulse_volume;
//   String _crt;
//   double _shock_index;
//   double _rr;
//   double _spo2;
//   double _temp;
//   int _gcs_e;
//   int _gcs_v;
//   int _gcs_m;
//   int _gcs_total;
//   double _blood_glucose;
//   int _pain_score;
//   _Pupil _pupil;

//   _VitalSign(data) {
//     _id = data["id"];
//     _created = data["created"];
//     _bp_systolic = data["bp_systolic"];
//     _bp_diastolic = data["bp_diastolic"];
//     _map = data["map"];
//     _pr = data["pr"];
//     _pulse_pressure = data["pulse_pressure"];
//     _pulse_volume = data["pulse_volume"];
//     _crt = data["crt"];
//     _shock_index = data["shock_index"];
//     _rr = data["rr"];
//     _crt = data["crt"];
//     _spo2 = data["spo2"];
//     _temp = data["temp"];
//     _spo2 = data["spo2"];
//     _gcs_e = data["gcs_e"];
//     _gcs_v = data["gcs_v"];
//     _gcs_m = data["gcs_m"];
//     _gcs_total = data["gcs_total"];
//     _blood_glucose = data["blood_glucose"];
//     _pain_score = data["pain_score"];
//     _pupil = _Pupil(data["gcs_total"]);
//   }

//   int get id => _id;
//   DateTime get created => _created;
//   double get bp_systolic => _bp_systolic;
//   double get bp_diastolic => _bp_diastolic;
//   double get map => _map;
//   double get pr => _pr;
//   double get pulse_pressure => _pulse_pressure;
//   String get pulse_volume => _pulse_volume;
//   String get crt => _crt;
//   double get shock_index => _shock_index;
//   double get rr => _rr;
//   double get spo2 => _spo2;
//   double get temp => _temp;
//   int get gcs_e => _gcs_e;
//   int get gcs_v => _gcs_v;
//   int get gcs_m => _gcs_m;
//   int get gcs_total => _gcs_total;
//   double get blood_glucose => _blood_glucose;
//   int get pain_score => _pain_score;
//   _Pupil get pupil => _pupil;
// }

// class _Pupil {
//   int _left_size;
//   int _right_size;
//   String _left_response_tolight;
//   String _right_response_tolight;

//   _Pupil(data) {
//     _left_size = data["left_size"];
//     _right_size = data["right_size"];
//     _left_response_tolight = data["left_response_tolight"];
//     _right_response_tolight = data["right_response_tolight"];
//   }

//   int get left_size => _left_size;
//   int get right_size => _left_size;
//   String get left_response_to_light => _left_response_tolight;
//   String get right_response_to_light => _right_response_tolight;
// }

// class _IncidentReporting {
//   String response_delay;
//   String scene_delay;
//   String transport_delay;
// }

// class _Outcome {
//   String provision_diagnosis;
//   String etd_triage;
//   String transport_status;
//   String destination_facility;
//   String destination_facility_type;
//   String destination_justification;
//   String medical_direction_doctor_name;
//   String deterioration_transport;
// }
