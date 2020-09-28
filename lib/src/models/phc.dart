// To parse this JSON data, do
//
//     final phc = phcFromJson(jsonString);

import 'dart:convert';

import 'package:phcapp/src/ui/tabs/patient/asessments/other_information.dart';

Phc phcFromJson(String str) => Phc.fromJson(json.decode(str));

String phcToJson(Phc data) => json.encode(data.toJson());

class Phc {
  Phc({
    this.callcards,
    this.lastUpdated,
  });

  List<Callcard> callcards;
  String lastUpdated;

  factory Phc.fromJson(Map<String, dynamic> json) => Phc(
        callcards: json["callcards"] != null
            ? List<Callcard>.from(
                json["callcards"].map((x) => Callcard.fromJson(x)))
            : null,
        lastUpdated: json["lastUpdated"],
      );

  Map<String, dynamic> toJson() => {
        "callcards": callcards != null
            ? List<dynamic>.from(callcards.map((x) => x.toJson()))
            : null,
        "lastUpdated": lastUpdated,
      };
}

class Callcard {
  Callcard({
    this.authorizedUser,
    this.callInformation,
    this.responseTime,
    this.responseTeam,
    this.sceneAssessment,
    this.patients,
  });

  String authorizedUser;
  CallInformation callInformation;
  ResponseTime responseTime;
  ResponseTeam responseTeam;
  SceneAssessment sceneAssessment;
  List<Patient> patients;

  factory Callcard.fromJson(Map<String, dynamic> json) => Callcard(
        authorizedUser: json["authorized_user"],
        callInformation: CallInformation.fromJson(json["call_information"]),
        responseTime: json["response_time"] != null
            ? ResponseTime.fromJson(json["response_time"])
            : new ResponseTime(),
        responseTeam: json["response_team"] != null
            ? ResponseTeam.fromJson(json["response_team"])
            : new ResponseTeam(),
        sceneAssessment: json["scene_assessment"] != null
            ? SceneAssessment.fromJson(json["scene_assessment"])
            : new SceneAssessment(),
        patients: json["patients"] != null
            ? List<Patient>.from(
                json["patients"].map((x) => Patient.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "authorized_user": authorizedUser,
        "call_information": callInformation.toJson(),
        "response_time": responseTime.toJson(),
        "response_team": responseTeam.toJson(),
        "scene_assessment": sceneAssessment.toJson(),
        "patients": patients != null
            ? List<dynamic>.from(patients.map((x) => x.toJson()))
            : null,
      };
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
  String updatedDate;

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
      this.assignId,
      this.updatedDate});

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
          assignId: json["assign_id"],
          updatedDate: json["updated_date"],
          );

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
        "assign_id": assignId,
        "updated_date": updatedDate
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
  String get updated_date => updatedDate;
}

class Patient {
  Patient(
      {this.cprLog,
      this.patientInformation,
      this.vitalSigns,
      this.patientAssessment,
      this.traumaAssessment,
      this.medicationAssessment,
      this.intervention,
      this.incidentReporting,
      this.outcome,
      this.samplerAssessment,
      this.otherAssessment});

  CprLog cprLog;
  PatientInformation patientInformation;
  List<VitalSign> vitalSigns;
  PatientAssessment patientAssessment;
  TraumaAssessment traumaAssessment;
  MedicationAssessment medicationAssessment;
  InterventionAss intervention;
  IncidentReporting incidentReporting;
  Outcome outcome;
  SamplerAssessment samplerAssessment;
  OtherAssessment otherAssessment;


  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        patientInformation:
            PatientInformation.fromJson(json["patient_information"]),
        vitalSigns: json["vital_signs"] == null
            ? null
            : List<VitalSign>.from(
                json["vital_signs"].map((x) => VitalSign.fromJson(x))),
        cprLog:
            json["cpr_log"] != null ? CprLog.fromJson(json["cpr_log"]) : null,
        patientAssessment: json["patient_assessment"] != null
            ? PatientAssessment.fromJson(json["patient_assessment"])
            : null,
        traumaAssessment: json["trauma_assessment"] != null
            ? TraumaAssessment.fromJson(json["trauma_assessment"])
            : null,
        intervention: json["intervention"] != null
            ? InterventionAss.fromJson(json["intervention"])
            : null,
        medicationAssessment: json["medication_assessment"] != null
            ? MedicationAssessment.fromJson(json["medication_assessment"])
            : null,
        incidentReporting: json["incident_reporting"] != null
            ? IncidentReporting.fromJson(json["incident_reporting"])
            : null,
        outcome:
            json["outcome"] != null ? Outcome.fromJson(json["outcome"]) : null,
        samplerAssessment:
            json["sampler_assessment"] != null ? SamplerAssessment.fromJson(json["sampler_assessment"]) : null,
        otherAssessment:
            json["other_information"] != null ? OtherAssessment.fromJson(json["other_information"]) : null
      );

  Map<String, dynamic> toJson() => {
        "cpr_log": cprLog != null ? cprLog.toJson() : null,
        "patient_information": patientInformation.toJson(),
        "vital_signs": vitalSigns == null
            ? null
            : List<dynamic>.from(vitalSigns.map((x) => x.toJson())),

        // "patient_information": patientInformation.toJson(),
        "patient_assessment":
            patientAssessment != null ? patientAssessment.toJson() : null,
        "trauma_assessment":
            traumaAssessment != null ? traumaAssessment.toJson() : null,
        "intervention": intervention != null ? intervention.toJson() : null,
        "medication_assessment":
            //     // null
            medicationAssessment != null ? medicationAssessment.toJson() : null,
        // // "vital_signs": List<dynamic>.from(vitalSigns.map((x) => x.toJson())),
        "incident_reporting":
            incidentReporting != null ? incidentReporting.toJson() : null,
        "outcome": outcome != null ? outcome.toJson() : null,
        "sampler_assessment": samplerAssessment != null ? samplerAssessment.toJson(): null,
        "other_information": otherAssessment != null ? otherAssessment.toJson(): null,
//
      };
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
  List<String> rightElbow;
  List<String> leftElbow;
  List<String> rightWrist;
  List<String> leftWrist;
  List<String> pelvic;
  List<String> rightHip;
  List<String> leftHip;
  List<String> rightKnee;
  List<String> leftKnee;
  List<String> rightAnkle;
  List<String> leftAnkle;

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
    this.rightElbow,
    this.leftElbow,
    this.rightWrist,
    this.leftWrist,
    this.pelvic,
    this.rightHip,
    this.leftHip,
    this.rightKnee,
    this.leftKnee,
    this.rightAnkle,
    this.leftAnkle,
  });

  factory TraumaAssessment.fromJson(Map<String, dynamic> json) =>
      TraumaAssessment(
          timestamp: parsingDateTime(json["timestamp"]),
          head: json["head"] != null
              ? List<String>.from(json["head"].map((x) => x))
              : null,
          face: json["face"] != null
              ? List<String>.from(json["face"].map((x) => x))
              : null,
          neck: json["neck"] != null
              ? List<String>.from(json["neck"].map((x) => x))
              : null,
          neckAbnormalityLocation: json["neck_abnormality_location"] != null
              ? List<String>.from(
                  json["neck_abnormality_location"].map((x) => x))
              : null,
          back: json["back"] != null
              ? List<String>.from(json["back"].map((x) => x))
              : null,
          backAbnormalityLocation: json["back_abnormality_location"] != null
              ? List<String>.from(
                  json["back_abnormality_location"].map((x) => x))
              : null,
          spine: json["spine"] != null
              ? List<String>.from(json["spine"].map((x) => x))
              : null,
          spineAbnormalityLocation: json["spine_abnormality_location"] != null
              ? List<String>.from(
                  json["spine_abnormality_location"].map((x) => x))
              : null,
          rightChest: json["right_chest"] != null
              ? List<String>.from(json["right_chest"].map((x) => x))
              : null,
          leftChest: json["left_chest"] != null
              ? List<String>.from(json["left_chest"].map((x) => x))
              : null,
          abdomen: Abdomen.fromJson(json["abdomen"]),
          limb: Limb.fromJson(json["limb"]),
          rightElbow: json["right_elbow"] != null
              ? List<String>.from(json["right_elbow"].map((x) => x))
              : null,
          leftElbow: json["left_elbow"] != null
              ? List<String>.from(json["left_elbow"].map((x) => x))
              : null,
          rightWrist: json["right_wrist"] != null
              ? List<String>.from(json["right_wrist"].map((x) => x))
              : null,
          leftWrist: json["left_wrist"] != null
              ? List<String>.from(json["left_wrist"].map((x) => x))
              : null,
          pelvic: json["pelvic"] != null
              ? List<String>.from(json["pelvic"].map((x) => x))
              : null,
          rightHip: json["right_hip"] != null
              ? List<String>.from(json["right_hip"].map((x) => x))
              : null,
          leftHip: json["left_hip"] != null
              ? List<String>.from(json["left_hip"].map((x) => x))
              : null,
          rightKnee: json["right_knee"] != null
              ? List<String>.from(json["right_knee"].map((x) => x))
              : null,
          leftKnee: json["left_knee"] != null
              ? List<String>.from(json["left_knee"].map((x) => x))
              : null,
          rightAnkle: json["right_ankle"] != null
              ? List<String>.from(json["right_ankle"].map((x) => x))
              : null,
          leftAnkle: json["left_ankle"] != null
              ? List<String>.from(json["left_ankle"].map((x) => x))
              : null);
          

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toString(),
        "head": head != null ? List<dynamic>.from(head.map((x) => x)) : null,
        "face": face != null ? List<dynamic>.from(face.map((x) => x)) : null,
        "neck": neck != null ? List<dynamic>.from(neck.map((x) => x)) : null,
        "neck_abnormality_location": neckAbnormalityLocation != null
            ? List<dynamic>.from(neckAbnormalityLocation.map((x) => x))
            : null,
        "back": back != null ? List<dynamic>.from(back.map((x) => x)) : null,
        "back_abnormality_location": backAbnormalityLocation != null
            ? List<dynamic>.from(backAbnormalityLocation.map((x) => x))
            : null,
        "spine": spine != null ? List<dynamic>.from(spine.map((x) => x)) : null,
        "spine_abnormality_location": spineAbnormalityLocation != null
            ? List<dynamic>.from(spineAbnormalityLocation.map((x) => x))
            : null,
        "right_chest": rightChest != null
            ? List<dynamic>.from(rightChest.map((x) => x))
            : null,
        "left_chest": leftChest != null
            ? List<dynamic>.from(leftChest.map((x) => x))
            : null,
        "abdomen": abdomen.toJson(),
        "limb": limb.toJson(),
         'right_elbow': rightElbow != null ? List<dynamic>.from(rightElbow.map((x) => x)) : null,
        'left_elbow': leftElbow != null ? List<dynamic>.from(leftElbow.map((x) => x)) : null,
        'right_wrist': rightWrist != null ? List<dynamic>.from(rightWrist.map((x) => x)) : null,
        'left_wrist': leftWrist != null ? List<dynamic>.from(leftWrist.map((x) => x)) : null,
        'pelvic': pelvic != null ? List<dynamic>.from(pelvic.map((x) => x)) : null,
        'right_hip': rightHip != null ? List<dynamic>.from(rightHip.map((x) => x)) : null,
        'left_hip': leftHip != null ? List<dynamic>.from(leftHip.map((x) => x)) : null,
        'right_knee': rightKnee != null ? List<dynamic>.from(rightKnee.map((x) => x)) : null,
        'left_knee': leftKnee != null ? List<dynamic>.from(leftKnee.map((x) => x)) : null,
        'right_ankle': rightAnkle != null ? List<dynamic>.from(rightAnkle.map((x) => x)) : null,
        'left_ankle': leftAnkle != null ? List<dynamic>.from(leftAnkle.map((x) => x)) : null,

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
    rightArm = json["right_arm"] != null
        ? List<String>.from(json["right_arm"].map((x) => x))
        : null;
    leftArm = json["left_arm"] != null
        ? List<String>.from(json["left_arm"].map((x) => x))
        : null;
    rightForearm = json["right_forearm"] != null
        ? List<String>.from(json["right_forearm"].map((x) => x))
        : null;
    leftForearm = json["left_forearm"] != null
        ? List<String>.from(json["left_forearm"].map((x) => x))
        : null;
    rightHand = json["right_hand"] != null
        ? List<String>.from(json["right_hand"].map((x) => x))
        : null;
    leftHand = json["left_hand"] != null
        ? List<String>.from(json["left_hand"].map((x) => x))
        : null;
    rightFemur = json["right_femur"] != null
        ? List<String>.from(json["right_femur"].map((x) => x))
        : null;
    leftFemur = json["left_femur"] != null
        ? List<String>.from(json["left_femur"].map((x) => x))
        : null;
    leftLeg = json["left_leg"] != null
        ? List<String>.from(json["left_leg"].map((x) => x))
        : null;
    rightLeg = json["right_leg"] != null
        ? List<String>.from(json["right_leg"].map((x) => x))
        : null;
    leftFeet = json["left_feet"] != null
        ? List<String>.from(json["left_feet"].map((x) => x))
        : null;
    rightFeet = json["right_feet"] != null
        ? List<String>.from(json["right_feet"].map((x) => x))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['right_arm'] = this.rightArm != null ? rightArm : null;
    data['left_arm'] = this.leftArm != null ? leftArm : null;
    data['right_forearm'] = this.rightForearm != null ? rightForearm : null;
    data['left_forearm'] = this.leftForearm != null ? leftForearm : null;
    data['right_hand'] = this.rightHand != null ? rightHand : null;
    data['left_hand'] = this.leftHand != null ? leftHand : null;
    data['right_femur'] = this.rightFemur != null ? rightFemur : null;
    data['left_femur'] = this.leftFemur != null ? leftFemur : null;
    data['left_leg'] = this.leftLeg != null ? leftLeg : null;
    data['right_leg'] = this.rightLeg != null ? rightLeg : null;
    data['left_feet'] = this.leftFeet != null ? leftFeet : null;
    data['right_feet'] = this.rightFeet != null ? rightFeet : null;
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
        rightUpperQuadrant: json["right_upper_quadrant"] != null
            ? List<String>.from(json["right_upper_quadrant"].map((x) => x))
            : null,
        leftUpperQuadrant: json["left_upper_quadrant"] != null
            ? List<String>.from(json["left_upper_quadrant"].map((x) => x))
            : null,
        rightLowerQuadrant: json["right_lower_quadrant"] != null
            ? List<String>.from(json["right_lower_quadrant"].map((x) => x))
            : null,
        leftLowerQuadrant: json["left_lower_quadrant"] != null
            ? List<String>.from(json["left_lower_quadrant"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "right_upper_quadrant": rightUpperQuadrant != null
            ? List<dynamic>.from(rightUpperQuadrant.map((x) => x))
            : null,
        "left_upper_quadrant": leftUpperQuadrant != null
            ? List<dynamic>.from(leftUpperQuadrant.map((x) => x))
            : null,
        "right_lower_quadrant": rightLowerQuadrant != null
            ? List<dynamic>.from(rightLowerQuadrant.map((x) => x))
            : null,
        "left_lower_quadrant": leftLowerQuadrant != null
            ? List<dynamic>.from(leftLowerQuadrant.map((x) => x))
            : null,
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
        timestamp: parsingDateTime(
          json["timestamp"],
        ),
        medication: json["medication"] != null
            ? List<Medication>.from(
                json["medication"].map((x) => Medication.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toString(),
        "medication": medication != null
            ? List<dynamic>.from(medication.map((x) => x.toJson()))
            : null,
      };
}

class Medication {
  Medication({this.index, this.name, this.timestamp, this.dose, this.route});

  int index;
  String name;
  String timestamp;
  String dose;
  String route;

  factory Medication.fromJson(Map<String, dynamic> json) => Medication(
        index: json["index"],
        name: json["name"],
        timestamp: json["timestamp"],
        dose: json["dose"],
        route: json["route"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "name": name,
        "timestamp": timestamp,
        "dose": dose,
        "route": route,
      };
}

// To parse this JSON data, do
//
//     final cprLog = cprLogFromJson(jsonString);

class CprLog {
  CprLog({
    this.witnessCpr,
    this.bystanderCpr,
    this.dnar,
    this.cprStart,
    this.rosc,
    this.cprStop,
    this.rhythmAnalysis,
    this.log,
    this.cprOutcome,
  });

  Log log;
  Cpr witnessCpr;
  Cpr bystanderCpr;
  Cpr dnar;
  Cpr cprStart;
  Cpr rosc;
  Cpr cprStop;
  List<RhythmAnalysis> rhythmAnalysis;
  CPROutcome cprOutcome;


  factory CprLog.fromJson(Map<String, dynamic> json) => CprLog(
        witnessCpr: json["witness_cpr"] != null
            ? Cpr.fromJson(json["witness_cpr"])
            : null,
        bystanderCpr: json["bystander_cpr"] != null
            ? Cpr.fromJson(json["bystander_cpr"])
            : null,
        dnar: json["dnar"] != null
            ? Cpr.fromJson(json["dnar"])
            : null,    
        cprStart:
            json["cpr_start"] != null ? Cpr.fromJson(json["cpr_start"]) : null,
        rosc: json["rosc"] != null ? Cpr.fromJson(json["rosc"]) : null,
        cprStop:
            json["cpr_stop"] != null ? Cpr.fromJson(json["cpr_stop"]) : null,
        rhythmAnalysis: json["rhythm_analysis"] != null
            ? List<RhythmAnalysis>.from(
                json["rhythm_analysis"].map((x) => RhythmAnalysis.fromJson(x)))
            : null,
        log: json["log_in_cpr"] != null
              ? Log.fromJson(json["log_in_cpr"])
              : null,
        cprOutcome: json["cpr_outcome"] != null 
                    ? CPROutcome.fromJson(json["cpr_outcome"])
                    : null,
      );

  Map<String, dynamic> toJson() => {
        "witness_cpr": witnessCpr != null ? witnessCpr.toJson() : null,
        "bystander_cpr": bystanderCpr != null ? bystanderCpr.toJson() : null,
        "dnar": dnar != null ? dnar.toJson() : null,
        "cpr_start": cprStart != null ? cprStart.toJson() : null,
        "rosc": rosc != null ? rosc.toJson() : null,
        "cpr_stop": cprStop != null ? cprStop.toJson() : null,
        "rhythm_analysis": rhythmAnalysis != null
            ? List<dynamic>.from(rhythmAnalysis.map((x) => x.toJson()))
            : [],    
        "log_in_cpr": log != null ? log.toJson() : null,
        "cpr_outcome": cprOutcome != null ? cprOutcome.toJson() : null,
      };
}

class Cpr {
  Cpr({
    this.value,
    this.timestamp,
  });

  String value;
  String timestamp;

  factory Cpr.fromJson(Map<String, dynamic> json) => Cpr(
        value: json["value"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "timestamp": timestamp,
      };
}

class CPROutcome{
  CPROutcome({
    this.value,
    this.transported,
    this.tor
  });

  List<String> value = new List<String>();
  String transported;
  String tor;

  factory CPROutcome.fromJson(Map<String, dynamic> json) =>
      CPROutcome(
        value: json["value"] != null
            ? List<String>.from(json["value"].map((x) => x))
            : null,
        transported: json["transported"],
        tor: json["tor"],
      );

  Map<String, dynamic> toJson() => {
        "value": value != null
            ? List<dynamic>.from(value.map((x) => x))
            : null,
        "transported": transported != null ? transported : "",
        "tor": tor != null ? tor : "",
  };
}

class Log{

  String reason;
  List<String> value;

  Log({
    this.reason,
    this.value,
  });

  factory Log.fromJson(Map<String, dynamic> json) =>
      Log(
        value: json["value"] != null
            ? List<String>.from(json["value"].map((x) => x))
            : null,
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "value": value != null
            ? List<dynamic>.from(value.map((x) => x))
            : null,
        "reason": reason != null ? reason : "",
      };
}

class RhythmAnalysis {
  RhythmAnalysis({
    this.id,
    this.timestamp,
    this.rhythm,  
    this.shockable,
    this.nonShockable,
    this.other,
  });

  String id;
  DateTime timestamp;
  String rhythm;
  Analysis shockable;
  Analysis nonShockable;
  Analysis other;

  factory RhythmAnalysis.fromJson(Map<String, dynamic> json) => RhythmAnalysis(
        id: json["id"],
        timestamp: parsingDateTime(json["timestamp"]),
        rhythm: json["rhythm"],
        shockable: json["shockable"] != null
            ? Analysis.fromJson(json["shockable"])
            : null,
        nonShockable: json["non_shockable"] != null
            ? Analysis.fromJson(json["non_shockable"])
            : null,
        other: json["other"] != null ? Analysis.fromJson(json["other"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id:": id,
        "timestamp": timestamp.toString(),
        "rhythm": rhythm,
        "shockable": shockable != null ? shockable.toJson() : null,
        "non_shockable": nonShockable != null ? nonShockable.toJson() : null,
        "other": other != null ? other.toJson() : null,
      };
}

class Analysis {
  Analysis({
    this.timestamp,
    this.rhythm,
    this.intervention,
    this.drugs,
    this.airway,
  });

  DateTime timestamp;
  Cpr rhythm;
  Cpr intervention;
  Cpr drugs;
  Cpr airway;

  factory Analysis.fromJson(Map<String, dynamic> json) => Analysis(
        timestamp: parsingDateTime(json["timestamp"]),
        rhythm: json["rhythm"] != null ? Cpr.fromJson(json["rhythm"]) : null,
        intervention: json["intervention"] != null
            ? Cpr.fromJson(json["intervention"])
            : null,
        drugs: json["drugs"] != null ? Cpr.fromJson(json["drugs"]) : null,
        airway: json["airway"] != null ? Cpr.fromJson(json["airway"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp != null ? timestamp.toString() : null,
        "rhythm": rhythm != null ? rhythm.toJson() : null,
        "intervention": intervention != null ? intervention.toJson() : null,
        "drugs": drugs != null ? drugs.toJson() : null,
        "airway": airway != null ? airway.toJson() : null,
      };
}

class IncidentReporting {
  DateTime timestamp;
  List<String> responseDelay;
  String othersResponse;
  List<String> sceneDelay;
  String othersScene;
  List<String> transportDelay;
  String othersTransport;

  IncidentReporting(
      {this.responseDelay,
      this.othersResponse,
      this.sceneDelay,
      this.othersScene,
      this.transportDelay,
      this.othersTransport,
      this.timestamp});

  factory IncidentReporting.fromJson(Map<String, dynamic> json) =>
      IncidentReporting(
        timestamp: parsingDateTime(json["timestamp"]),
        responseDelay: json['response_delay'] is List
                      ? List<String>.from(json['response_delay'].map((x) => x))
                      : [json['response_delay']],
        othersResponse: json['others_response'] != null
                        ? json['others_response']
                        : null,
        sceneDelay: json['scene_delay'] is List
                      ? List<String>.from(json['scene_delay'].map((x) => x))
                      : [json['scene_delay']],
        othersScene: json['others_scene'] != null
                        ? json['others_scene']
                        : null,
        transportDelay: json['transport_delay'] is List
                      ? List<String>.from(json['transport_delay'].map((x) => x))
                      : [json['transport_delay']],
        othersTransport: json['others_transport'] != null
                        ? json['others_transport']
                        : null,
      );
  // print("Incident reporting ... done");
  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toString(),
        "response_delay": responseDelay != null
            ? List<dynamic>.from(responseDelay.map((x) => x))
            : null,
        "others_response": othersResponse,
        "scene_delay": sceneDelay != null
            ? List<dynamic>.from(sceneDelay.map((x) => x))
            : null,
        "others_scene": othersScene,
        "transport_delay": transportDelay != null
            ? List<dynamic>.from(transportDelay.map((x) => x))
            : null,
        "others_transport": othersTransport
      };
}

class InterventionAss {
  DateTime timestamp;
  List<String> airwayDevice;
  List<String> oxygen;
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

  factory InterventionAss.fromJson(Map<String, dynamic> json){
      

      return new
      InterventionAss(
        timestamp: parsingDateTime(json["timestamp"]),
        airwayDevice: json['airway_device'] is List
                      ? List<String>.from(json['airway_device'].map((x) => x))
                      : [json['airway_device']],
        oxygen: json['oxygen'] is List
                      ? List<String>.from(json['oxygen'].map((x) => x))
                      : [json['oxygen']],
        extHaemorrhage: json["ext_haemorrhage"] != null
              ? List<String>.from(json["ext_haemorrhage"].map((x) => x))
              : null,
        vascularAccess: json["vascular_access"] != null
            ? List<String>.from(json["vascular_access"].map((x) => x))
            : null,
        vascularAccessLocation: json["vascular_access_location"],
        immobilization: json["immobilization"] != null
            ? List<String>.from(json["immobilization"].map((x) => x))
            : null,
        specialCare: json["special_care"] != null
            ? List<String>.from(json["special_care"].map((x) => x))
            : null,
      );
  }

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toString(),
        "airway_device": airwayDevice != null
            ? List<dynamic>.from(airwayDevice.map((x) => x))
            : null,
        "oxygen": oxygen != null
            ? List<dynamic>.from(oxygen.map((x) => x))
            : null,
        "ext_haemorrhage": extHaemorrhage != null
            ? List<dynamic>.from(extHaemorrhage.map((x) => x))
            : null,
        "vascular_access": vascularAccess != null
            ? List<dynamic>.from(vascularAccess.map((x) => x))
            : null,
        "vascular_access_location": vascularAccessLocation,
        "immobilization": immobilization != null
            ? List<dynamic>.from(immobilization.map((x) => x))
            : null,
        "special_care": specialCare != null
            ? List<dynamic>.from(specialCare.map((x) => x))
            : null,
      };
}

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
        timestamp: parsingDateTime(json["timestamp"]),
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
        "timestamp": timestamp.toString(),
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
  List<String> appearance;
  String levelResponsive;
  List<String> airwayPatency;
  List<String> respiratoryEffort;
  AirEntry airEntry;
  BreathSound breathSound;
  String heartSound;
  List<String> skin;
  List<String> ecg;
  List<String> abdomenPalpation;
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
        timestamp: parsingDateTime(json["timestamp"]),
        disasterTriage: json["disaster_triage"],
        appearance: json["appearance"] is List
                      ? List<String>.from(json["appearance"].map((x) => x))
                      : [json["appearance"]],
        levelResponsive: json["level_responsive"],
        airwayPatency: json["airway_patency"] is List
                      ? List<String>.from(json["airway_patency"].map((x) => x))
                      : [json["airway_patency"]],
        respiratoryEffort: json["respiratory_effort"] is List
                      ? List<String>.from(json["respiratory_effort"].map((x) => x))
                      : [json["respiratory_effort"]],
        airEntry: AirEntry.fromJson(json["air_entry"]),
        breathSound: BreathSound.fromJson(json["breath_sound"]),
        heartSound: json["heart_sound"],
        skin: json["skin"] != null
            ? List<String>.from(json["skin"].map((x) => x))
            : null,
        ecg: json["ecg"] is List
                      ? List<String>.from(json["ecg"].map((x) => x))
                      : [json["ecg"]],
        abdomenPalpation: json["abdomen_palpation"] is List
                      ? List<String>.from(json["abdomen_palpation"].map((x) => x))
                      : [json["abdomen_palpation"]],
        abdomenAbnormalityLocation: json["abdomen_abnormality_location"],
        strokeScale: StrokeScale.fromJson(json["stroke_scale"]),
      );

  Map<String, dynamic> toJson() => {
        "timestamp": timestamp.toString(),
        "disaster_triage": disasterTriage,
        "appearance": appearance != null
            ? List<dynamic>.from(appearance.map((x) => x))
            : null,
        "level_responsive": levelResponsive,
        "airway_patency": airwayPatency != null
            ? List<dynamic>.from(airwayPatency.map((x) => x))
            : null,
        "respiratory_effort": respiratoryEffort != null
            ? List<dynamic>.from(respiratoryEffort.map((x) => x))
            : null,
        "air_entry": airEntry.toJson(),
        "breath_sound": breathSound.toJson(),
        "heart_sound": heartSound,
        "skin": skin != null ? List<dynamic>.from(skin.map((x) => x)) : null,
        "ecg": ecg != null
            ? List<dynamic>.from(ecg.map((x) => x))
            : null,
        "abdomen_palpation": abdomenPalpation != null
            ? List<dynamic>.from(abdomenPalpation.map((x) => x))
            : null,
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
  List<String> face;
  List<String> speech;
  List<String> arm;
  List<String> balance;
  List<String> eyesight;

  StrokeScale({
    this.face,
    this.speech,
    this.arm,
    this.balance,
    this.eyesight
  });

  factory StrokeScale.fromJson(Map<String, dynamic> json) => StrokeScale(
        face: json["face"] is List
                      ? List<String>.from(json["face"].map((x) => x))
                      : [json["face"]],
        speech: json["speech"] is List
                      ? List<String>.from(json["speech"].map((x) => x))
                      : [json["speech"]],
        arm: json["arm"] is List
                      ? List<String>.from(json["arm"].map((x) => x))
                      : [json["arm"]],
        balance: json["balance"] is List
                      ? List<String>.from(json["balance"].map((x) => x))
                      : [json["balance"]],
        eyesight: json["eyesight"] is List
                      ? List<String>.from(json["eyesight"].map((x) => x))
                      : [json["eyesight"]]
      );

  Map<String, dynamic> toJson() => {
        "face": face != null
            ? List<dynamic>.from(face.map((x) => x))
            : null,
        "speech": speech != null
            ? List<dynamic>.from(speech.map((x) => x))
            : null,
        "arm": arm != null
            ? List<dynamic>.from(arm.map((x) => x))
            : null,
        "balance": balance != null
            ? List<dynamic>.from(balance.map((x) => x))
            : null,
        "eyesight": eyesight != null
            ? List<dynamic>.from(eyesight.map((x) => x))
            : null
      };
}

class PatientInformation {
  PatientInformation({
    this.name,
    this.idNo,
    this.idType,
    this.dob,
    this.age,
    this.gender,
  });

  String name;
  String idNo;
  String idType;
  String dob;
  String age;
  String gender;

  factory PatientInformation.fromJson(Map<String, dynamic> json) =>
      PatientInformation(
        name: json["name"] == null ? null : json["name"],
        idNo: json["id_no"] == null ? null : json["id_no"],
        idType: json["id_type"] == null ? null : json["id_type"],
        dob: json["dob"] == null ? null : json["dob"],
        age: json["age"] == null ? null : json["age"],
        gender: json["gender"] == null ? null : json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id_no": idNo == null ? null : idNo,
        "id_type": idType == null ? null : idType,
        "dob": dob == null ? null : dob,
        "age": age == null ? null : age,
        "gender": gender == null ? null : gender,
      };
}

class ItemModel {
  String id;
  String name;
  String value;
  ItemModel({this.id, this.name, this.value});
}

class VitalSign {
  VitalSign({
    this.e,
    this.m,
    this.v,
    this.id,
    this.pr,
    this.rr,
    this.crt,
    this.gcs,
    this.map,
    this.spo2,
    this.temp,
    this.pupil,
    this.created,
    this.painScore,
    this.bpSystolic,
    this.shockIndex,
    this.bpDiastolic,
    this.pulseVolume,
    this.bloodGlucose,
    this.bloodKetone,
    this.pulsePressure,
  });

  String e;
  String m;
  String v;
  String id;
  String pr;
  String rr;
  String crt;
  String gcs;
  String map;
  String spo2;
  String temp;
  Pupil pupil;
  DateTime created;
  String painScore;
  String bpSystolic;
  String shockIndex;
  String bpDiastolic;
  String pulseVolume;
  String bloodGlucose;
  String bloodKetone;
  String pulsePressure;

  factory VitalSign.fromJson(Map<String, dynamic> json) => VitalSign(
        e: json["e"] == null ? null : json["e"],
        m: json["m"] == null ? null : json["m"],
        v: json["v"] == null ? null : json["v"],
        id: json["id"],
        pr: json["pr"] == null ? null : json["pr"],
        rr: json["rr"] == null ? null : json["rr"],
        crt: json["crt"] == null ? null : json["crt"],
        gcs: json["gcs"] == null ? null : json["gcs"],
        map: json["map"] == null ? null : json["map"],
        spo2: json["spo2"] == null ? null : json["spo2"],
        temp: json["temp"] == null ? null : json["temp"],
        pupil: Pupil.fromJson(json["pupil"]),
        created: parsingDateTime(json["created"]),
        painScore: json["pain_score"] == null ? null : json["pain_score"],
        bpSystolic: json["bp_systolic"],
        shockIndex: json["shock_index"] == null ? null : json["shock_index"],
        bpDiastolic: json["bp_diastolic"] == null ? null : json["bp_diastolic"],
        pulseVolume: json["pulse_volume"] == null ? null : json["pulse_volume"],
        bloodGlucose:
            json["blood_glucose"] == null ? null : json["blood_glucose"],
        bloodKetone: json["blood_ketone"] == null ? null : json["blood_ketone"],
        pulsePressure:
            json["pulse_pressure"] == null ? null : json["pulse_pressure"],
      );

  Map<String, dynamic> toJson() => {
        "e": e == null ? null : e,
        "m": m == null ? null : m,
        "v": v == null ? null : v,
        "id": id,
        "pr": pr == null ? null : pr,
        "rr": rr == null ? null : rr,
        "crt": crt == null ? null : crt,
        "gcs": gcs == null ? null : gcs,
        "map": map == null ? null : map,
        "spo2": spo2 == null ? null : spo2,
        "temp": temp == null ? null : temp,
        "pupil": pupil.toJson(),
        "created": created.toIso8601String(),
        "pain_score": painScore == null ? null : painScore,
        "bp_systolic": bpSystolic,
        "shock_index": shockIndex == null ? null : shockIndex,
        "bp_diastolic": bpDiastolic == null ? null : bpDiastolic,
        "pulse_volume": pulseVolume == null ? null : pulseVolume,
        "blood_glucose": bloodGlucose == null ? null : bloodGlucose,
        "blood_ketone": bloodKetone == null ? null : bloodKetone,
        "pulse_pressure": pulsePressure == null ? null : pulsePressure,
      };
}

class Pupil {
  Pupil({
    this.leftSize,
    this.rightSize,
    this.leftResponseTolight,
    this.rightResponseTolight,
  });

  String leftSize;
  String rightSize;
  String leftResponseTolight;
  String rightResponseTolight;

  factory Pupil.fromJson(Map<String, dynamic> json) => Pupil(
        leftSize: json["left_size"] == null ? null : json["left_size"],
        rightSize: json["right_size"],
        leftResponseTolight: json["left_response_tolight"] == null
            ? null
            : json["left_response_tolight"],
        rightResponseTolight: json["right_response_tolight"] == null
            ? null
            : json["right_response_tolight"],
      );

  Map<String, dynamic> toJson() => {
        "left_size": leftSize == null ? null : leftSize,
        "right_size": rightSize,
        "left_response_tolight":
            leftResponseTolight == null ? null : leftResponseTolight,
        "right_response_tolight":
            rightResponseTolight == null ? null : rightResponseTolight,
      };
}

class ResponseTeam {
  ResponseTeam({
    this.staffs,
    this.vehicleRegno,
    this.serviceResponse,
  });

  List<Staff> staffs;
  String vehicleRegno;
  String serviceResponse;

  factory ResponseTeam.fromJson(Map<String, dynamic> json) => ResponseTeam(
        staffs: json["staffs"] != null
            ? List<Staff>.from(json["staffs"].map((x) => Staff.fromJson(x)))
            : null,
        vehicleRegno:
            json["vehicle_regno"] == null ? null : json["vehicle_regno"],
        serviceResponse:
            json["service_response"] == null ? null : json["service_response"],
      );

  Map<String, dynamic> toJson() => {
        "staffs": staffs != null
            ? List<dynamic>.from(staffs.map((x) => x.toJson()))
            : null,
        "vehicle_regno": vehicleRegno == null ? null : vehicleRegno,
        "service_response": serviceResponse == null ? null : serviceResponse,
      };
}

enum ServiceResponse { SUPERVISOR_VEHICLE, THE_999_SECONDARY, THE_999_PRIMARY }

final serviceResponseValues = EnumValues({
  "Supervisor Vehicle": ServiceResponse.SUPERVISOR_VEHICLE,
  "999 Primary": ServiceResponse.THE_999_PRIMARY,
  "999 Secondary": ServiceResponse.THE_999_SECONDARY
});

class Staff {
  Staff(
      {this.name,
      this.userId,
      this.position,
      this.designationCode,
      this.password});

  String name;
  String userId;
  String position;
  String designationCode;
  String password;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        name: json["name"] == null ? null : json["name"],
        userId: json["user_id"] == null ? null : json["user_id"],
        position: json["position"] == null ? null : json["position"],
        designationCode:
            json["designation_code"] == null ? null : json["designation_code"],
        password: json["user_password"] == null ? null : json["user_password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "user_id": userId == null ? null : userId,
        "position": position == null ? null : position,
        "designation_code": designationCode == null ? null : designationCode,
        "user_password": password == null ? null : password,
      };
}

DateTime parsingDateTime(data) {
  if (data == null || data == "null") return null;
  var split = data.split(".");

  // print("---timestamp----");
  // print(split[0]);
  // print("---------------");
  if (split[0] != "") {
    return DateTime.parse(split[0]);
  } else {
    print("What you found exactly");
    print(split[0]);
  }

  return null;
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

class SceneAssessment {
  SceneAssessment({
    this.ppe,
    this.environment,
    this.caseType,
    this.patient,
    this.backup,
    this.otherServicesAtScene,
  });
  PPE ppe;
  String environment;
  String caseType;
  String patient;
  String backup;
  OtherServices otherServicesAtScene;

  factory SceneAssessment.fromJson(Map<String, dynamic> json){

      return
      SceneAssessment(
        ppe: json["ppe"] is List 
             ? PPE.fromJson(json)
             : PPE.fromJson(json["ppe"]),
        environment: json["environment"] != null
            ? json["environment"] is List 
            ? json["environment"].length > 0
            ? json["environment"][0]
            : ""
            : json["environment"]
            : null,
        caseType: json["case_type"] != null
            ? json["case_type"] is List 
            ? json["case_type"].length > 0
            ? json["case_type"][0]
            : ""
            : json["case_type"]
            : null,
        patient: json["patient"] != null
            ? json["patient"] is List 
            ? json["patient"].length > 0
            ? json["patient"][0]
            : ""
            : json["patient"]
            : null,
        backup: json["backup"] != null
            ? json["backup"] is List 
            ? json["backup"].length > 0
            ? json["backup"][0]
            : ""
            : json["backup"]
            : null,
        otherServicesAtScene: json["other_services_atScene"] is List 
             ? OtherServices.fromJson(json)
             : OtherServices.fromJson(json["other_services_atScene"]),       
      );
  }

  Map<String, dynamic> toJson() => {
       "ppe": ppe == null
            ? null
            : ppe.toJson(),
        "environment": environment == null
            ? null
            : environment,
        "case_type": caseType == null
            ? null
            : caseType,
        "patient": patient == null
            ? null
            : patient,
        "backup": backup == null
            ? null
            : backup,
        "other_services_atScene": otherServicesAtScene == null
            ? null
            : otherServicesAtScene.toJson(),
      };
}

class PPE{
    List<String> ppe;
    String otherspecify;

  PPE({
    this.ppe,
    this.otherspecify
  });
  
    factory PPE.fromJson(Map<String, dynamic> json){

      return
      PPE(
        ppe: json != null 
             ? json["ppe"] is List 
             ? List<String>.from(json["ppe"].map((x) => x))
             : json != null 
             ? json["ppe_list"] != null
             ? List<String>.from(json["ppe_list"].map((x) => x))
             : null
             : null
             : null,
        otherspecify: json.toString().contains("others_specify")
                      ? json["others_specify"]
                      : ""     
      );
    }

        Map<String, dynamic> toJson() => {
       "ppe_list": ppe == null
            ? null
        : List<dynamic>.from(ppe.map((x) => x)),
        "others_specify": otherspecify != null ? otherspecify : null
      };
}

class OtherServices{
    List<String> otherServices;
    String otherspecify;

  OtherServices({
    this.otherServices,
    this.otherspecify
  });
  
    factory OtherServices.fromJson(Map<String, dynamic> json){

      return
      OtherServices(
        otherServices: json != null 
             ? json["other_services_atScene"] is List 
             ? List<String>.from(json["other_services_atScene"].map((x) => x))
             : json != null 
             ? json["other_services"] != null
             ? List<String>.from(json["other_services"].map((x) => x))
             : null
             : null
             : null,
        otherspecify: json.toString().contains("others_specify")
                      ? json["others_specify"]
                      : ""     
      );
    }

        Map<String, dynamic> toJson() => {
       "other_services": otherServices == null
            ? null
        : List<dynamic>.from(otherServices.map((x) => x)),
        "others_specify": otherspecify != null ? otherspecify : null
      };
}

class SamplerAssessment {
  DateTime timestamp;
  String signSymptom;
  String allergies;
  String medication;
  String pastMedical;
  String lastMeal;
  String eventLeadingInjuries;
  String riskFactor;

  SamplerAssessment(
      {
      this.timestamp,  
      this.signSymptom,
      this.allergies,
      this.medication,
      this.pastMedical,
      this.lastMeal,
      this.eventLeadingInjuries,
      this.riskFactor});

  SamplerAssessment.fromJson(Map<String, dynamic> json) {
    timestamp = parsingDateTime(json['timestamp']);
    signSymptom = json['sign_symptom']!=null?json['sign_symptom']:null;
    allergies = json['allergies']!=null?json['allergies']:null;
    medication = json['medication']!=null?json['medication']:null;
    pastMedical = json['past_medical']!=null?json['past_medical']:null;
    lastMeal = json['last_meal']!=null? json['last_meal']:null;
    eventLeadingInjuries = json['event_leading_injuries']!=null? json['event_leading_injuries']:null;
    riskFactor = json['risk_factor']!=null? json['risk_factor']:null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp!=null? timestamp.toString(): null;
    data['sign_symptom'] = this.signSymptom !=null? signSymptom:null;
    data['allergies'] = this.allergies !=null? allergies: null;
    data['medication'] = this.medication!=null? medication:null;
    data['past_medical'] = this.pastMedical!=null? pastMedical: null;
    data['last_meal'] = this.lastMeal!=null?lastMeal: null;
    data['event_leading_injuries'] = this.eventLeadingInjuries!=null?eventLeadingInjuries:null;
    data['risk_factor'] = this.riskFactor!=null? riskFactor:null;
    return data;
  }
}

class OtherAssessment {
  DateTime timestamp;
  String extraNote;

  OtherAssessment({this.timestamp, this.extraNote});

  OtherAssessment.fromJson(Map<String, dynamic> json) {
    timestamp = parsingDateTime(json['timestamp']);
    extraNote = json['extra_note']!=null? json['extra_note']:'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp!=null?timestamp.toString():null;
    data['extra_note'] = this.extraNote !=null? extraNote:null;
    return data;
  }
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
