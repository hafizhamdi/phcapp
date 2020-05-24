import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class CprEvent extends Equatable {
  final CPR cpr;

  CprEvent({this.cpr});
  @override
  List<Object> get props => [cpr];
  // CprEvent();
}

class AddCpr extends CprEvent {
  final CprSection cprSection;

  AddCpr({this.cprSection});
  @override
  List<Object> get props => [cprSection];
}

class RemoveCpr extends CprEvent {
  final index;

  RemoveCpr({this.index});
  @override
  List<Object> get props => [index];
}

class LoadCpr extends CprEvent {
  final CPR cpr;

  LoadCpr({this.cpr});
  @override
  List<Object> get props => [cpr];
}

abstract class CprState extends Equatable {
  final CPR cpr;

  CprState({this.cpr});
  @override
  List<Object> get props => [cpr];
}

class LoadedCpr extends CprState {
  final CPR cpr;

  LoadedCpr({this.cpr});
  @override
  List<Object> get props => [cpr];
}

class InitialCpr extends CprState {}

class CprBloc extends Bloc<CprEvent, CprState> {
  @override
  CprState get initialState => InitialCpr();

  @override
  Stream<CprState> mapEventToState(CprEvent event) async* {
    if (event is AddCpr) {
      yield* mapAddCprToState(event);
    } else if (event is LoadCpr) {
      yield* mapLoadCprToState(event);
    } else if (event is RemoveCpr) {
      yield* mapRemoveCprToState(event);
    }
  }

  Stream<CprState> mapAddCprToState(AddCpr event) async* {
    final currentState = state;

    currentState.cpr.cprLogs.add(event.cprSection);

    yield LoadedCpr(cpr: currentState.cpr);
  }

  Stream<CprState> mapLoadCprToState(LoadCpr event) async* {
    // final currentState = state;
    CPR cpr = event.cpr;

    yield LoadedCpr(cpr: cpr);
  }

  Stream<CprState> mapRemoveCprToState(RemoveCpr event) async* {
    final currentState = state;
    currentState.cpr.cprLogs.removeAt(event.index);

    yield LoadedCpr(cpr: currentState.cpr);
  }
}
