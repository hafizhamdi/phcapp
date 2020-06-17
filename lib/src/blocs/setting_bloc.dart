import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/environment_model.dart';

var environment = [
  new Environment(id: "dev", name: "Development", ip: "202.171.33.109"),
  new Environment(id: "uat", name: "UAT", ip: "202.171.33.112"),
  new Environment(id: "hrpb", name: "HRPB", ip: "202.171.33.112"),
];

abstract class SettingEvent extends Equatable {
  final String toggleEnv;
  final lastSynced;

  SettingEvent({this.lastSynced, this.toggleEnv});

  @override
  List get props => [lastSynced, toggleEnv];
}

abstract class SettingState extends Equatable {
  final String toggleEnv;
  final lastSynced;
  final Environment environment;

  SettingState({this.lastSynced, this.toggleEnv, this.environment});

  @override
  List get props => [lastSynced, toggleEnv, environment];
}

class ToggleEnvironment extends SettingEvent {
  final toggleEnv;

  ToggleEnvironment({this.toggleEnv});

  @override
  List get props => [toggleEnv];
}

class PressSyncButton extends SettingEvent {
  final lastSynced;

  PressSyncButton({this.lastSynced});

  @override
  List get props => [lastSynced];
}

class ToggledEnvironment extends SettingState {
  final toggleEnv;

  ToggledEnvironment({this.toggleEnv});

  @override
  List get props => [toggleEnv];
}

class EmptySync extends SettingState {}

class LastSynced extends SettingState {
  final lastSynced;

  LastSynced({this.lastSynced});

  @override
  List get props => [lastSynced];
}

class LoadedSetting extends SettingState {
  final lastSynced;
  final toggleEnv;
  final Environment environment;

  LoadedSetting({this.lastSynced, this.toggleEnv, this.environment});

  @override
  List get props => [lastSynced, toggleEnv, environment];
}

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  @override
  SettingState get initialState => EmptySync();

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is ToggleEnvironment) {
      yield* mapToggleEnvironment(event);
    } else if (event is PressSyncButton) {
      yield* mapPressSyncButton(event);
    }
  }

  Stream<SettingState> mapToggleEnvironment(ToggleEnvironment event) async* {
    var selectedEnv = environment.firstWhere((f) => f.id == event.toggleEnv);

    print(selectedEnv.name);
    yield LoadedSetting(
        lastSynced: state.lastSynced,
        toggleEnv: event.toggleEnv,
        environment: selectedEnv);
    // yield ToggledEnvironment(toggleEnv: event.toggleEnv);
  }

  Stream<SettingState> mapPressSyncButton(PressSyncButton event) async* {
    // yield LastSynced(lastSynced: event.lastSynced);
    yield LoadedSetting(
        toggleEnv: state.toggleEnv,
        lastSynced: event.lastSynced,
        environment: state.environment);
  }
}
