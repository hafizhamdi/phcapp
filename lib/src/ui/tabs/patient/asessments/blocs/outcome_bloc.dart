import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class OutcomeEvent extends Equatable {
  final Outcome outcome;
  OutcomeEvent({this.outcome});

  @override
  List get props => [outcome];
}

abstract class OutcomeState extends Equatable {
  final Outcome outcome;
  OutcomeState({this.outcome});

  @override
  List get props => [outcome];
}

class LoadOutcome extends OutcomeEvent {
  final Outcome outcome;
  LoadOutcome({this.outcome});

  @override
  List get props => [outcome];
}

class ResetOutcome extends OutcomeEvent {}

class LoadedOutcome extends OutcomeState {
  final Outcome outcome;
  LoadedOutcome({this.outcome});

  @override
  List get props => [outcome];
}

class EmptyOutcome extends OutcomeState {}

class OutcomeBloc extends Bloc<OutcomeEvent, OutcomeState> {
  @override
  OutcomeState get initialState => EmptyOutcome();

  @override
  Stream<OutcomeState> mapEventToState(OutcomeEvent event) async* {
    if (event is LoadOutcome) {
      yield* mapLoadedOutcomeToState(event);
    } else if (event is ResetOutcome) {
      yield EmptyOutcome();
    }
  }

  Stream<OutcomeState> mapLoadedOutcomeToState(LoadOutcome event) async* {
    yield LoadedOutcome(outcome: event.outcome);
  }
}
