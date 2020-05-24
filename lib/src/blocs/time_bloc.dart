import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';

abstract class TimeEvent extends Equatable {
  TimeEvent();
}

class LoadTime extends TimeEvent {
  final assign_id;
  final ResponseTime responseTime;

  LoadTime({this.assign_id, this.responseTime});
  @override
  List<Object> get props => [assign_id, responseTime];
}

class AddResponseTime extends TimeEvent {
  final ResponseTime responseTime;
  final assignId;

  AddResponseTime({this.responseTime, this.assignId});

  @override
  List<Object> get props => [responseTime, assignId];
}

abstract class TimeState extends Equatable {
  final ResponseTime responseTime;

  TimeState({this.responseTime});

  @override
  List<Object> get props => [responseTime];
}

class TimeLoaded extends TimeState {
  final ResponseTime responseTime;

  TimeLoaded({this.responseTime});

  @override
  List<Object> get props => [responseTime];
}

class TimeEmpty extends TimeState {}

class TimeError extends TimeState {}

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  PhcDao phcDao;
  TimeBloc({this.phcDao}) : assert(phcDao != null);
  ResponseTime responseTime;

  @override
  TimeState get initialState => TimeEmpty();

  // StreamController dispatchController = StreamController<DateTime>.broadcast();
  // DateTime dispatchTime = DateTime.now();

  // Sink get dispatchSink => dispatchController.sink;
  // Stream<DateTime> get dispatchStream => dispatchController.stream;

  // updateValue(dateTime) {
  //   print("YOU get into update");
  //   dispatchSink.add(dateTime);
  // }
  // DateTime dispatchValue =>

  // changeTime(){
  //   dispatchSink.add(data)
  // }

  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    if (event is LoadTime) {
      yield* _mapLoadTimeToState(event);
    } else if (event is AddResponseTime) {
      yield* _mapAddResponseTimeToState(event);
    }
  }

  Stream<TimeState> _mapLoadTimeToState(LoadTime event) async* {
    // yield* _reloadResponseTime(event.assign_id);
    // try {
    //   final responseTime = await phcDao.getResponseTime(event.assign_id);
    //   yield TimeLoaded(responseTime: responseTime);
    // } catch (_) {
    //   final responseTime = await phcDao.getPhcResponseTime(event.assign_id);
    yield TimeLoaded(responseTime: event.responseTime);
    // }
  }

  Stream<TimeState> _mapAddResponseTimeToState(AddResponseTime event) async* {
    // try {
    //   final result =
    //       await phcDao.insertResponseTime(event.responseTime, event.assignId);

    //   // yield* _reloadResponseTime(event.assignId);
    //   yield TimeLoaded(
    //     responseTime: result,
    //   );
    // } catch (_) {
    //   yield TimeError();
    // }
    responseTime = event.responseTime;
    print(responseTime.toJson());
    print("addrespoinse team success");

    TimeLoaded(responseTime: responseTime);
  }

  Stream<TimeState> _reloadResponseTime(assign_id) async* {
    assert(phcDao != null);

    try {
      print("responsetime--load sembast");
      final responseTime = await phcDao.getResponseTime(assign_id);
      print(responseTime);
      // ResponseTime responseTime = new ResponseTime(

      // )

      if (responseTime == null) {
        yield TimeLoaded(
          responseTime: new ResponseTime(),
        );
      }

      yield TimeLoaded(
        responseTime: responseTime,
      );
    } catch (_) {
      print("failed so read from responsetime--load phcsembast");
      // final responseTime = await phcDao.getPhcResponseTime(assign_id);
      // print(responseTime.toJson());

      // if (responseTime == null) {
      yield TimeLoaded(responseTime: new ResponseTime()
          // dispatchTime: "",
          // enrouteTime: "",
          // atSceneTime: "",
          // atPatientTime: "",
          // transportingTime: "",
          // atHospitalTime: "",
          // rerouteTime: "",
          // reasonAbort: ""),
          );
      // }

      // yield TimeLoaded(
      //   responseTime: responseTime,
      // );
    }
  }
}
