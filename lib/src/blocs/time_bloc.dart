import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';

enum Response {
  dispatch,
  enroute,
  atScene,
  atPatient,
  atHospital,
  transport,
  reroute
}

abstract class TimeEvent extends Equatable {
  final ResponseTime responseTime;
  final time;
  final selector;

  // AddTime({this.time, this.selector});
  TimeEvent({this.responseTime, this.time, this.selector});

  @override
  List get props => [time, selector, responseTime];
}

class LoadTime extends TimeEvent {
  final assign_id;
  final ResponseTime responseTime;

  LoadTime({this.assign_id, this.responseTime});
  @override
  List<Object> get props => [assign_id, responseTime];
}

class ResetTime extends TimeEvent {}

class AddTime extends TimeEvent {
  final ResponseTime responseTime;
  final time;
  final selector;

  AddTime({this.time, this.selector, this.responseTime});

  @override
  List get props => [time, selector, this.responseTime];
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
  final time;
  final selector;

  // AddTime({this.time, this.selector});
  TimeState({this.responseTime, this.time, this.selector});

  @override
  List get props => [time, selector, responseTime];

  // @override
  // List<Object> get props => [responseTime];
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
  final ResponseTime responseTime = new ResponseTime();

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
    } else if (event is AddTime) {
      yield* _mapAddTimeToState(event);
    } else if (event is ResetTime) {
      yield TimeEmpty();
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
    // responseTime = event.responseTime;
    // print(responseTime.toJson());
    // print("addrespoinse team success");

    TimeLoaded(responseTime: responseTime);
  }

  Stream<TimeState> _mapAddTimeToState(AddTime event) async* {
    // DateTime dispatchTime;
    // ResponseTime resTime = responseTime;
    // print(event.time);
    // if (Response.dispatch == event.selector) {
    //   dispatchTime = event.time;
    // }
    // switch (event.selector) {
    //   case Response.dispatch:
    //     resTime.dispatchTime = event.time;
    //     break;
    //   case Response.enroute:
    //     resTime.enrouteTime = event.time;
    //     break;
    //   case Response.atScene:
    //     resTime.atSceneTime = event.time;
    //     break;
    //   case Response.atPatient:
    //     resTime.atPatientTime = event.time;
    //     break;
    //   case Response.transport:
    //     resTime.transportingTime = event.time;
    //     break;
    //   case Response.atHospital:
    //     resTime.atHospitalTime = event.time;
    //     break;
    //   case Response.reroute:
    //     resTime.rerouteTime = event.time;
    //     break;
    //   default:
    // }

    print("bloc responsetime");
    print(event.responseTime.dispatchTime);

    yield TimeLoaded(responseTime: event.responseTime);
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
