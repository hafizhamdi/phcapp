import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:bloc/bloc.dart';
import 'package:phcapp/src/models/phc_staff.dart';
import 'package:phcapp/src/repositories/repositories.dart';

abstract class StaffEvent extends Equatable {
  StaffEvent();
}

class FetchStaff extends StaffEvent {
  FetchStaff();

  @override
  List<Object> get props => [];
}

class LoadStaff extends StaffEvent {
  final List<Staff> selectedStaffs;

  LoadStaff({this.selectedStaffs});

  @override
  List<Object> get props => [selectedStaffs];
  // LoadStaff();

  // @override
  // List<Object> get props => [];
}

// class AddStaff extends StaffEvent {
//   Staff staff;
//   AddStaff({this.staff});

//   @override
//   List<Object> get props => [staff];
// }

// class RemoveStaff extends StaffEvent {
//   Staff staff;
//   RemoveStaff({this.staff});

//   @override
//   List<Object> get props => [staff];
// }

abstract class StaffState extends Equatable {
  final List<Staff> selectedStaffs;

  StaffState({this.selectedStaffs});

  @override
  List<Object> get props => [selectedStaffs];
}

class StaffFetched extends StaffState {
  final List<Staff> available_staffs;

  StaffFetched({this.available_staffs});

  @override
  List<Object> get props => [available_staffs];
}

class StaffLoaded extends StaffState {
  final List<Staff> selectedStaffs;

  StaffLoaded({this.selectedStaffs});

  @override
  List<Object> get props => [selectedStaffs];
}

class StaffFetching extends StaffState {}

class StaffFetchingError extends StaffState {}

class StaffEmpty extends StaffState {}

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final PhcDao phcDao;
  final PhcRepository phcRepository;
  // List<Staff> selectedStaffs = new List<Staff>();

  StaffBloc({@required this.phcRepository, this.phcDao})
      : assert(phcRepository != null);

  @override
  StaffState get initialState => StaffEmpty();

  @override
  Stream<StaffState> mapEventToState(StaffEvent event) async* {
    if (event is FetchStaff) {
      yield* _mapFetchStaffToState(event);
    }
    // else if (event is LoadStaff) {
    // yield* _mapLoadStaffToState(event);
    // } else if (event is AddStaff) {
    //   print("this addstaff event");
    //   yield* _addStaffToState(event);
    // } else if (event is RemoveStaff) {
    //   yield* _removeStaffToState(event);
    // }
  }

  Stream<StaffState> _mapFetchStaffToState(FetchStaff event) async* {
    yield StaffFetching();
    try {
      final staffs = await phcDao.getStaffs();

      // fetchStaffs = staffs;

      // final staffs = await phcRepository.getAvailableStaffs();

      print(staffs);
      // print(newList);
      yield StaffFetched(available_staffs: staffs);
    } catch (_) {
      yield StaffFetchingError();
    }
  }

  Stream<StaffState> _mapLoadStaffToState(LoadStaff event) async* {
    print("loaded staff");
    StaffLoaded(selectedStaffs: event.selectedStaffs);
  }
}
