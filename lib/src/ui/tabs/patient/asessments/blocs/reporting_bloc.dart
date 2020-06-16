import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class ReportingEvent extends Equatable {
  IncidentReporting incidentReporting;
  ReportingEvent({this.incidentReporting});

  @override
  List get props => [incidentReporting];
}

abstract class ReportingState extends Equatable {
  IncidentReporting incidentReporting;
  ReportingState({this.incidentReporting});

  @override
  List get props => [incidentReporting];
}

class LoadReporting extends ReportingEvent {
  IncidentReporting incidentReporting;
  LoadReporting({this.incidentReporting});

  @override
  List get props => [incidentReporting];
}

class ResetReporting extends ReportingEvent {}

class LoadedReporting extends ReportingState {
  IncidentReporting incidentReporting;
  LoadedReporting({this.incidentReporting});

  @override
  List get props => [incidentReporting];
}

class EmptyReporting extends ReportingState {}

class ReportingBloc extends Bloc<ReportingEvent, ReportingState> {
  @override
  ReportingState get initialState => EmptyReporting();

  @override
  Stream<ReportingState> mapEventToState(ReportingEvent event) async* {
    if (event is LoadReporting) {
      yield* mapLoadReportingToState(event);
    } else if (event is ResetReporting) {
      yield EmptyReporting();
    }
  }

  Stream<ReportingState> mapLoadReportingToState(LoadReporting event) async* {
    yield LoadedReporting(incidentReporting: event.incidentReporting);
  }
}
