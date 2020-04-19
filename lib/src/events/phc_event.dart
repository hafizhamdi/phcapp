import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import '../models/phc.dart';

@immutable
abstract class PhcEvent extends Equatable {
  PhcEvent([List props = const []]) : super(props);
}

class FetchPhcEvent extends PhcEvent {
  final Phc phc;

  FetchPhcEvent(this.phc) : super([phc]);
}

class LoadPhcEvent extends PhcEvent {
  final Phc phc;

  LoadPhcEvent(this.phc) : super([phc]);
}

class UpdatePhcEvent extends PhcEvent {
  final Phc updatedPhc;

  UpdatePhcEvent(this.updatedPhc) : super([updatedPhc]);
}

@immutable
abstract class PhcState extends Equatable {
  PhcState([List props = const []]) : super(props);
}

class PhcStateFetched extends PhcState {
  final Phc phcData;
  PhcStateFetched(this.phcData) : super([phcData]);

  @override
  String toString() => "PhcStateFetched";
}

class PhcStateFetching extends PhcState {
  // final Phc phcData;
  // PhcStateFetching(this.phcData) : super([phcData]);

  @override
  String toString() => "PhcStateFetching";
}

class PhcStateLoading extends PhcState {
  // final Phc phcData;
  // PhcStateLoading(this.phcData) : super([phcData]);

  @override
  String toString() => "PhcStateLoading";
}

class PhcStateLoaded extends PhcState {
  final Phc phcData;
  PhcStateLoaded(this.phcData) : super([phcData]);

  @override
  String toString() => "PhcStateLoaded";
}
