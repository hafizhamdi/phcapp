import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';
import 'package:phcapp/src/models/phc_staff.dart';

abstract class TeamEvent extends Equatable {
  final ResponseTeam responseTeam;
  final List<Staff> selectedStaffs;

  TeamEvent({this.responseTeam, this.selectedStaffs});
  @override
  List<Object> get props => [responseTeam, selectedStaffs];
}

class InitTeam extends TeamEvent {}

class ResetTeam extends TeamEvent {}

class LoadTeam extends TeamEvent {
  final ResponseTeam responseTeam;
  final selectedStaffs;
  // final assign_id;

  LoadTeam({this.responseTeam, this.selectedStaffs});

  @override
  List<Object> get props => [responseTeam, selectedStaffs];
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
  final List<Staff> selectedStaffs;

  TeamState({this.response_team, this.selectedStaffs});

  @override
  List<Object> get props => [response_team, selectedStaffs];
}

class TeamLoaded extends TeamState {
  final ResponseTeam response_team;
  final List<Staff> selectedStaffs;

  TeamLoaded({this.response_team, this.selectedStaffs});

  @override
  List<Object> get props => [response_team, selectedStaffs];

  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return "content staffs :" + response_team.staffs.length.toString();
  // }
}

class TeamEmpty extends TeamState {
  // final ResponseTeam response_team;
  // List<Staff> selectedStaffs;

  // TeamEmpty(
  //     {
  //     // this.response_team,
  //     this.selectedStaffs});

  // @override
  // List<Object> get props => [selectedStaffs];
}

class TeamBloc extends Bloc<TeamEvent, TeamState> {
  PhcDao phcDao;
  ResponseTeam response_team;
  List<int> listSelected = new List<int>();
  List<Staff> selectedStaffs = new List<Staff>();

  TeamBloc({this.phcDao}) : assert(phcDao != null);

  @override
  TeamState get initialState => TeamEmpty();

  // @override
  // Future<void> close() {
  //   listSelected = [];

  //   return super.close();
  // }

  @override
  Stream<TeamState> mapEventToState(TeamEvent event) async* {
    if (event is LoadTeam) {
      yield* _mapLoadTeamToState(event);
    } else if (event is AddTeam) {
      yield* _addStaffToState(event);
    } else if (event is RemoveTeam) {
      yield* _removeStaffToState(event);
    } else if (event is AddResponseTeam) {
      yield* _mapAddResponseTeamtoState(event);
      // await phcDao.insertResponseTeam(event.response_team, event.assign_id);

      // yield* _reloadResponseTeam(event.assign_id);
    } else if (event is ResetTeam) {
      selectedStaffs = new List<Staff>();
      listSelected = new List<int>();
      yield TeamEmpty();
    }
  }

  Stream<TeamState> _mapLoadTeamToState(LoadTeam event) async* {
    // assert(phcDao != null);

    // try {
    //   print("Responseteam from sembast");
    //   ResponseTeam resteam = await phcDao.getResponseTeam(event.assign_id);
    //   // selectedStaffs = resteam.staffs;

    //   // print(resteam.
    //   print(resteam.toJson());
    //   yield TeamLoaded(
    //     response_team: resteam,
    //     // selectedStaffs: resteam.staffs
    //   );
    // } catch (_) {
    //   print("Responseteam from phcsembast");
    //   ResponseTeam responseTeam =
    //       await phcDao.getPhcResponseTeam(event.assign_id);
    //   // List<Staff> temp = new List<Staff>();

    //   print(responseTeam.toJson());
    // temp = responseTeam.staffs.map((data) {
    //   Staff Staff =
    //       Staff(staffName: data.name, position: data.position);

    //   return Staff;
    // }).toList();

    // final currentState = state;final currentState = state;
    ResponseTeam responseTeam = new ResponseTeam(
        serviceResponse: event.responseTeam.serviceResponse,
        vehicleRegno: event.responseTeam.vehicleRegno,
        staffs: event.responseTeam.staffs != null
            ? event.responseTeam.staffs
            : new List<Staff>());
    // ResponseTeam responseTeam = new ResponseTeam(
    //     serviceResponse: event.responseTeam.serviceResponse,
    //     vehicleRegno: event.responseTeam.vehicleRegno,
    //     staffs: event.responseTeam.staffs != null
    //         ? event.responseTeam.staffs
    //         : new List<Staff>());

    // responseTeam.staffs = event.responseTeam.staffs != null
    //     ? event.responseTeam.staffs
    //     : new List<Staff>();

    // response_team.staffs = List<Staff>.from(event.responseTeam.staffs).toList();
    // response_team.serviceResponse = event.responseTeam.serviceResponse;
    // response_team.vehicleRegno = event.responseTeam.vehicleRegno;
    // print(responseTeam.toJson());

    // print(event.responseTeam.toJson());

    print("EVENT LOADTEAM");
    // print(event.responseTeam);

    yield TeamLoaded(response_team: responseTeam);
    // }

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
    // print(state);

    // final currentState = state;

    List<Staff> newList = selectedStaffs..add(event.staff);

    // print(newList);
    // ResponseTeam responseTeam = currentState.response_team;
    // if (state is TeamLoaded) {
    // state
    // print(currentState);
    // selectedStaffs.add(event.staff);
    // final newList = List<Staff>.from(responseTeam.staffs)..add(event.staff);
    // newList.removeAt(0);

    // responseTeam.staffs = newList;

    // print("responseTeam.staffs.length");
    // print(responseTeam.staffs.length);
    // print(newList);
    // List<Staff> temp = List<Staff>.from(selectedStaffs)..add(event.staff);
    // print(temp);
    // yield TeamLoaded(
    //     response_team: currentState.response_team, selectedStaffs: newList);
    yield TeamLoaded(
        // response_team: responseTeam,
        selectedStaffs: newList);
    // }
  }

  Stream<TeamState> _removeStaffToState(RemoveTeam event) async* {
    // final currentState = state;
    // ResponseTeam responseTeam = currentState.response_team;

    // if (state is TeamLoaded) {
    // selectedStaffs.add(event.staff);
    final newList = selectedStaffs..removeAt(event.removeIndex);
    // print(newList);
    // responseTeam.staffs = newList; // = newList;

    // remove from selected list tick
    listSelected.removeAt(event.removeIndex);
    print("--removelength");
    // currentState.response_team.staffs.removeAt(event.removeIndex);

    print("responseTeam.staffs.length");
    // print(responseTeam.staffs.length);
    // yield currentState;
    yield TeamLoaded(
        // response_team: responseTeam,
        selectedStaffs: newList);
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

  Stream<TeamState> _mapAddResponseTeamtoState(AddResponseTeam event) async* {
    // final currentState = state;

    print("addreponesteam");
    // print(event.response_team.toJson());
    response_team = event.response_team;

    yield TeamLoaded(response_team: response_team);
  }
}
