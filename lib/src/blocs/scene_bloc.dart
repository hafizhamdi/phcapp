import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class SceneEvent extends Equatable {
  final PPE selectedPPE;
  final List<String> selectedEnvironment;
  final List<String> selectedCaseType;
  final List<String> selectedPatient;
  final List<String> selectedBackup;
  final OtherServices selectedServices;

  SceneEvent({
    this.selectedPPE,
    this.selectedEnvironment,
    this.selectedCaseType,
    this.selectedPatient,
    this.selectedBackup,
    this.selectedServices,});

  @override
  List get props => [selectedPPE, selectedEnvironment,selectedCaseType, 
  selectedPatient, selectedBackup, selectedServices];
}

abstract class SceneState extends Equatable {
  final PPE selectedPPE;
  final List<String> selectedEnvironment;
  final List<String> selectedCaseType;
  final List<String> selectedPatient;
  final List<String> selectedBackup;
  final OtherServices selectedServices;

  SceneState({
    this.selectedPPE,
    this.selectedEnvironment,
    this.selectedCaseType,
    this.selectedPatient,
    this.selectedBackup,
    this.selectedServices,
    });

  @override
  List get props => [selectedPPE, selectedEnvironment,selectedCaseType, 
  selectedPatient, selectedBackup, selectedServices];
}

class LoadScene extends SceneEvent {
  final PPE selectedPPE;
  final List<String> selectedEnvironment;
  final List<String> selectedCaseType;
  final List<String> selectedPatient;
  final List<String> selectedBackup;
  final OtherServices selectedServices;

  LoadScene({
    this.selectedPPE,
    this.selectedEnvironment,
    this.selectedCaseType,
    this.selectedPatient,
    this.selectedBackup,
    this.selectedServices
    });

  @override
  List get props => [selectedPPE, selectedEnvironment,selectedCaseType, 
  selectedPatient, selectedBackup, selectedServices];
}

class ResetScene extends SceneEvent {}

class SetScene extends SceneEvent {
  final selectedPPE;
  final selectedEnvironment;
  final selectedCaseType;
  final selectedPatient;
  final selectedBackup;
  final selectedServices;

  SetScene({
    this.selectedPPE,
    this.selectedEnvironment,
    this.selectedCaseType,
    this.selectedPatient,
    this.selectedBackup,
    this.selectedServices
    });

  @override
  List get props => [selectedPPE, selectedEnvironment,selectedCaseType, 
  selectedPatient, selectedBackup, selectedServices];
}

class LoadedScene extends SceneState {
  final PPE selectedPPE;
  final List<String> selectedEnvironment;
  final List<String> selectedCaseType;
  final List<String> selectedPatient;
  final List<String> selectedBackup;
  final OtherServices selectedServices;

  LoadedScene({
    this.selectedPPE,
    this.selectedEnvironment,
    this.selectedCaseType,
    this.selectedPatient,
    this.selectedBackup,
    this.selectedServices
    });

  @override
  List get props => [selectedPPE, selectedEnvironment,selectedCaseType, 
  selectedPatient, selectedBackup, selectedServices];
}

class EmptyScene extends SceneState {}

class SceneBloc extends Bloc<SceneEvent, SceneState> {
  @override
  SceneState get initialState => EmptyScene();

  @override
  Stream<SceneState> mapEventToState(SceneEvent event) async* {
    if (event is LoadScene) {
      yield* mapLoadSceneToState(event);
    } else if (event is ResetScene) {
      yield EmptyScene();
    }
  }

  Stream<SceneState> mapLoadSceneToState(LoadScene event) async* {
    yield LoadedScene(
      selectedPPE:  event.selectedPPE,
      selectedEnvironment:  event.selectedEnvironment, 
      selectedCaseType: event.selectedCaseType,
      selectedPatient: event.selectedPatient,
      selectedBackup: event.selectedBackup,
      selectedServices: event.selectedServices);
  }
}
