import 'dart:async';

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
  final assign_id;
  final SceneAssessment sceneAssessment;
  final List<Patient> patients;

  LoadPatient({this.assign_id, this.sceneAssessment, this.patients});

  @override
  List<Object> get props => [patients, sceneAssessment];
}

class AddSceneAssessment extends PatientEvent {
  final assign_id;
  final SceneAssessment sceneAssessment;
  final List<Patient> patients;

  AddSceneAssessment({this.assign_id, this.sceneAssessment, this.patients});

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
  final SceneAssessment sceneAssessment;

  PatientLoaded({this.patients, this.sceneAssessment});

  @override
  List<Object> get props => [patients];
}

class PatientEmpty extends PatientState {}

class PatientLoading extends PatientState {}

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PhcDao phcDao;
  // final PhcRepository phcRepository;
  List<Patient> patients;
  TextEditingController nameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController idTypeController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  SceneAssessment sceneAssessment;

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
    } else if (event is AddSceneAssessment) {}
  }

  Stream<PatientState> _mapLoadPatientToState(LoadPatient event) async* {
    // final result = await phcDao.getPhcPatientList(event.assign_id);

    final currentState = state;
    // sceneAssessment = event.sceneAssessment;

    patients = event.patients != null ? event.patients : new List<Patient>();

    sceneAssessment = event.sceneAssessment != null
        ? event.sceneAssessment
        : new SceneAssessment();
    // final newList = List<Patient>.from(result)
    // result.
    // final currentState = state;
// currentState.patients

    // print(result);
    // yield PatientLoading();

    yield PatientLoaded(patients: patients, sceneAssessment: sceneAssessment);
  }

  Stream<PatientState> _mapAddSceneAssessmentToState(
      AddSceneAssessment event) async* {
    // final result = await phcDao.getPhcPatientList(event.assign_id);
    final currentState = state;

    sceneAssessment = event.sceneAssessment;
    patients = event.patients;
    // final newList = List<Patient>.from(result)
    // result.
    // final currentState = state;
// currentState.patients

    // print(result);
    // yield PatientLoading();

    yield PatientLoaded(patients: patients, sceneAssessment: sceneAssessment);
  }

  Stream<PatientState> _addPatientToState(AddPatient event) async* {
    Patient patient =
        new Patient(patientInformation: event.patient.patientInformation);

    final currentState = state;
    // print(blocPatients.length);

    print("ADDD PATIENT");
    print(currentState.patients);
    final newList = List<Patient>.from(currentState.patients)..add(patient);
    print(newList.length);
    // / blocPatients.add(patient);

    patients = newList;
    // yield PatientLoading();

    yield PatientLoaded(patients: newList, sceneAssessment: sceneAssessment);
  }

  Stream<PatientState> _removePatientToState(RemovePatient event) async* {
    print("REMOVE PATIENT BY 1");
    print("length");

    final currentState = state;
    // print(blocPatients.length);
    final newList = List<Patient>.from(currentState.patients)
      ..removeAt(event.index);

    patients = newList;
    // final newList = blocPatients.removeAt(event.index);
    yield PatientLoaded(patients: newList, sceneAssessment: sceneAssessment);
  }
}
