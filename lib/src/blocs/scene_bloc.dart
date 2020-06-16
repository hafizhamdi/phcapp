import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SceneEvent extends Equatable {
  final List<String> selectedServices;

  SceneEvent({this.selectedServices});

  @override
  List get props => [selectedServices];
}

abstract class SceneState extends Equatable {
  final List<String> selectedServices;

  SceneState({this.selectedServices});

  @override
  List get props => [selectedServices];
}

class LoadScene extends SceneEvent {
  final List<String> selectedServices;

  LoadScene({this.selectedServices});

  @override
  List get props => [selectedServices];
}

class ResetScene extends SceneEvent {}

class SetScene extends SceneEvent {
  final selectedServices;

  SetScene({this.selectedServices});

  @override
  List get props => [selectedServices];
}

class LoadedScene extends SceneState {
  final List<String> selectedServices;

  LoadedScene({this.selectedServices});

  @override
  List get props => [selectedServices];
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
    yield LoadedScene(selectedServices: event.selectedServices);
  }
}
