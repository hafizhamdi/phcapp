import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

class MedicationEvent extends Equatable {
  MedicationAssessment medicationAssessment;
  MedicationEvent({this.medicationAssessment});

  @override
  List get props => [medicationAssessment];
}

class MedicationState extends Equatable {
  MedicationAssessment medicationAssessment;
  MedicationState({this.medicationAssessment});

  @override
  List get props => [medicationAssessment];
}

class LoadMedication extends MedicationEvent {
  MedicationAssessment medicationAssessment;
  LoadMedication({this.medicationAssessment});

  @override
  List get props => [medicationAssessment];
}

class UpdateMedication extends MedicationEvent {
  MedicationAssessment medicationAssessment;
  UpdateMedication({this.medicationAssessment});

  @override
  List get props => [medicationAssessment];
}

class ResetMedication extends MedicationEvent {}

class LoadedMedication extends MedicationState {
  MedicationAssessment medicationAssessment;
  LoadedMedication({this.medicationAssessment});

  @override
  List get props => [medicationAssessment];
}

class EmptyMedication extends MedicationState {}

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  @override
  MedicationState get initialState => EmptyMedication();

  @override
  Stream<MedicationState> mapEventToState(MedicationEvent event) async* {
    if (event is LoadMedication) {
      yield* mapLoadMedicationToState(event);
    } else if (event is UpdateMedication) {
      yield* mapUpdateMedicationToState(event);
    } else if (event is ResetMedication) {
      yield EmptyMedication();
    }
  }

  Stream<MedicationState> mapLoadMedicationToState(
      LoadMedication event) async* {
    yield LoadedMedication(medicationAssessment: event.medicationAssessment);
  }

  Stream<MedicationState> mapUpdateMedicationToState(
      UpdateMedication event) async* {
    yield LoadedMedication(medicationAssessment: event.medicationAssessment);
  }
}
