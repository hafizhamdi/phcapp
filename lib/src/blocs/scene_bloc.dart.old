import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';

abstract class SceneEvent extends Equatable {
  SceneEvent();
}

class LoadScene extends SceneEvent {
  final SceneAssessment sceneAssessment;

  LoadScene({this.sceneAssessment});
  @override
  List<Object> get props => [sceneAssessment];
}

class AddSceneAssessment extends SceneEvent {
  final SceneAssessment sceneAssessment;

  AddSceneAssessment({this.sceneAssessment});

  @override
  List<Object> get props => [sceneAssessment];
}

abstract class SceneState extends Equatable {
  final SceneAssessment sceneAssessment;

  SceneState({this.sceneAssessment});

  @override
  List<Object> get props => [sceneAssessment];
}

class SceneLoaded extends SceneState {
  final SceneAssessment sceneAssessment;

  SceneLoaded({this.sceneAssessment});

  @override
  List<Object> get props => [sceneAssessment];
}

class SceneEmpty extends SceneState {}

class SceneBloc extends Bloc<SceneEvent, SceneState> {
  PhcDao phcDao;
  SceneBloc({this.phcDao}) : assert(phcDao != null);

  @override
  SceneState get initialState => SceneEmpty();

  @override
  Stream<SceneState> mapEventToState(SceneEvent event) async* {
    if (event is LoadScene) {
      yield* _mapLoadSceneToState(event);
    } else if (event is AddSceneAssessment) {}
  }

  Stream<SceneState> _mapLoadSceneToState(LoadScene event) async* {
    try {
      yield SceneLoaded();
    } catch (_) {
      yield SceneLoaded(sceneAssessment: event.sceneAssessment);
    }
  }
}
