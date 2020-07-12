import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class OtherEvent extends Equatable {
  final OtherAssessment otherAssessment;
  OtherEvent({this.otherAssessment});

  @override
  List get props => [otherAssessment];
}

abstract class OtherState extends Equatable {
  final OtherAssessment otherAssessment;
  OtherState({this.otherAssessment});

  @override
  List get props => [otherAssessment];
}

class LoadOther extends OtherEvent {
  final OtherAssessment otherAssessment;
  LoadOther({this.otherAssessment});

  @override
  List get props => [otherAssessment];
}

class UpdateOther extends OtherEvent {
  final OtherAssessment otherAssessment;
  UpdateOther({this.otherAssessment});

  @override
  List get props => [otherAssessment];
}

class ResetOther extends OtherEvent {}

class LoadedOther extends OtherState {
  final OtherAssessment otherAssessment;
  LoadedOther({this.otherAssessment});

  @override
  List get props => [otherAssessment];
}

class EmptyOther extends OtherState {}

class LoadingOther extends OtherState {}

class OtherBloc extends Bloc<OtherEvent, OtherState> {
  @override
  // TODO: implement initialState
  OtherState get initialState => EmptyOther();

  @override
  Stream<OtherState> mapEventToState(OtherEvent event) async* {
    if (event is LoadOther) {
      yield* mapLoadOther(event);
    } else if (event is UpdateOther) {
      yield* mapUpdateOther(event);
    } else if (event is ResetOther) {
      yield EmptyOther();
    }
  }

  Stream<OtherState> mapLoadOther(LoadOther event) async* {
    yield LoadingOther();
    yield LoadedOther(otherAssessment: event.otherAssessment);
  }

  Stream<OtherState> mapUpdateOther(UpdateOther event) async* {
    yield LoadingOther();
    yield LoadedOther(otherAssessment: event.otherAssessment);
  }
}
