import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class CprEvent extends Equatable {
  final CprLog cprLog;
  CprEvent({this.cprLog});
  @override
  List get props => [cprLog];
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

class AddCpr extends CprEvent {
  final id;
  final Cpr cpr;
  final rhythm_type;
  AddCpr({this.cpr, this.id, this.rhythm_type});
  @override
  List get props => [cpr, id, rhythm_type];
}

class AddRhythmAnalysis extends CprEvent {
  final RhythmAnalysis rhythmAnalysis;

  AddRhythmAnalysis({this.rhythmAnalysis});
  @override
  List get props => [rhythmAnalysis];
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
  List<RhythmAnalysis> listAnalysis;
  CprLoaded({this.cprLog, this.listAnalysis});
  @override
  List get props => [cprLog, this.listAnalysis];
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
    } else if (event is LoadCpr) {
      yield* mapLoadCpr(event);
    } else if (event is AddCpr) {
      yield* mapAddCpr(event);
    }
  }

  Stream<CprState> mapAddRhythmAnalysis(AddRhythmAnalysis event) async* {
    yield CprLoading();
    var currentState = state;
    print("mapAddRhythmAnalysis");

    print(state);
    // print(event.rhythmAnalysis.toJson());
    final mylistAnalysis =
        List<RhythmAnalysis>.from(currentState.cprLog.rhythmAnalysis)
          ..add(event.rhythmAnalysis);
    // ..toList();

    print(mylistAnalysis.length);
    currentState.cprLog.rhythmAnalysis = mylistAnalysis;
    // currentState.listAnalysis = mylistAnalysis;

    yield CprLoaded(cprLog: currentState.cprLog);
  }

  Stream<CprState> mapLoadCpr(LoadCpr event) async* {
    yield CprLoading();
    CprLog cprLog = new CprLog(rhythmAnalysis: []);
    yield CprLoaded(cprLog: cprLog);
  }

  Stream<CprState> mapAddCpr(AddCpr event) async* {
    yield CprLoading();
    final currentState = state;
    print("mapAddCpr");
    print(currentState);
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

    // if (event.rhythm_type == "Shockable") {
    //   if (event.id == "srhythm") {
    //     rhythmAnalysis.shockable.rhythm = event.cpr;
    //   }
    // }

    yield CprLoaded(cprLog: currentState.cprLog);
  }
}
