import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class AssPatientEvent extends Equatable {
  // AssPatientEvent();
  final PatientAssessment patientAssessment;
  AssPatientEvent({this.patientAssessment});

  @override
  List<Object> get props => [patientAssessment];
}

class UpdateAssPatient extends AssPatientEvent {
  final PatientAssessment patientAssessment;
  UpdateAssPatient({this.patientAssessment});

  @override
  List<Object> get props => [patientAssessment];
}

class ResetAssPatient extends AssPatientEvent {}

class LoadAssPatient extends AssPatientEvent {
  final PatientAssessment patientAssessment;
  LoadAssPatient({this.patientAssessment});

  @override
  List<Object> get props => [patientAssessment];
}

abstract class AssPatientState extends Equatable {
  final PatientAssessment patientAssessment;
  AssPatientState({this.patientAssessment});

  @override
  List<Object> get props => [patientAssessment];
}

class AssPatientEmpty extends AssPatientState {}

class AssPatientLoaded extends AssPatientState {
  final PatientAssessment patientAssessment;
  AssPatientLoaded({this.patientAssessment});

  @override
  List<Object> get props => [patientAssessment];
}

class AssPatientBloc extends Bloc<AssPatientEvent, AssPatientState> {
  @override
  // TODO: implement initialState
  AssPatientState get initialState => AssPatientEmpty();

  @override
  Stream<AssPatientState> mapEventToState(AssPatientEvent event) async* {
    if (event is LoadAssPatient) {
      yield* _mapLoadAssPatientToState(event);
    } else if (event is UpdateAssPatient) {
      yield* _mapUpdateAssPatientToState(event);
    } else if (event is ResetAssPatient) {
      yield AssPatientEmpty();
    }
  }

  Stream<AssPatientState> _mapLoadAssPatientToState(
      LoadAssPatient event) async* {
    yield AssPatientLoaded(patientAssessment: event.patientAssessment);
  }

  Stream<AssPatientState> _mapUpdateAssPatientToState(
      UpdateAssPatient event) async* {
    yield AssPatientLoaded(patientAssessment: event.patientAssessment);
  }
}
