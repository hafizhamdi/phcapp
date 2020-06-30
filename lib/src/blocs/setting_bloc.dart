import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/environment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

var environment = [
  new Environment(id: "dev", name: "Development", ip: "202.171.33.109"),
  new Environment(id: "uat", name: "UAT", ip: "202.171.33.112"),
  new Environment(id: "hrpb", name: "HRPB", ip: "10.138.128.129"),
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

class LoadEnvironment extends SettingEvent {
  // final toggleEnv;

  LoadEnvironment();

  @override
  List get props => [];
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

class EmptySetting extends SettingState {}

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
  final PhcDao phcDao;
  SharedPreferences prefs;

  SettingBloc({this.phcDao});

  @override
  SettingState get initialState => EmptySetting();

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is LoadEnvironment) {
      yield* mapLoadEnvironment(event);
    } else if (event is ToggleEnvironment) {
      yield* mapToggleEnvironment(event);
    } else if (event is PressSyncButton) {
      yield* mapPressSyncButton(event);
    }
  }

  Stream<SettingState> mapToggleEnvironment(ToggleEnvironment event) async* {
    var selectedEnv = environment.firstWhere((f) => f.id == event.toggleEnv);

    // prefs = await SharedPreferences.getInstance();

    final updateSetting = await phcDao.updateSettings(selectedEnv);
    // print(updateSetting);

    // await prefs.setString('env_use', event.toggleEnv);

    // print(selectedEnv.name);
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

  Stream<SettingState> mapLoadEnvironment(LoadEnvironment event) async* {
    final environment = await phcDao.getSettings();
    print("in maploadenvironment");
    print(environment.toJson());

    // print(environment.toJson());
    // yield LastSynced(lastSynced: event.lastSynced);
    yield LoadedSetting(
        toggleEnv: environment.id,
        lastSynced: event.lastSynced,
        environment: environment);
  }
}
