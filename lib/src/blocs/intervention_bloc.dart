import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class InterEvent extends Equatable {
  // InterEvent();
  final InterventionAss inter;
  InterEvent({this.inter});

  @override
  List<Object> get props => [inter];
}

class UpdateInter extends InterEvent {
  final InterventionAss inter;
  UpdateInter({this.inter});

  @override
  List<Object> get props => [inter];
}

class LoadInter extends InterEvent {
  final InterventionAss inter;
  LoadInter({this.inter});

  @override
  List<Object> get props => [inter];
}

abstract class InterState extends Equatable {
  final InterventionAss inter;
  InterState({this.inter});

  @override
  List<Object> get props => [inter];
}

class InterEmpty extends InterState {}

class InterLoaded extends InterState {
  final InterventionAss inter;
  InterLoaded({this.inter});

  @override
  List<Object> get props => [inter];
}

class InterBloc extends Bloc<InterEvent, InterState> {
  @override
  // TODO: implement initialState
  InterState get initialState => InterEmpty();

  @override
  Stream<InterState> mapEventToState(InterEvent event) async* {
    if (event is LoadInter) {
      yield* _mapLoadInterToState(event);
    } else if (event is UpdateInter) {
      yield* _mapUpdateInterToState(event);
    }
  }

  Stream<InterState> _mapLoadInterToState(LoadInter event) async* {
    yield InterLoaded(inter: event.inter);
  }

  Stream<InterState> _mapUpdateInterToState(UpdateInter event) async* {
    yield InterLoaded(inter: event.inter);
  }
}
