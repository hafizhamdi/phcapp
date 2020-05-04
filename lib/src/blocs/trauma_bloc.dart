import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/ui/tabs/patient/trauma.dart';

abstract class TraumaEvent extends Equatable {
  TraumaEvent();
}

class AddTrauma extends TraumaEvent {
  TraumaAssessment traumaAssessment;
  AddTrauma({this.traumaAssessment});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "trauma events: OK";
  }
}

abstract class TraumState extends Equatable {
  TraumState();
}

class TraumaEmpty extends TraumState {}

class TraumaAdded extends TraumState {
  TraumaAssessment traumaAssessment;
  TraumaAdded({this.traumaAssessment});

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return "trauma state: OK";
  }
}

class TraumaBloc extends Bloc<TraumaEvent, TraumState> {
  @override
  TraumState get initialState => TraumaEmpty();

  @override
  Stream<TraumState> mapEventToState(TraumaEvent event) async* {
    if (event is AddTrauma) {
      yield TraumaAdded(traumaAssessment: event.traumaAssessment);
    }
  }
}
