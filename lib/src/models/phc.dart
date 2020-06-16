// To parse this JSON data, do
//
//     final phc = phcFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

Phc phcFromJson(String str) => Phc.fromJson(json.decode(str));

String phcToJson(Phc data) => json.encode(data.toJson());

class Phc extends Equatable {
  String lastUpdated;
  List<Callcard> callcards;

  Phc({
    this.lastUpdated,
    this.callcards,
  });

  factory Phc.fromJson(Map<String, dynamic> json) => Phc(
        lastUpdated: json["lastUpdated"],
        callcards: List<Callcard>.from(
            json["callcards"].map((x) => Callcard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lastUpdated": lastUpdated,
        "callcards": List<dynamic>.from(callcards.map((x) => x.toJson())),
      };

  List<Callcard> get listCallcards => callcards;
}

class Callcard {
  CallInformation callInformation;
  ResponseTeam responseTeam;
  ResponseTime responseTime;
  SceneAssessment sceneAssessment;
  List<Patient> patients;

  Callcard({
    this.callInformation,
    this.responseTeam,
    this.responseTime,
    this.sceneAssessment,
    this.patients,
  });

  factory Callcard.fromJson(Map<String, dynamic> json) => Callcard(
        callInformation: CallInformation.fromJson(json["call_information"]),
        responseTeam: ResponseTeam.fromJson(json["response_team"]),
        responseTime: ResponseTime.fromJson(json["response_time"]),
        sceneAssessment: SceneAssessment.fromJson(json["scene_assessment"]),
        patients: List<Patient>.from(
            json["patients"].map((x) => Patient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "call_information": callInformation.toJson(),
        "response_team": responseTeam.toJson(),
        "response_time": responseTime.toJson(),
        "scene_assessment": sceneAssessment.toJson(),
        "patients": List<dynamic>.from(patients.map((x) => x.toJson())),
      };

  CallInformation get call_information => callInformation;
  ResponseTeam get response_team => responseTeam;
  ResponseTime get response_time => responseTime;
  SceneAssessment get scene_assessment => sceneAssessment;
  List<Patient> get listPatients => patients;
}

class CallInformation {
  String callcardNo;
  String callReceived;
  String callerContactno;
  String eventCode;
  String priority;
  String incidentDesc;
  String incidentLocation;
  String landmark;
  String locationType;
  String distanceToScene;
  String plateNo;
  String assignId;

  CallInformation(
      {this.callcardNo,
      this.callReceived,
      this.callerContactno,
      this.eventCode,
      this.priority,
      this.incidentDesc,
      this.incidentLocation,
      this.landmark,
      this.locationType,
      this.distanceToScene,
      this.plateNo,
      this.assignId});

  factory CallInformation.fromJson(Map<String, dynamic> json) =>
      CallInformation(
          callcardNo: json["callcard_no"],
          callReceived: json["call_received"],
          callerContactno: json["caller_contactno"],
          eventCode: json["event_code"],
          priority: json["priority"],
          incidentDesc: json["incident_desc"],
          incidentLocation: json["incident_location"],
          landmark: json["landmark"],
          locationType: json["location_type"],
          distanceToScene: json["distance_to_scene"],
          plateNo: json["plate_no"],
          assignId: json["assign_id"]);

  Map<String, dynamic> toJson() => {
        "callcard_no": callcardNo,
        "call_received": callReceived,
        "caller_contactno": callerContactno,
        "event_code": eventCode,
        "priority": priority,
        "incident_desc": incidentDesc,
        "incident_location": incidentLocation,
        "landmark": landmark,
        "location_type": locationType,
        "distance_to_scene": distanceToScene,
        "plate_no": plateNo,
        "assign_id": assignId
      };

  String get callcard_no => callcardNo;
  String get call_received => callReceived;
  String get caller_contactno => callerContactno;
  String get event_code => eventCode;
  String get prioriti => priority;
  String get incident_desc => incidentDesc;
  String get incident_location => incidentLocation;
  String get landmarks => landmark;
  String get location_type => locationType;
  String get distance_to_scene => distanceToScene;
  String get plate_no => plateNo;
  String get assign_id => assignId;
}

class Patient {
  CPR cpr;
  PatientInformation patientInformation;
  PatientAssessment patientAssessment;
  TraumaAssessment traumaAssessment;
  MedicationAssessment medicationAssessment;
  InterventionAss intervention;
  // List<Medication> medication;
  List<VitalSign> vitalSigns;
  IncidentReporting incidentReporting;
  Outcome outcome;

  Patient({
    this.cpr,
    this.patientInformation,
    this.patientAssessment,
    this.traumaAssessment,
    this.medicationAssessment,
    this.intervention,
    this.vitalSigns,
    this.incidentReporting,
    this.outcome,
  });

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        cpr: (json["cpr_logs"] != null)
            ? CPR.fromJson(json["cpr_logs"])
            : new CPR(),
        patientInformation:
            PatientInformation.fromJson(json["patient_information"]),
        patientAssessment:
            PatientAssessment.fromJson(json["patient_assessment"]),
        traumaAssessment: TraumaAssessment.fromJson(json["trauma_assessment"]),
        intervention: InterventionAss.fromJson(json["intervention"]),
        medicationAssessment: MedicationAssessment.fromJson(json["medication"]),
        vitalSigns: (json["vital_signs"] != null)
            ? List<VitalSign>.from(
                json["vital_signs"].map((x) => VitalSign.fromJson(x)))
            : [],
        incidentReporting:
            IncidentReporting.fromJson(json["incident_reporting"]),
        outcome: Outcome.fromJson(json["outcome"]),
      );

  Map<String, dynamic> toJson() => {
        "cpr_logs": cpr.toJson(),
        // (cpr != null)
        // ? List<CprSection>.from(cprLogs.map((x) => x.toJson()))
        //     : [],
        // "cpr_logs": List<dynamic>.from(cprLogs.map((x) => x.toJson())),
        "patient_information": patientInformation.toJson(),
        "patient_assessment": patientAssessment.toJson(),
        "trauma_assessment": traumaAssessment.toJson(),
        "intervention": intervention.toJson(),
        "medication": medicationAssessment.toJson(),
        "vital_signs": List<dynamic>.from(vitalSigns.map((x) => x.toJson())),
        "incident_reporting": incidentReporting.toJson(),
        "outcome": outcome.toJson(),
      };
}

// class CprLog {
//   String id;
//   DateTime created;
//   List<LogMeasurement> logs;

//   CprLog({
//     this.id,
//     this.created,
//     this.logs,
//   });

//   factory CprLog.fromJson(Map<String, dynamic> json) => CprLog(
//         id: json["id"],
//         created: DateTime.parse(json["created"]),
//         logs:
//             List<LogMeasurement>.from(json["logs"].map((x) => Log.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created": created.toIso8601String(),
//         "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
//       };
// }

// class Log {
//   String message;
//   DateTime timestamp;

//   Log({
//     this.message,
//     this.timestamp,
//   });

//   factory Log.fromJson(Map<String, dynamic> json) => Log(
//         message: json["message"],
//         timestamp: DateTime.parse(json["timestamp"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "timestamp": timestamp.toIso8601String(),
//       };
// }

// class LogMeasurement {
//   String item;
//   String timestamp;
//   String measurement;

//   LogMeasurement({this.item, this.timestamp, this.measurement});

//   LogMeasurement.fromJson(Map<String, dynamic> json) {
//     item = json['item'];
//     timestamp = json['timestamp'];
//     measurement = json['measurement'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['item'] = this.item;
//     data['timestamp'] = this.timestamp;
//     data['measurement'] = this.measurement;
//     return data;
//   }
// }

class IncidentReporting {
  DateTime timestamp;
  String responseDelay;
  String sceneDelay;
  String transportDelay;

  IncidentReporting(
      {this.responseDelay,
      this.sceneDelay,
      this.transportDelay,
      this.timestamp});

  factory IncidentReporting.fromJson(Map<String, dynamic> json) =>
      IncidentReporting(
        timestamp: json["timestamp"],
        responseDelay: json["response_delay"],
        sceneDelay: json["scene_delay"],
        transportDelay: json["transport_delay"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "response_delay": responseDelay,
        "scene_delay": sceneDelay,
        "transport_delay": transportDelay,
      };
}

class InterventionAss {
  DateTime timestamp;
  String airwayDevice;
  String oxygen;
  List<String> extHaemorrhage;
  List<String> vascularAccess;
  String vascularAccessLocation;
  List<String> immobilization;
  List<String> specialCare;

  InterventionAss({
    this.timestamp,
    this.airwayDevice,
    this.oxygen,
    this.extHaemorrhage,
    this.vascularAccess,
    this.vascularAccessLocation,
    this.immobilization,
    this.specialCare,
  });

  factory InterventionAss.fromJson(Map<String, dynamic> json) =>
      InterventionAss(
        timestamp: json["timestamp"],
        airwayDevice: json["airway_device"],
        oxygen: json["oxygen"],
        extHaemorrhage:
            List<String>.from(json["ext_haemorrhage"].map((x) => x)),
        vascularAccess:
            List<String>.from(json["vascular_access"].map((x) => x)),
        vascularAccessLocation: json["vascular_access_location"],
        immobilization: List<String>.from(json["immobilization"].map((x) => x)),
        specialCare: List<String>.from(json["special_care"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "airway_device": airwayDevice,
        "oxygen": oxygen,
        "ext_haemorrhage": List<dynamic>.from(extHaemorrhage.map((x) => x)),
        "vascular_access": List<dynamic>.from(vascularAccess.map((x) => x)),
        "vascular_access_location": vascularAccessLocation,
        "immobilization": List<dynamic>.from(immobilization.map((x) => x)),
        "special_care": List<dynamic>.from(specialCare.map((x) => x)),
      };
}

// class Medication {
//   String name;
//   String dosage;
//   String timestamp;

//   Medication({
//     this.name,
//     this.dosage,
//     this.timestamp,
//   });

//   factory Medication.fromJson(Map<String, dynamic> json) => Medication(
//         name: json["name"],
//         dosage: json["dosage"],
//         timestamp: json["timestamp"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "dosage": dosage,
//         "timestamp": timestamp,
//       };
// }

class Outcome {
  DateTime timestamp;
  String provisionDiagnosis;
  String etdTriage;
  String transportStatus;
  String destinationFacility;
  String destinationFacilityType;
  String destinationJustification;
  String medicalDirectionDoctorName;
  String deteriorationTransport;

  Outcome({
    this.timestamp,
    this.provisionDiagnosis,
    this.etdTriage,
    this.transportStatus,
    this.destinationFacility,
    this.destinationFacilityType,
    this.destinationJustification,
    this.medicalDirectionDoctorName,
    this.deteriorationTransport,
  });

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        timestamp: json["timestamp"],
        provisionDiagnosis: json["provision_diagnosis"],
        etdTriage: json["etd_triage"],
        transportStatus: json["transport_status"],
        destinationFacility: json["destination_facility"],
        destinationFacilityType: json["destination_facility_type"],
        destinationJustification: json["destination_justification"],
        medicalDirectionDoctorName: json["medical_direction_doctor_name"],
        deteriorationTransport: json["deterioration_transport"],
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "provision_diagnosis": provisionDiagnosis,
        "etd_triage": etdTriage,
        "transport_status": transportStatus,
        "destination_facility": destinationFacility,
        "destination_facility_type": destinationFacilityType,
        "destination_justification": destinationJustification,
        "medical_direction_doctor_name": medicalDirectionDoctorName,
        "deterioration_transport": deteriorationTransport,
      };
}

class PatientAssessment {
  DateTime timestamp;
  String disasterTriage;
  String appearance;
  String levelResponsive;
  String airwayPatency;
  String respiratoryEffort;
  AirEntry airEntry;
  BreathSound breathSound;
  String heartSound;
  List<String> skin;
  String ecg;
  String abdomenPalpation;
  String abdomenAbnormalityLocation;
  StrokeScale strokeScale;

  PatientAssessment({
    this.timestamp,
    this.disasterTriage,
    this.appearance,
    this.levelResponsive,
    this.airwayPatency,
    this.respiratoryEffort,
    this.airEntry,
    this.breathSound,
    this.heartSound,
    this.skin,
    this.ecg,
    this.abdomenPalpation,
    this.abdomenAbnormalityLocation,
    this.strokeScale,
  });

  factory PatientAssessment.fromJson(Map<String, dynamic> json) =>
      PatientAssessment(
        timestamp: json["timestamp"],
        disasterTriage: json["disaster_triage"],
        appearance: json["appearance"],
        levelResponsive: json["level_responsive"],
        airwayPatency: json["airway_patency"],
        respiratoryEffort: json["respiratory_effort"],
        airEntry: AirEntry.fromJson(json["air_entry"]),
        breathSound: BreathSound.fromJson(json["breath_sound"]),
        heartSound: json["heart_sound"],
        skin: List<String>.from(json["skin"].map((x) => x)),
        ecg: json["ecg"],
        abdomenPalpation: json["abdomen_palpation"],
        abdomenAbnormalityLocation: json["abdomen_abnormality_location"],
        strokeScale: StrokeScale.fromJson(json["stroke_scale"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "disaster_triage": disasterTriage,
        "appearance": appearance,
        "level_responsive": levelResponsive,
        "airway_patency": airwayPatency,
        "respiratory_effort": respiratoryEffort,
        "air_entry": airEntry.toJson(),
        "breath_sound": breathSound.toJson(),
        "heart_sound": heartSound,
        "skin": List<dynamic>.from(skin.map((x) => x)),
        "ecg": ecg,
        "abdomen_palpation": abdomenPalpation,
        "abdomen_abnormality_location": abdomenAbnormalityLocation,
        "stroke_scale": strokeScale.toJson(),
      };
}

class AirEntry {
  String rightLung;
  String leftLung;

  AirEntry({
    this.rightLung,
    this.leftLung,
  });

  factory AirEntry.fromJson(Map<String, dynamic> json) => AirEntry(
        rightLung: json["right_lung"],
        leftLung: json["left_lung"],
      );

  Map<String, dynamic> toJson() => {
        "right_lung": rightLung,
        "left_lung": leftLung,
      };
}

class BreathSound {
  String rightLung;
  String leftLung;

  BreathSound({
    this.rightLung,
    this.leftLung,
  });

  factory BreathSound.fromJson(Map<String, dynamic> json) => BreathSound(
        rightLung: json["right_lung"],
        leftLung: json["left_lung"],
      );

  Map<String, dynamic> toJson() => {
        "right_lung": rightLung,
        "left_lung": leftLung,
      };
}

class StrokeScale {
  String face;
  String speech;
  String arm;

  StrokeScale({
    this.face,
    this.speech,
    this.arm,
  });

  factory StrokeScale.fromJson(Map<String, dynamic> json) => StrokeScale(
        face: json["face"],
        speech: json["speech"],
        arm: json["arm"],
      );

  Map<String, dynamic> toJson() => {
        "face": face,
        "speech": speech,
        "arm": arm,
      };
}

class PatientInformation {
  String name;
  String idNo;
  String idType;
  String age;
  String dob;
  String gender;

  PatientInformation({
    this.name,
    this.idNo,
    this.idType,
    this.age,
    this.dob,
    this.gender,
  });

  factory PatientInformation.fromJson(Map<String, dynamic> json) =>
      PatientInformation(
        name: json["name"],
        idNo: json["id_no"],
        idType: json["id_type"],
        age: json["age"],
        dob: json["dob"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id_no": idNo,
        "id_type": idType,
        "age": age,
        "dob": dob,
        "gender": gender,
      };

  String get nama => name;
  String get id_no => idNo;
  String get id_type => idType;
  String get ages => age;
  String get dateOfBirth => dob;
  String get jantina => gender;
}

class TraumaAssessment {
  DateTime timestamp;
  List<String> head;
  List<String> face;
  List<String> neck;
  List<String> neckAbnormalityLocation;
  List<String> back;
  List<String> backAbnormalityLocation;
  List<String> spine;
  List<String> spineAbnormalityLocation;
  List<String> rightChest;
  List<String> leftChest;
  Abdomen abdomen;
  Limb limb;

  TraumaAssessment({
    this.timestamp,
    this.head,
    this.face,
    this.neck,
    this.neckAbnormalityLocation,
    this.back,
    this.backAbnormalityLocation,
    this.spine,
    this.spineAbnormalityLocation,
    this.rightChest,
    this.leftChest,
    this.abdomen,
    this.limb,
  });

  factory TraumaAssessment.fromJson(Map<String, dynamic> json) =>
      TraumaAssessment(
          timestamp: json["timestamp"],
          head: List<String>.from(json["head"].map((x) => x)),
          face: List<String>.from(json["face"].map((x) => x)),
          neck: List<String>.from(json["neck"].map((x) => x)),
          neckAbnormalityLocation: List<String>.from(
              json["neck_abnormality_location"].map((x) => x)),
          back: List<String>.from(json["back"].map((x) => x)),
          backAbnormalityLocation: List<String>.from(
              json["back_abnormality_location"].map((x) => x)),
          spine: List<String>.from(json["spine"].map((x) => x)),
          spineAbnormalityLocation: List<String>.from(
              json["spine_abnormality_location"].map((x) => x)),
          rightChest: List<String>.from(json["right_chest"].map((x) => x)),
          leftChest: List<String>.from(json["left_chest"].map((x) => x)),
          abdomen: Abdomen.fromJson(json["abdomen"]),
          limb: Limb.fromJson(json["limb"]));

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "head": List<dynamic>.from(head.map((x) => x)),
        "face": List<dynamic>.from(face.map((x) => x)),
        "neck": List<dynamic>.from(neck.map((x) => x)),
        "neck_abnormality_location":
            List<dynamic>.from(neckAbnormalityLocation.map((x) => x)),
        "back": List<dynamic>.from(back.map((x) => x)),
        "back_abnormality_location":
            List<dynamic>.from(backAbnormalityLocation.map((x) => x)),
        "spine": List<dynamic>.from(spine.map((x) => x)),
        "spine_abnormality_location":
            List<dynamic>.from(spineAbnormalityLocation.map((x) => x)),
        "right_chest": List<dynamic>.from(rightChest.map((x) => x)),
        "left_chest": List<dynamic>.from(leftChest.map((x) => x)),
        "abdomen": abdomen.toJson(),
        "limb": limb.toJson(),
      };
}

class Limb {
  List<String> rightArm;
  List<String> leftArm;
  List<String> rightForearm;
  List<String> leftForearm;
  List<String> rightHand;
  List<String> leftHand;
  List<String> rightFemur;
  List<String> leftFemur;
  List<String> leftLeg;
  List<String> rightLeg;
  List<String> leftFeet;
  List<String> rightFeet;

  Limb(
      {this.rightArm,
      this.leftArm,
      this.rightForearm,
      this.leftForearm,
      this.rightHand,
      this.leftHand,
      this.rightFemur,
      this.leftFemur,
      this.leftLeg,
      this.rightLeg,
      this.leftFeet,
      this.rightFeet});

  Limb.fromJson(Map<String, dynamic> json) {
    rightArm = List<String>.from(json["right_arm"].map((x) => x));
    leftArm = List<String>.from(json["left_arm"].map((x) => x));
    rightForearm = List<String>.from(json["right_forearm"].map((x) => x));
    leftForearm = List<String>.from(json["left_forearm"].map((x) => x));
    rightHand = List<String>.from(json["right_hand"].map((x) => x));
    leftHand = List<String>.from(json["left_hand"].map((x) => x));
    rightFemur = List<String>.from(json["right_femur"].map((x) => x));
    leftFemur = List<String>.from(json["left_femur"].map((x) => x));
    leftLeg = List<String>.from(json["left_leg"].map((x) => x));
    rightLeg = List<String>.from(json["right_leg"].map((x) => x));
    leftFeet = List<String>.from(json["left_feet"].map((x) => x));
    rightFeet = List<String>.from(json["right_feet"].map((x) => x));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['right_arm'] = this.rightArm;
    data['left_arm'] = this.leftArm;
    data['right_forearm'] = this.rightForearm;
    data['left_forearm'] = this.leftForearm;
    data['right_hand'] = this.rightHand;
    data['left_hand'] = this.leftHand;
    data['right_femur'] = this.rightFemur;
    data['left_femur'] = this.leftFemur;
    data['left_leg'] = this.leftLeg;
    data['right_leg'] = this.rightLeg;
    data['left_feet'] = this.leftFeet;
    data['right_feet'] = this.rightFeet;
    return data;
  }
}

class Abdomen {
  List<String> rightUpperQuadrant;
  List<String> leftUpperQuadrant;
  List<String> rightLowerQuadrant;
  List<String> leftLowerQuadrant;

  Abdomen({
    this.rightUpperQuadrant,
    this.leftUpperQuadrant,
    this.rightLowerQuadrant,
    this.leftLowerQuadrant,
  });

  factory Abdomen.fromJson(Map<String, dynamic> json) => Abdomen(
        rightUpperQuadrant:
            List<String>.from(json["right_upper_quadrant"].map((x) => x)),
        leftUpperQuadrant:
            List<String>.from(json["left_upper_quadrant"].map((x) => x)),
        rightLowerQuadrant:
            List<String>.from(json["right_lower_quadrant"].map((x) => x)),
        leftLowerQuadrant:
            List<String>.from(json["left_lower_quadrant"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "right_upper_quadrant":
            List<dynamic>.from(rightUpperQuadrant.map((x) => x)),
        "left_upper_quadrant":
            List<dynamic>.from(leftUpperQuadrant.map((x) => x)),
        "right_lower_quadrant":
            List<dynamic>.from(rightLowerQuadrant.map((x) => x)),
        "left_lower_quadrant":
            List<dynamic>.from(leftLowerQuadrant.map((x) => x)),
      };
}

class MedicationAssessment {
  MedicationAssessment({
    this.timestamp,
    this.medication,
  });

  DateTime timestamp;
  List<Medication> medication;

  factory MedicationAssessment.fromJson(Map<String, dynamic> json) =>
      MedicationAssessment(
        timestamp: json["timestamp"],
        medication: List<Medication>.from(
            json["medication"].map((x) => Medication.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp,
        "medication": List<dynamic>.from(medication.map((x) => x.toJson())),
      };
}

class Medication {
  Medication({
    this.index,
    this.name,
    this.timestamp,
    this.dose,
  });

  int index;
  String name;
  String timestamp;
  String dose;

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
        index: json["index"],
        name: json["name"],
        timestamp: json["timestamp"],
        dose: json["dose"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "name": name,
        "timestamp": timestamp,
        "dose": dose,
      };
}

class VitalSign {
  String id;
  DateTime created;
  String bpSystolic;
  String bpDiastolic;
  String map;
  String pr;
  String pulsePressure;
  String pulseVolume;
  String crt;
  String shockIndex;
  String rr;
  String spo2;
  String temp;
  String e;
  String v;
  String m;
  String gcs;
  String bloodGlucose;
  String painScore;
  Pupil pupil;

  VitalSign({
    this.id,
    this.created,
    this.bpSystolic,
    this.bpDiastolic,
    this.map,
    this.pr,
    this.pulsePressure,
    this.pulseVolume,
    this.crt,
    this.shockIndex,
    this.rr,
    this.spo2,
    this.temp,
    this.e,
    this.v,
    this.m,
    this.gcs,
    this.bloodGlucose,
    this.painScore,
    this.pupil,
  });

  factory VitalSign.fromJson(Map<String, dynamic> json) => VitalSign(
        id: json["id"],
        created: DateTime.parse(json["created"]),
        bpSystolic: json["bp_systolic"],
        bpDiastolic: json["bp_diastolic"],
        map: json["map"],
        pr: json["pr"],
        pulsePressure: json["pulse_pressure"],
        pulseVolume: json["pulse_volume"],
        crt: json["crt"],
        shockIndex: json["shock_index"],
        rr: json["rr"],
        spo2: json["spo2"],
        temp: json["temp"],
        e: json["e"],
        v: json["v"],
        m: json["m"],
        gcs: json["gcs"],
        bloodGlucose: json["blood_glucose"],
        painScore: json["pain_score"],
        pupil: json['pupil'] != null ? new Pupil.fromJson(json['pupil']) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created.toIso8601String(),
        "bp_systolic": bpSystolic,
        "bp_diastolic": bpDiastolic,
        "map": map,
        "pr": pr,
        "pulse_pressure": pulsePressure,
        "pulse_volume": pulseVolume,
        "crt": crt,
        "shock_index": shockIndex,
        "rr": rr,
        "spo2": spo2,
        "temp": temp,
        "e": e,
        "v": v,
        "m": m,
        "gcs": gcs,
        "blood_glucose": bloodGlucose,
        "pain_score": painScore,

        //      if (this.pupil != null) {
        //   data['pupil'] = this.pupil.toJson();
        // }
        "pupil": (pupil != null) ? pupil.toJson() : null,
      };
}

class Pupil {
  String leftSize;
  String leftResponseTolight;
  String rightSize;
  String rightResponseTolight;

  Pupil({
    this.leftSize,
    this.leftResponseTolight,
    this.rightSize,
    this.rightResponseTolight,
  });

  factory Pupil.fromJson(Map<String, dynamic> json) => Pupil(
        leftSize: json["left_size"],
        leftResponseTolight: json["left_response_tolight"],
        rightSize: json["right_size"],
        rightResponseTolight: json["right_response_tolight"],
      );

  Map<String, dynamic> toJson() => {
        "left_size": leftSize,
        "left_response_tolight": leftResponseTolight,
        "right_size": rightSize,
        "right_response_tolight": rightResponseTolight,
      };
}

class ResponseTeam {
  String serviceResponse;
  String vehicleRegno;
  List<Staff> staffs;

  ResponseTeam({
    this.serviceResponse,
    this.vehicleRegno,
    this.staffs,
  });

  factory ResponseTeam.fromJson(Map<String, dynamic> json) => ResponseTeam(
        serviceResponse: json["service_response"],
        vehicleRegno: json["vehicle_regno"],
        staffs: json["staffs"] != null || json["staffs"] != ""
            ? List<Staff>.from(json["staffs"].map((x) => Staff.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "service_response": serviceResponse,
        "vehicle_regno": vehicleRegno,
        "staffs": staffs != null
            ? List<dynamic>.from(staffs.map((x) => x.toJson()))
            : [],
      };
}

class Staff {
  String name;
  String position;
  String userid;
  String password;
  String designation_code;

  Staff(
      {this.name,
      this.position,
      this.userid,
      this.password,
      this.designation_code});

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        name: json["name"],
        position: json["position"],
        userid: json["user_id"],
        password: json["user_password"],
        designation_code: json["designation_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "position": position,
        "userid": userid,
        "password": password,
        "designation_code": designation_code,
      };
}

DateTime parsingDateTime(data) {
  if (data == null) return null;
  var split = data.split(".");

  print(split[0]);
  var result = DateTime.parse(split[0]);

  return result;
}

class ResponseTime {
  DateTime dispatchTime;
  DateTime enrouteTime;
  DateTime atSceneTime;
  DateTime atPatientTime;
  DateTime transportingTime;
  DateTime atHospitalTime;
  DateTime rerouteTime;
  String reasonAbort;

  ResponseTime({
    this.dispatchTime,
    this.enrouteTime,
    this.atSceneTime,
    this.atPatientTime,
    this.transportingTime,
    this.atHospitalTime,
    this.rerouteTime,
    this.reasonAbort,
  });

  factory ResponseTime.fromJson(Map<String, dynamic> json) => ResponseTime(
        dispatchTime: parsingDateTime(json["dispatch_time"]),
        enrouteTime: parsingDateTime(json["enroute_time"]),
        atSceneTime: parsingDateTime(json["atScene_time"]),
        atPatientTime: parsingDateTime(json["atPatient_time"]),
        transportingTime: parsingDateTime(json["transporting_time"]),
        atHospitalTime: parsingDateTime(json["atHospital_time"]),
        rerouteTime: parsingDateTime(json["reroute_time"]),
        reasonAbort: json["reason_abort"],
      );

  Map<String, dynamic> toJson() => {
        "dispatch_time":
            (dispatchTime != null) ? dispatchTime.toString() : null,
        "enroute_time": (enrouteTime != null) ? enrouteTime.toString() : null,
        "atScene_time": (atSceneTime != null) ? atSceneTime.toString() : null,
        "atPatient_time":
            (atPatientTime != null) ? atPatientTime.toString() : null,
        "transporting_time":
            (transportingTime != null) ? transportingTime.toString() : null,
        "atHospital_time":
            (atHospitalTime != null) ? atHospitalTime.toString() : null,
        "reroute_time": (rerouteTime != null) ? rerouteTime.toString() : null,
        "reason_abort": reasonAbort,
      };
}

String transformTime(String time) {
  // assert(time != null);

  if (time == null || time == '')
    return '';
  else
    return time;
  // var result = time.substring(0, time.length - 2);
  // print(result);
  // return result;
}

class SceneAssessment {
  String typeResponse;
  List<String> otherServicesAtScene;

  SceneAssessment({
    this.typeResponse,
    this.otherServicesAtScene,
  });

  factory SceneAssessment.fromJson(Map<String, dynamic> json) =>
      SceneAssessment(
        typeResponse:
            json["type_response"] != null ? json["type_response"] : "",
        otherServicesAtScene: json["other_services_atScene"] != null
            ? List<String>.from(json["other_services_atScene"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "type_response": typeResponse != null ? typeResponse : "",
        "other_services_atScene":
            List<dynamic>.from(otherServicesAtScene.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class CPR {
  List<CprSection> cprLogs;

  CPR({this.cprLogs});

  CPR.fromJson(Map<String, dynamic> json) {
    if (json['cpr_logs'] != null) {
      cprLogs = new List<CprSection>();
      json['cpr_logs'].forEach((v) {
        cprLogs.add(new CprSection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cprLogs != null) {
      data['cpr_logs'] = this.cprLogs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CprSection {
  String timestamp;
  int id;
  String witnessCpr;
  String bystanderCpr;
  String cprStart;
  String rosc;
  String cprStop;
  Analysis shockable;
  Analysis nonShockable;
  Analysis other;
  List<String> logs;

  CprSection(
      {this.timestamp,
      this.id,
      this.witnessCpr,
      this.bystanderCpr,
      this.cprStart,
      this.cprStop,
      this.rosc,
      this.shockable,
      this.nonShockable,
      this.other,
      this.logs});

  CprSection.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    id = json['id'];
    shockable = json['shockable'] != null
        ? new Analysis.fromJson(json['shockable'])
        : null;
    nonShockable = json['nonShockable'] != null
        ? new Analysis.fromJson(json['nonShockable'])
        : null;
    other = json['other'] != null ? new Analysis.fromJson(json['other']) : null;
    logs = json['logs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['witness_cpr'] = this.witnessCpr;
    data['bystander_cpr'] = this.bystanderCpr;
    data['cpr_start'] = this.cprStart;
    data['cpr_stop'] = this.cprStop;
    data['rosc'] = this.rosc;
    data['id'] = this.id;
    if (this.shockable != null) {
      data['shockable'] = this.shockable.toJson();
    }
    if (this.nonShockable != null) {
      data['nonShockable'] = this.nonShockable.toJson();
    }
    if (this.other != null) {
      data['other'] = this.other.toJson();
    }
    data['logs'] = this.logs;
    return data;
  }
}

class Analysis {
  String id;
  String name;
  String rhythm;
  String intervention;
  String drugs;
  String airway;

  Analysis(
      {this.id,
      this.name,
      this.rhythm,
      this.intervention,
      this.drugs,
      this.airway});

  Analysis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rhythm = json['rhythm'];
    intervention = json['intervention'];
    drugs = json['drugs'];
    airway = json['airway'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rhythm'] = this.rhythm;
    data['intervention'] = this.intervention;
    data['drugs'] = this.drugs;
    data['airway'] = this.airway;
    return data;
  }
}

class ItemModel {
  String id;
  String name;
  String value;
  ItemModel({this.id, this.name, this.value});
}
