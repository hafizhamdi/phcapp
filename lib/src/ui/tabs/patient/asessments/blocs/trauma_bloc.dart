import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class TraumaEvent extends Equatable {
  // TraumaEvent();
  final TraumaAssessment traumaAssessment;
  TraumaEvent({this.traumaAssessment});

  @override
  List<Object> get props => [traumaAssessment];
}

class UpdateTrauma extends TraumaEvent {
  final TraumaAssessment traumaAssessment;
  UpdateTrauma({this.traumaAssessment});

  @override
  List<Object> get props => [traumaAssessment];
}

class ResetTrauma extends TraumaEvent {}

class LoadTrauma extends TraumaEvent {
  final TraumaAssessment traumaAssessment;
  LoadTrauma({this.traumaAssessment});

  @override
  List<Object> get props => [traumaAssessment];
}

abstract class TraumaState extends Equatable {
  final TraumaAssessment traumaAssessment;
  TraumaState({this.traumaAssessment});

  @override
  List<Object> get props => [traumaAssessment];
}

class TraumaEmpty extends TraumaState {}

class TraumaLoaded extends TraumaState {
  final TraumaAssessment traumaAssessment;
  TraumaLoaded({this.traumaAssessment});

  @override
  List<Object> get props => [traumaAssessment];
}

class TraumaBloc extends Bloc<TraumaEvent, TraumaState> {
  @override
  // TODO: implement initialState
  TraumaState get initialState => TraumaEmpty();

  @override
  Stream<TraumaState> mapEventToState(TraumaEvent event) async* {
    if (event is LoadTrauma) {
      yield* _mapLoadTraumaToState(event);
    } else if (event is UpdateTrauma) {
      yield* _mapUpdateTraumaToState(event);
    } else if (event is ResetTrauma) {
      yield TraumaEmpty();
    }
  }

  Stream<TraumaState> _mapLoadTraumaToState(LoadTrauma event) async* {
    yield TraumaLoaded(traumaAssessment: event.traumaAssessment);
  }

  Stream<TraumaState> _mapUpdateTraumaToState(UpdateTrauma event) async* {
    print("INBLOC tRAUMA");
    // print(event.traumaAssessment.toJson());
    yield TraumaLoaded(traumaAssessment: event.traumaAssessment);
  }
}
