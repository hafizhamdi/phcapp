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
  final List<Patient> patients;

  PatientEvent({this.patients});
  @override
  List get props => [patients];
}

class LoadPatient extends PatientEvent {
  // final assign_id;
  // final SceneAssessment sceneAssessment;
  final List<Patient> patients;

  LoadPatient(
      {
      // this.assign_id,
      // this.sceneAssessment,
      this.patients});

  @override
  List<Object> get props => [
        patients,
        // sceneAssessment
      ];
}

class UpdateSceneService extends PatientEvent {
  final List<String> selected;

  UpdateSceneService({this.selected});

  @override
  List get props => [selected];
}

class InitPatient extends PatientEvent {}

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

class UpdatePatient extends PatientEvent {
  final int index;
  final Patient patient;
  UpdatePatient({this.patient, this.index});

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
  // final SceneAssessment sceneAssessment;
  // final List<String> selectedOtherServices;

  PatientState({
    this.patients,
    // this.sceneAssessment, this.selectedOtherServices
  });

  @override
  List<Object> get props => [
        patients,
        //  sceneAssessment
      ];
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
  // List<Patient> patients = new List<Patient>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController idTypeController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  SceneAssessment sceneAssessment;

  final formKey = GlobalKey<FormState>();

  List<String> selectedChipOtherServices = new List<String>();

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
    } else if (event is AddSceneAssessment) {
      yield* _addSceneToState(event);
    } else if (event is UpdatePatient) {
      yield* _updatePatientToState(event);
    } else if (event is InitPatient) {
      yield PatientEmpty();
    }
  }

  Stream<PatientState> _addSceneToState(AddSceneAssessment event) async* {
    OtherServices otherServices = OtherServices();
    if (event.sceneAssessment.otherServicesAtScene == null) {
      otherServices = event.sceneAssessment.otherServicesAtScene;
    }

    yield PatientLoaded(patients: event.patients
        // sceneAssessment: SceneAssessment(
        //   otherServicesAtScene: otherServices,
        //   // typeResponse: ""
        // )
        );
  }

  Stream<PatientState> _mapLoadPatientToState(LoadPatient event) async* {
    // final result = await phcDao.getPhcPatientList(event.assign_id);

    // final currentState = state;
    // sceneAssessment = event.sceneAssessment;

    // patients = event.patients != null ? event.patients : new List<Patient>();

    // print("Patient BLOC");

    // sceneAssessment = event.sceneAssessment != null
    // ? event.sceneAssessment
    // : new SceneAssessment();
    // final newList = List<Patient>.from(result)
    // result.
    // print(sceneAssessment);
    // final currentState = state;
// currentState.patients

    // print(result);
    // yield PatientLoading();

    yield PatientLoaded(
      patients: event.patients,
      // sceneAssessment: sceneAssessment,
    );
  }

//   Stream<PatientState> _mapAddSceneAssessmentToState(
//       AddSceneAssessment event) async* {
//     // final result = await phcDao.getPhcPatientList(event.assign_id);
//     final currentState = state;

//     sceneAssessment = event.sceneAssessment;
//     patients = event.patients;
//     // final newList = List<Patient>.from(result)
//     // result.
//     // final currentState = state;
// // currentState.patients

//     // print(result);
//     // yield PatientLoading();

//     yield PatientLoaded(patients: patients);
//   }

  Stream<PatientState> _addPatientToState(AddPatient event) async* {
    Patient patient = new Patient(
        patientInformation: event.patient.patientInformation,
        cprLog: event.patient.cprLog,
        vitalSigns: event.patient.vitalSigns,
        patientAssessment: event.patient.patientAssessment,
        intervention: event.patient.intervention,
        traumaAssessment: event.patient.traumaAssessment,
        medicationAssessment: event.patient.medicationAssessment,
        incidentReporting: event.patient.incidentReporting,
        outcome: event.patient.outcome,
        samplerAssessment: event.patient.samplerAssessment,
        otherAssessment: event.patient.otherAssessment);

    final currentState = state;
    // print(blocPatients.length);

    print("ADDD PATIENT");
    // print(patient.toJson());
    final newList = List<Patient>.from(
        currentState.patients != null ? currentState.patients : [])
      ..add(patient);
    // print(newList.length);
    // / blocPatients.add(patient);

    // patients = newList;
    // yield PatientLoading();

    yield PatientLoaded(
      patients: newList,
      // sceneAssessment: sceneAssessment
    );
  }

  Stream<PatientState> _updatePatientToState(UpdatePatient event) async* {
    final currentState = state;

    final foundPatient = currentState.patients.firstWhere((data) =>
        data.patientInformation.name == event.patient.patientInformation.name);

    foundPatient.patientInformation = event.patient.patientInformation;
    foundPatient.cprLog = event.patient.cprLog;
    foundPatient.vitalSigns = event.patient.vitalSigns;
    // vitalSigns: event.patient.vitalSigns,
    foundPatient.patientAssessment = event.patient.patientAssessment;
    foundPatient.intervention = event.patient.intervention;
    foundPatient.traumaAssessment = event.patient.traumaAssessment;
    foundPatient.medicationAssessment = event.patient.medicationAssessment;
    foundPatient.incidentReporting = event.patient.incidentReporting;
    foundPatient.outcome = event.patient.outcome;
    foundPatient.samplerAssessment = event.patient.samplerAssessment;
    foundPatient.otherAssessment = event.patient.otherAssessment;

    print("UPDATE PATIENT");
    // print(currentState.patients);
    final newList = List<Patient>.from(currentState.patients)
      ..replaceRange(event.index, event.index + 1, [foundPatient]);
    print(newList.length);
    // / blocPatients.add(patient);

    // patients = newList;
    // yield PatientLoading();

    yield PatientLoaded(
      patients: newList,
      // sceneAssessment: sceneAssessment
    );
  }

  Stream<PatientState> _removePatientToState(RemovePatient event) async* {
    print("REMOVE PATIENT BY 1");
    print("length");

    final currentState = state;
    // print(blocPatients.length);
    final newList = List<Patient>.from(currentState.patients)
      ..removeAt(event.index);

    // patients = newList;
    // final newList = blocPatients.removeAt(event.index);
    yield PatientLoaded(
      patients: newList,
      // sceneAssessment: sceneAssessment
    );
  }
}
