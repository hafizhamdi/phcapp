import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class CallInfoEvent extends Equatable {
  CallInfoEvent();
}

class SaveCallInfo extends CallInfoEvent {
  final CallInformation callInformation;

  SaveCallInfo({this.callInformation});
  @override
  List<Object> get props => [callInformation];
}

abstract class CallInfoState extends Equatable {
  CallInfoState();
}

// class LoadCallInfo extends CallInfoEvent {
// }
class CallInfoInitial extends CallInfoState {}

class CallInfoSaved extends CallInfoState {
  final CallInformation callInformation;
  // final callcard_no;
  // final date_received;
  // final caller_contact_no;
  // final event_code;
  // final priority;
  // final incident_description;
  // final incident_location;
  // final landmark;
  // final location_type;
  // final distance_to_scene;

  CallInfoSaved({this.callInformation
      // this.callcard_no,
      // this.date_received,
      // this.caller_contact_no,
      // this.event_code,
      // this.priority,
      // this.incident_description,
      // this.incident_location,
      // this.landmark,
      // this.location_type,
      // this.distance_to_scene,
      });

  @override
  List<Object> get props => [callInformation];

  // @override
  // String toString() {
  //   return callInformation.toJson().toString();
  // }
}

class CallInfoBloc extends Bloc<CallInfoEvent, CallInfoState> {
  @override
  get initialState => CallInfoInitial();

  CallInformation callInformation;
  TextEditingController cardNoController = new TextEditingController();
  // StreamController<String> cardNoController = new StreamController.broadcast();

  @override
  Stream<CallInfoState> mapEventToState(event) async* {
    if (event is SaveCallInfo) {
      yield* mapCallInfoToState(event);
    }
  }

  Stream<CallInfoState> mapCallInfoToState(SaveCallInfo event) async* {
    // yield CallInfoSaved(
    callInformation = new CallInformation(
        callcardNo: event.callInformation.callcard_no,
        callReceived: event.callInformation.call_received,
        callerContactno: event.callInformation.caller_contactno,
        eventCode: event.callInformation.event_code,
        priority: event.callInformation.priority,
        incidentDesc: event.callInformation.incident_desc,
        incidentLocation: event.callInformation.incident_location,
        landmark: event.callInformation.landmark,
        locationType: event.callInformation.location_type,
        distanceToScene: event.callInformation.distance_to_scene,
        assignId: event.callInformation.assign_id,
        plateNo: event.callInformation.plate_no);
    yield CallInfoSaved(callInformation: callInformation);
  }
  // Stream<TextEditingController> get cardNoControllerStream =>  cardNoController;
}