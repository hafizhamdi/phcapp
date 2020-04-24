import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';
import 'package:phcapp/src/repositories/repositories.dart';

abstract class PatientEvent extends Equatable {
  PatientEvent();
}

class LoadPatient extends PatientEvent {
  final List<Patient> patients;

  LoadPatient({this.patients});

  @override
  List<Object> get props => [patients];
}

class AddPatient extends PatientEvent {
  Patient patient;
  AddPatient({this.patient});

  @override
  List<Object> get props => [patient];
}

class RemovePatient extends PatientEvent {
  int index;
  RemovePatient({this.index});

  @override
  List<Object> get props => [index];
}

abstract class PatientState extends Equatable {
  final List<Patient> patients;

  PatientState({this.patients});

  @override
  List<Object> get props => [patients];
}

class PatientLoaded extends PatientState {
  final List<Patient> patients;

  PatientLoaded({this.patients});

  @override
  List<Object> get props => [patients];
}

class PatientEmpty extends PatientState {}

class PatientLoading extends PatientState {}

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PhcDao phcDao;
  // final PhcRepository phcRepository;
  List<Patient> blocPatients = new List<Patient>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController idTypeController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();

  PatientBloc(
      {
      // @required this.phcRepository,
      this.phcDao});
  // : assert(phcRepository != null);

  // @override
  // Future<void> close() {
  //   blocPatients.clear();

  //   nameController.dispose();
  //   idController.dispose();
  //   idTypeController.dispose();
  //   dobController.dispose();
  //   ageController.dispose();
  //   genderController.dispose();

  // return super.clos/e();
  // }

  @override
  PatientState get initialState => PatientEmpty();

  @override
  Stream<PatientState> mapEventToState(PatientEvent event) async* {
    if (event is LoadPatient) {
      yield* _mapLoadPatientToState(event);
    } else if (event is AddPatient) {
      yield* _addPatientToState(event);
    } else if (event is RemovePatient) {
      yield* _removePatientToState(event);
    }
  }

  Stream<PatientState> _mapLoadPatientToState(LoadPatient event) async* {
    // yield PatientLoading();

    yield PatientLoaded(patients: event.patients);
  }

  Stream<PatientState> _addPatientToState(AddPatient event) async* {
    Patient patient =
        new Patient(patientInformation: event.patient.patientInformation);

    final currentState = state;
    // print(blocPatients.length);

    print("ADDD PATIENT");
    final newList = List<Patient>.from(currentState.patients)..add(patient);
    // / blocPatients.add(patient);
    // yield PatientLoading();

    yield PatientLoaded(patients: newList);
  }

  Stream<PatientState> _removePatientToState(RemovePatient event) async* {
    print("REMOVE PATIENT BY 1");
    print("length");

    final currentState = state;
    // print(blocPatients.length);
    final newList = List<Patient>.from(currentState.patients)
      ..removeAt(event.index);
    // final newList = blocPatients.removeAt(event.index);
    yield PatientLoaded(patients: newList);
  }
}
