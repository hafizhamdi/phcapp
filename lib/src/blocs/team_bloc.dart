import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';
import 'package:phcapp/src/models/phc_staff.dart';

abstract class TeamEvent extends Equatable {
  TeamEvent();
}

class LoadTeam extends TeamEvent {
  final assign_id;

  LoadTeam({this.assign_id});

  @override
  List<Object> get props => [assign_id];
}

class AddTeam extends TeamEvent {
  Staff staff;
  AddTeam({this.staff});

  @override
  List<Object> get props => [staff];
}

class AddResponseTeam extends TeamEvent {
  final ResponseTeam response_team;
  final assign_id;
  AddResponseTeam({this.response_team, this.assign_id});

  @override
  List<Object> get props => [response_team, assign_id];
}

class RemoveTeam extends TeamEvent {
  int removeIndex;
  RemoveTeam({this.removeIndex});

  @override
  List<Object> get props => [removeIndex];
}

abstract class TeamState extends Equatable {
  final ResponseTeam response_team;
  // final List<Staff> selectedStaffs;

  TeamState({
    this.response_team,
    // this.selectedStaffs
  });

  @override
  List<Object> get props => [response_team];
}

class TeamLoaded extends TeamState {
  final ResponseTeam response_team;
  // final List<Staff> selectedStaffs;

  TeamLoaded({
    this.response_team,
    // this.selectedStaffs
  });

  @override
  List<Object> get props => [
        response_team,
        // selectedStaffs
      ];
}

class TeamEmpty extends TeamState {}

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  PhcDao phcDao;
  ResponseTeam response_team;
  List<Staff> selectedStaffs;

  TeamBloc({this.phcDao}) : assert(phcDao != null);

  @override
  TeamState get initialState => TeamEmpty();

  @override
  Stream<TeamState> mapEventToState(TeamEvent event) async* {
    if (event is LoadTeam) {
      yield* _mapLoadTeamToState(event);
    } else if (event is AddTeam) {
      yield* _addStaffToState(event);
    } else if (event is RemoveTeam) {
      yield* _removeStaffToState(event);
    } else if (event is AddResponseTeam) {
      await phcDao.insertResponseTeam(event.response_team, event.assign_id);

      yield* _reloadResponseTeam(event.assign_id);
    }
    // else if (event is AddStaff) {
  }

  Stream<TeamState> _mapLoadTeamToState(LoadTeam event) async* {
    assert(phcDao != null);

    try {
      print("Responseteam from sembast");
      ResponseTeam resteam = await phcDao.getResponseTeam(event.assign_id);
      // selectedStaffs = resteam.staffs;

      // print(resteam.
      print(resteam.toJson());
      yield TeamLoaded(
        response_team: resteam,
        // selectedStaffs: resteam.staffs
      );
    } catch (_) {
      print("Responseteam from phcsembast");
      ResponseTeam responseTeam =
          await phcDao.getPhcResponseTeam(event.assign_id);
      // List<Staff> temp = new List<Staff>();

      print(responseTeam.toJson());
      // temp = responseTeam.staffs.map((data) {
      //   Staff Staff =
      //       Staff(staffName: data.name, position: data.position);

      //   return Staff;
      // }).toList();

      // responseTeam.staffs = temp;
      // print(responseTeam.toJson());

      yield TeamLoaded(
        response_team: responseTeam,
        // selectedStaffs: responseTeam.staffs
      );
    }

    // final responseTeam = await phcDao.getPhcResponseTeam(event.assign_id);
    // print("_mapLoadTeam");
    // print(responseTeam.toJson());

    // List<Staff> temp = new List<Staff>();

    // temp = responseTeam.staffs.map((data) {
    //   Staff Staff =
    //       Staff(staffName: data.name, position: data.position);

    //   return Staff;
    // }).toList();

    // print(temp);
    // yield TeamLoaded(
    // response_team: responseTeam
    // selectedStaffs: temp);
  }

  Stream<TeamState> _addStaffToState(AddTeam event) async* {
    print("currentTstate");
    print(state);

    final currentState = state;
    if (state is TeamLoaded) {
      // state
      // print(currentState);
      // selectedStaffs.add(event.staff);
      final newList = List<Staff>.from(currentState.response_team.staffs)
        ..add(event.staff);
      // newList.removeAt(0);

      currentState.response_team.staffs = newList;

      // print(newList);

      // yield TeamLoaded(
      //     response_team: currentState.response_team, selectedStaffs: newList);
      yield TeamLoaded(
        response_team: currentState.response_team,
        // selectedStaffs: newList
      );
    }
  }

  Stream<TeamState> _removeStaffToState(RemoveTeam event) async* {
    final currentState = state;
    // if (state is TeamLoaded) {
    // selectedStaffs.add(event.staff);
    final newList = List<Staff>.from(currentState.response_team.staffs)
      ..removeAt(event.removeIndex);
    // print(newList);
    currentState.response_team.staffs = newList; // = newList;

    print("--removelength");
    // currentState.response_team.staffs.removeAt(event.removeIndex);

    // yield currentState;
    yield TeamLoaded(
      response_team: currentState.response_team,
      // selectedStaffs: newList
    );
    // yield TeamState(selectedStaffs: newList);
    // }
  }

  Stream<TeamState> _reloadResponseTeam(assign_id) async* {
    assert(phcDao != null);

    try {
      final resteam = await phcDao.getResponseTeam(assign_id);
      yield TeamLoaded(
        response_team: resteam,
        // selectedStaffs: resteam.staffs
      );
    } catch (_) {
      final resteam = await phcDao.getPhcResponseTeam(assign_id);
      yield TeamLoaded(
        response_team: resteam,
        // selectedStaffs: resteam.staffs
      );
    }
  }
}
