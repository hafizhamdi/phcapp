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
  VitalEvent();
}

class LoadVital extends VitalEvent {
  final assign_id;
  final List<VitalSign> listVitals;

  LoadVital({this.assign_id, this.listVitals});

  @override
  List<Object> get props => [listVitals];
}

class AddVital extends VitalEvent {
  VitalSign vital;
  AddVital({this.vital});

  @override
  List<Object> get props => [vital];
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

    yield VitalLoaded(listVitals: new List<VitalSign>());
  }

  Stream<VitalState> _addVitalToState(AddVital event) async* {
    // Patient patient =
    //     new Patient(patientInformation: event.patient.patientInformation);

    final currentState = state;
    // // print(blocPatients.length);

    // print("ADDD PATIENT");
    final newList = List<VitalSign>.from(currentState.listVitals)
      ..add(event.vital);
    // / blocPatients.add(patient);
    // yield PatientLoading();
    print("vitlas lenghts");
    print(newList.length);

    yield VitalLoaded(listVitals: newList);
  }

  Stream<VitalState> _removeVitalToState(RemoveVital event) async* {
    //   print("REMOVE PATIENT BY 1");
    //   print("length");

    //   final currentState = state;
    //   // print(blocPatients.length);
    //   final newList = List<VitalSign>.from(currentState.patients)
    //     ..removeAt(event.index);
    //   // final newList = blocPatients.removeAt(event.index);
    //   yield VitalLoaded(patients: newList);
  }
}
