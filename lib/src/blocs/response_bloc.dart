import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ResponseEvent extends Equatable {
  final vehicleRegNo;
  final serviceResponse;

  ResponseEvent({this.vehicleRegNo, this.serviceResponse});

  @override
  List get props => [vehicleRegNo, serviceResponse];
}

abstract class ResponseState extends Equatable {
  final vehicleRegNo;
  final serviceResponse;

  ResponseState({this.vehicleRegNo, this.serviceResponse});

  @override
  List get props => [vehicleRegNo, serviceResponse];
}

class ResetResponse extends ResponseEvent {}

class AddResponse extends ResponseEvent {
  final vehicleRegNo;
  final serviceResponse;

  AddResponse({this.vehicleRegNo, this.serviceResponse});

  @override
  List get props => [vehicleRegNo, serviceResponse];
}

class LoadedResponse extends ResponseState {
  final vehicleRegNo;
  final serviceResponse;

  LoadedResponse({this.vehicleRegNo, this.serviceResponse});

  @override
  List get props => [vehicleRegNo, serviceResponse];
}

class EmptyResponse extends ResponseState {}

class ResponseBloc extends Bloc<ResponseEvent, ResponseState> {
  @override
  ResponseState get initialState => EmptyResponse();

  @override
  Stream<ResponseState> mapEventToState(ResponseEvent event) async* {
    if (event is AddResponse) {
      yield* mapAddResponseToState(event);
    } else if (event is ResetResponse) {
      yield* mapResetResponseToState(event);
    }
  }

  Stream<ResponseState> mapAddResponseToState(AddResponse event) async* {
    final _vehicleRegno = event.vehicleRegNo;
    final _serviceResponse = event.serviceResponse;

    yield LoadedResponse(
        serviceResponse: _serviceResponse, vehicleRegNo: _vehicleRegno);
  }

  Stream<ResponseState> mapResetResponseToState(ResetResponse event) async* {
    yield EmptyResponse();
  }
}
