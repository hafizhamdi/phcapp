import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';
import 'package:phcapp/src/repositories/repositories.dart';

abstract class VitalEvent extends Equatable {
  final List<VitalSign> listVitals;
  VitalEvent({this.listVitals});
  @override
  List get props => [listVitals];
}

class LoadVital extends VitalEvent {
  final assign_id;
  final List<VitalSign> listVitals;

  LoadVital({this.assign_id, this.listVitals});

  @override
  List<Object> get props => [listVitals];
}

class ResetVital extends VitalEvent {}

class AddVital extends VitalEvent {
  VitalSign vital;
  AddVital({this.vital});

  @override
  List<Object> get props => [vital];
}

class UpdateVital extends VitalEvent {
  final VitalSign vital;
  final index;
  UpdateVital({this.vital, this.index});

  @override
  List<Object> get props => [vital, index];
}

class RemoveVital extends VitalEvent {
  int index;
  RemoveVital({this.index});

  @override
  List<Object> get props => [index];
}

abstract class VitalState extends Equatable {
  final List<VitalSign> listVitals;

  VitalState({this.listVitals});

  @override
  List<Object> get props => [listVitals];
}

class VitalLoaded extends VitalState {
  final List<VitalSign> listVitals;

  VitalLoaded({this.listVitals});

  @override
  List<Object> get props => [listVitals];
}

class VitalEmpty extends VitalState {}

class VitalLoading extends VitalState {}

class VitalBloc extends Bloc<VitalEvent, VitalState> {
  final PhcDao phcDao;
  // final PhcRepository phcRepository;
  // List<Patient> blocPatients = new List<Patient>();
  // TextEditingController nameController = new TextEditingController();
  // TextEditingController idController = new TextEditingController();
  // TextEditingController idTypeController = new TextEditingController();
  // TextEditingController dobController = new TextEditingController();
  // TextEditingController ageController = new TextEditingController();
  // TextEditingController genderController = new TextEditingController();

  VitalBloc(
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
  VitalState get initialState => VitalEmpty();

  @override
  Stream<VitalState> mapEventToState(VitalEvent event) async* {
    if (event is LoadVital) {
      yield* _mapLoadVitalToState(event);
    } else if (event is AddVital) {
      yield* _addVitalToState(event);
    } else if (event is RemoveVital) {
      yield* _removeVitalToState(event);
    } else if (event is UpdateVital) {
      yield* _updateVitalToState(event);
    } else if (event is ResetVital) {
      yield VitalEmpty();
    }
  }

  Stream<VitalState> _mapLoadVitalToState(LoadVital event) async* {
    // final result = await phcDao.getPhcPatientList(event.assign_id);

    // final newList = List<Patient>.from(result)
    // result.
    // final currentState = state;
// currentState.patients

    // print(result);
    // yield PatientLoading();

    yield VitalLoaded(listVitals: event.listVitals);
  }

  Stream<VitalState> _addVitalToState(AddVital event) async* {
    yield VitalLoading();
    // Patient patient =
    //     new Patient(patientInformation: event.patient.patientInformation);

    final currentState = state;
    // // print(blocPatients.length);

    // print("ADDD PATIENT");
    final newList = List<VitalSign>.from(
        currentState.listVitals != null ? currentState.listVitals : [])
      ..add(event.vital);
    // / blocPatients.add(patient);
    // yield PatientLoading();
    print(event.vital.toJson());
    print("vitlas lenghts");
    print(newList.length);

    yield VitalLoaded(listVitals: newList);
  }

  Stream<VitalState> _updateVitalToState(UpdateVital event) async* {
    yield VitalLoading();
    final currentState = state;

    final foundVital = currentState.listVitals
        .firstWhere((data) => data.id == (event.index + 1).toString());

    foundVital.created = event.vital.created;
    foundVital.bpDiastolic = event.vital.bpDiastolic;
    foundVital.bpSystolic = event.vital.bpSystolic;
    foundVital.map = event.vital.map;
    foundVital.pr = event.vital.pr;
    foundVital.rr = event.vital.rr;
    foundVital.gcs = event.vital.gcs;
    foundVital.e = event.vital.e;
    foundVital.m = event.vital.m;
    foundVital.v = event.vital.v;
    foundVital.shockIndex = event.vital.shockIndex;
    foundVital.spo2 = event.vital.spo2;
    foundVital.pulsePressure = event.vital.pulsePressure;
    foundVital.pulseVolume = event.vital.pulseVolume;
    foundVital.cardiacRhythm = event.vital.cardiacRhythm;
    foundVital.bloodKetone = event.vital.bloodKetone;
    foundVital.crt = event.vital.crt;
    foundVital.painScore = event.vital.painScore;
    foundVital.temp = event.vital.temp;
    foundVital.pupil.rightResponseTolight =
        event.vital.pupil.rightResponseTolight;
    foundVital.pupil.rightSize = event.vital.pupil.rightSize;
    foundVital.pupil.leftResponseTolight =
        event.vital.pupil.leftResponseTolight;
    foundVital.pupil.leftSize = event.vital.pupil.leftSize;

    final newList = List<VitalSign>.from(currentState.listVitals)
      ..replaceRange(event.index, event.index + 1, [foundVital]);

    yield VitalLoaded(listVitals: newList);
  }

  Stream<VitalState> _removeVitalToState(RemoveVital event) async* {
    yield VitalLoading();
    //   print("REMOVE PATIENT BY 1");
    //   print("length");

    final currentState = state;
    // print(blocPatients.length);
    final newList = List<VitalSign>.from(currentState.listVitals)
      ..removeAt(event.index);
    // final newList = blocPatients.removeAt(event.index);
    yield VitalLoaded(listVitals: newList);
  }
}
