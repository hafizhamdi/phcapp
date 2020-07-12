import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class SamplerEvent extends Equatable {
  final SamplerAssessment samplerAssessment;
  SamplerEvent({this.samplerAssessment});

  @override
  List get props => [samplerAssessment];
}

abstract class SamplerState extends Equatable {
  final SamplerAssessment samplerAssessment;
  SamplerState({this.samplerAssessment});

  @override
  List get props => [samplerAssessment];
}

class LoadSampler extends SamplerEvent {
  final SamplerAssessment samplerAssessment;
  LoadSampler({this.samplerAssessment});

  @override
  List get props => [samplerAssessment];
}

class UpdateSampler extends SamplerEvent {
  final SamplerAssessment samplerAssessment;
  UpdateSampler({this.samplerAssessment});

  @override
  List get props => [samplerAssessment];
}

class ResetSampler extends SamplerEvent {}

class LoadedSampler extends SamplerState {
  final SamplerAssessment samplerAssessment;
  LoadedSampler({this.samplerAssessment});

  @override
  List get props => [samplerAssessment];
}

class EmptySampler extends SamplerState {}

class LoadingSampler extends SamplerState {}

class SamplerBloc extends Bloc<SamplerEvent, SamplerState> {
  @override
  // TODO: implement initialState
  SamplerState get initialState => EmptySampler();

  @override
  Stream<SamplerState> mapEventToState(SamplerEvent event) async* {
    if (event is LoadSampler) {
      yield* mapLoadSampler(event);
    } else if (event is UpdateSampler) {
      yield* mapUpdateSampler(event);
    } else if (event is ResetSampler) {
      yield EmptySampler();
    }
  }

  Stream<SamplerState> mapLoadSampler(LoadSampler event) async* {
    yield LoadingSampler();
    yield LoadedSampler(samplerAssessment: event.samplerAssessment);
  }

  Stream<SamplerState> mapUpdateSampler(UpdateSampler event) async* {
    yield LoadingSampler();
    yield LoadedSampler(samplerAssessment: event.samplerAssessment);
  }
}
