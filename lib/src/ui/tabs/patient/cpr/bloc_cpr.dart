import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class CprEvent extends Equatable {
  final CprLog cprLog;

  final id;
  final Log log;
  final Cpr cpr;
  final CPROutcome cprOutcome;
  final rhythm_type;
  CprEvent({this.log, this.cprLog, this.id, this.cpr, this.rhythm_type, this.cprOutcome});
  @override
  List get props => [log, cprLog, id, cpr, rhythm_type, cprOutcome];
}

abstract class CprState extends Equatable {
  final CprLog cprLog;
  // List<RhythmAnalysis> listAnalysis;
  CprState({
    this.cprLog,
    // this.listAnalysis
  });
  @override
  List get props => [
        cprLog,
        // this.listAnalysis
      ];
}

class LoadCpr extends CprEvent {
  final CprLog cprLog;
  LoadCpr({this.cprLog});
  @override
  List get props => [cprLog];
}

class PressViewLog extends CprEvent {}

class ResetCprLog extends CprEvent {}

class RemoveRhythmAnalysis extends CprEvent {
  final index;
  RemoveRhythmAnalysis({this.index});
  @override
  List get props => [index];
}

class AddCpr extends CprEvent {
  final id;
  final Log log;
  final Cpr cpr;
  final CPROutcome cprOutcome;
  final rhythm_type;
  AddCpr({this.log, this.cpr, this.id, this.rhythm_type, this.cprOutcome});
  @override
  List get props => [log, cpr, id, rhythm_type, cprOutcome];
}

class AddRhythmAnalysis extends CprEvent {
  final RhythmAnalysis rhythmAnalysis;

  AddRhythmAnalysis({this.rhythmAnalysis});
  @override
  List get props => [rhythmAnalysis];
}

class UpdateRhythmAnalysis extends CprEvent {
  final index;
  final RhythmAnalysis rhythmAnalysis;

  UpdateRhythmAnalysis({this.rhythmAnalysis, this.index});
  @override
  List get props => [rhythmAnalysis, index];
}

class CprEmpty extends CprState {
  final CprLog cprLog;
  // List<RhythmAnalysis> listAnalysis = List<RhythmAnalysis>();
  CprEmpty({
    this.cprLog,
    // this.listAnalysis
  });
  @override
  List get props => [
        cprLog,
        // this.listAnalysis
      ];
}

class CprLoading extends CprState {}

class CprLoaded extends CprState {
  final CprLog cprLog;
  // List<RhythmAnalysis> listAnalysis;
  CprLoaded({
    this.cprLog,
    // this.listAnalysis
  });
  @override
  List get props => [
        cprLog,
        // this.listAnalysis
      ];
}

class CprBloc extends Bloc<CprEvent, CprState> {
  // CprLog cprLog = new CprLog(rhythmAnalysis: []);
  // RhythmAnalysis rhythmAnalysis = new RhythmAnalysis();
  // Cpr shockable = new Cpr();
  // Cpr nonShockable = new Cpr();
  // Cpr other = new Cpr();

  @override
  CprState get initialState => CprEmpty();

  @override
  Stream<CprState> mapEventToState(CprEvent event) async* {
    if (event is AddRhythmAnalysis) {
      yield* mapAddRhythmAnalysis(event);
    } else if (event is UpdateRhythmAnalysis) {
      yield* mapUpdateRhythmAnalysis(event);
    } else if (event is LoadCpr) {
      yield* mapLoadCpr(event);
    } else if (event is AddCpr) {
      yield* mapAddCpr(event);
    } else if (event is RemoveRhythmAnalysis) {
      yield* mapRemoveRhythmAnalysis(event);
    } else if (event is PressViewLog) {
      yield* mapPressViewLog(event);
    } else if (event is ResetCprLog) {
      yield CprEmpty();
    }
  }

  Stream<CprState> mapAddRhythmAnalysis(AddRhythmAnalysis event) async* {
    yield CprLoading();
    var currentState = state;
    print("mapAddRhythmAnalysis");

    print(state);
    // print(event.rhythmAnalysis.toJson());
    var mylistAnalysis =
        List<RhythmAnalysis>.from(currentState.cprLog.rhythmAnalysis)
          ..add(event.rhythmAnalysis);
    // ..toList();

    print(mylistAnalysis.length);
    currentState.cprLog.rhythmAnalysis = mylistAnalysis;
    // currentState.listAnalysis = mylistAnalysis;

    yield CprLoaded(cprLog: currentState.cprLog);
  }

  Stream<CprState> mapUpdateRhythmAnalysis(UpdateRhythmAnalysis event) async* {
    yield CprLoading();
    var currentState = state;
    print("mapUpdateRhythmAnalysis");

    print(state);
    // print(event.rhythmAnalysis.toJson());
    var mylistAnalysis =
        List<RhythmAnalysis>.from(currentState.cprLog.rhythmAnalysis)
          ..replaceRange(event.index, event.index + 1, [event.rhythmAnalysis]);
    // add(event.rhythmAnalysis);
    // ..toList();

    print(mylistAnalysis.length);
    currentState.cprLog.rhythmAnalysis = mylistAnalysis;
    // currentState.listAnalysis = mylistAnalysis;

    yield CprLoaded(cprLog: currentState.cprLog);
  }

  Stream<CprState> mapLoadCpr(LoadCpr event) async* {
    yield CprLoading();
    // CprLog cprLog = new CprLog(rhythmAnalysis: []);
    // var temp = List<RhythmAnalysis>.from(event.y.rhythmAnalysis).toList();
    var cprlog = event.cprLog;
    cprlog.rhythmAnalysis = event.cprLog.rhythmAnalysis != null
        ? List<RhythmAnalysis>.from(event.cprLog.rhythmAnalysis).toList()
        : [];
    // cprlog.rhythmAnalysis = temp;

    yield CprLoaded(cprLog: cprlog);
  }

  Stream<CprState> mapAddCpr(AddCpr event) async* {
    yield CprLoading();
    final currentState = state;

    print(event.cprOutcome);
    currentState.cprLog.log = state.cprLog.log;
    currentState.cprLog.witnessCpr = state.cprLog.witnessCpr;
    currentState.cprLog.cprStart = state.cprLog.cprStart;
    currentState.cprLog.bystanderCpr = state.cprLog.bystanderCpr;
    currentState.cprLog.rosc = state.cprLog.rosc;
    currentState.cprLog.cprStop = state.cprLog.cprStop;
    // currentState.cprLog.cprOutcome = state.cprLog.cprOutcome;

    if (event.id == "log_in_cpr") {
      currentState.cprLog.log = event.log;
    }
    if (event.id == "witness_cpr") {
      currentState.cprLog.witnessCpr = event.cpr;
    }
    if (event.id == "cpr_start") {
      currentState.cprLog.cprStart = event.cpr;
    }
    if (event.id == "bystander_cpr") {
      currentState.cprLog.bystanderCpr = event.cpr;
    }
    if (event.id == "rosc") {
      currentState.cprLog.rosc = event.cpr;
    }
    if (event.id == "cpr_stop") {
      currentState.cprLog.cprStop = event.cpr;
    }
    if (event.id == "cpr_outcome") {
      currentState.cprLog.cprOutcome = event.cprOutcome;
    }

    currentState.cprLog.rhythmAnalysis = state.cprLog.rhythmAnalysis;

    // if (event.rhythm_type == "Shockable") {
    //   if (event.id == "srhythm") {
    //     rhythmAnalysis.shockable.rhythm = event.cpr;
    //   }
    // }

    yield CprLoaded(cprLog: currentState.cprLog);
  }

  Stream<CprState> mapRemoveRhythmAnalysis(RemoveRhythmAnalysis event) async* {
    yield CprLoading();

    final currentState = state;
    currentState.cprLog.rhythmAnalysis.removeAt(event.index);
    // currentState.cprLog.rhythmAnalysis = tempRA;

    yield CprLoaded(cprLog: currentState.cprLog);
  }

  Stream<CprState> mapPressViewLog(PressViewLog event) async* {
    // yield CprLoading();

    final currentState = state;
    print("mapPressViewLog");
    // currentState.cprLog.rhythmAnalysis.removeAt(event.index);
    print(jsonEncode(currentState.cprLog));
    // currentState.cprLog.rhythmAnalysis = tempRA;

    yield CprLoaded(cprLog: currentState.cprLog);
  }
}
