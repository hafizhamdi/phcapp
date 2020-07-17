import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/database/phc_dao.dart';

abstract class PlateEvent extends Equatable {}

abstract class PlateState extends Equatable {
  final available_plateno;

  PlateState({this.available_plateno});

  @override
  // TODO: implement props
  List get props => [available_plateno];
}

class LoadPlate extends PlateEvent {}

class LoadedPlate extends PlateState {
  final available_plateno;

  LoadedPlate({this.available_plateno});

  @override
  // TODO: implement props
  List get props => [available_plateno];
}

class LoadingPlate extends PlateState {}

class EmptyPlate extends PlateState {}

class PlateBloc extends Bloc<PlateEvent, PlateState> {
  final PhcDao phcDao;
  // List<Staff> selectedStaffs = new List<Staff>();

  PlateBloc({this.phcDao});

  @override
  // TODO: implement initialState
  PlateState get initialState => EmptyPlate();

  @override
  Stream<PlateState> mapEventToState(PlateEvent event) async* {
    if (event is LoadPlate) {
      yield* mapLoadPlate(event);
    }
  }

  Stream<PlateState> mapLoadPlate(LoadPlate event) async* {
    yield LoadingPlate();
    // try {
    final listPlateNo = await phcDao.getPlateNo();

    // fetchStaffs = staffs;

    // final staffs = await phcRepository.getAvailableStaffs();

    print(listPlateNo);
    // print(newList);
    yield LoadedPlate(available_plateno: listPlateNo);
    // } catch (_) {
    //   yield StaffFetchingError();
    // }
  }
}
