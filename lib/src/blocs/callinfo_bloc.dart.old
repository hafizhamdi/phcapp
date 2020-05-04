import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:meta/meta.dart';

//Event
abstract class CallInfoEvent extends Equatable {
  CallInfoEvent();
}

class LoadCallInfo extends CallInfoEvent {
  final assign_id;

  LoadCallInfo({this.assign_id});
  @override
  List<Object> get props => [assign_id];
}

class ErrorCallInfo extends CallInfoEvent {}

class UpdateCallInfo extends CallInfoEvent {
  final CallInformation call_information;

  UpdateCallInfo({this.call_information});

  @override
  List<Object> get props => [call_information];
}

class AddCallInfo extends CallInfoEvent {
  final CallInformation call_information;

  AddCallInfo({this.call_information});

  @override
  List<Object> get props => [call_information];
}

//State
abstract class CallInfoState extends Equatable {
  CallInfoState();

  @override
  List<Object> get props => [];
}

class CallInfoError extends CallInfoState {}

class CallInfoEmpty extends CallInfoState {}

class CallInfoLoaded extends CallInfoState {
  CallInformation call_information;

  CallInfoLoaded({this.call_information});
  @override
  List<Object> get props => [call_information];
}

class CallInfoSaved extends CallInfoState {
  CallInformation call_information;
  CallInfoSaved({this.call_information});
  @override
  List<Object> get props => [call_information];
}

class CallInfoUpdated extends CallInfoState {
  @override
  List<Object> get props => [];
}

class CallInfoBloc extends Bloc<CallInfoEvent, CallInfoState> {
  PhcDao phcDao; // = new PhcDao();

  CallInfoBloc({@required this.phcDao}) : assert(phcDao != null);
  
  final  cardNoController = TextEditingController();

  @override
  CallInfoState get initialState => CallInfoEmpty();

  @override
  Stream<CallInfoState> mapEventToState(CallInfoEvent event) async* {
    if (event is LoadCallInfo) {
      // try {
      yield* _mapLoadCallInfoToState(event);
      // } catch (_) {
      // yield CallInfoError();
      // }
    } else if (event is UpdateCallInfo) {
      await phcDao.updateCallInformation(event.call_information);
      yield* _reloadCallInformation(event.call_information.assign_id);
    } else if (event is AddCallInfo) {
      await phcDao.insertCallInformation(event.call_information);

      yield* _reloadCallInformation(event.call_information.assign_id);
    }
  }

  Stream<CallInfoState> _mapLoadCallInfoToState(LoadCallInfo event) async* {
    print("_mapLoadCallInfoToState");

    yield* _reloadCallInformation(event.assign_id);
    // yield CallInfoLoaded(assignId : assign_id);
  }

  Stream<CallInfoState> _reloadCallInformation(assign_id) async* {
    // yield PhcLoading();
    // print("before phc reload");

    assert(phcDao != null);
    try {
      final call_info = await phcDao.getCallInformation(assign_id);

      print("reloadCallINFO");
      print(call_info);
      yield CallInfoLoaded(
          call_information: CallInformation.fromJson(call_info));
    } catch (_) {
      final call_info = await phcDao.getPhcCallInformation(assign_id);
      print("catch statemetn");
      print(call_info);
      yield CallInfoLoaded(
          call_information:
              call_info); //different from above because have initiate in get function

      // yield CallInfoError();
      // yield CallInfoEmpty();
    }
    // }
  }
}
