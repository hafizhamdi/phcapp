import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:phcapp/src/repositories/phc_repository.dart';

abstract class PhcEvent extends Equatable {
  PhcEvent();
}

class FetchPhc extends PhcEvent {
  @override
  List<Object> get props => [];
}

class RefreshPhc extends PhcEvent {
  @override
  List<Object> get props => [];
}

// Understood this load from database sembast
class LoadPhc extends PhcEvent {
  @override
  List<Object> get props => [];
}

class AddPhc extends PhcEvent {
  final Phc phc;

  AddPhc({@required this.phc}) : assert(phc != null);

  @override
  List<Object> get props => [phc];
}

class UpdatePhc extends PhcEvent {
  final Phc phc;

  UpdatePhc({@required this.phc}) : assert(phc != null);

  @override
  List<Object> get props => [phc];
}

class PostPhc extends PhcEvent {
  final Callcard callcard;

  PostPhc({@required this.callcard}) : assert(callcard != null);

  @override
  List<Object> get props => [callcard];
}

abstract class PhcState extends Equatable {
  final Phc phc;

  PhcState({this.phc}); //: assert(phc != null);

  @override
  List<Object> get props => [phc];
  // PhcState();

  // @override
  // List<Object> get props => [];
}

class PhcEmpty extends PhcState {}

class PhcFetching extends PhcState {}

class PhcPostingError extends PhcState {}

class PhcLoading extends PhcState {}

class PhcLoadingError extends PhcState {}

class PhcFetchingError extends PhcState {}

class PhcFetched extends PhcState {
  final Phc phc;

  PhcFetched({@required this.phc}) : assert(phc != null);

  @override
  List<Object> get props => [phc];
}

class PhcLoaded extends PhcState {
  final Phc phc;

  PhcLoaded({@required this.phc}) : assert(phc != null);

  @override
  List<Object> get props => [phc];
}

class PhcPosted extends PhcState {
  final Callcard callcard;

  PhcPosted({@required this.callcard}) : assert(callcard != null);

  @override
  List<Object> get props => [callcard];
}

class PhcBloc extends Bloc<PhcEvent, PhcState> {
  final PhcRepository phcRepository;
  PhcDao phcDao; // = new PhcDao();

  PhcBloc({@required this.phcRepository, this.phcDao})
      : assert(phcRepository != null);

  @override
  PhcState get initialState => PhcEmpty();

  @override
  Stream<PhcState> mapEventToState(PhcEvent event) async* {
    if (event is FetchPhc) {
      yield* _mapFetchPhcToState(event);
    } else if (event is RefreshPhc) {
      yield* _mapRefreshPhcToState(event);
    } else if (event is LoadPhc) {
      yield* _reloadPhc();
    } else if (event is AddPhc) {
      final key = await phcDao.insert(event.phc);
      phcDao.setKey(key);
      print("AddPhc ");
      print(event.phc.toJson());
      yield* _reloadPhc();
    } else if (event is UpdatePhc) {
      await phcDao.update(event.phc);
      yield* _reloadPhc();
    } else if (event is PostPhc) {
      yield* _mapPostPhcToState(event);
    }
  }

  Stream<PhcState> _mapFetchPhcToState(FetchPhc event) async* {
    // yield PhcFetching();
    yield PhcLoading();
    // try {

    // print("phc fetching");
    // print(phcInsert);
    try {
      final phc = await phcRepository.getPhc();
      print("INSIDE TRY PHC");
      final phcInsert = await phcDao.insert(Phc.fromJson(phc));
      // print(jsonEncode(phc));
      final phcData = Phc.fromJson(phc);

      // yield PhcFetched(phc: phcData);
      yield PhcLoaded(phc: phcData);
      // } catch (error) {
      //   print("---catch error----");
      //   print(error);
      // }

      // print(phc);
      // yield* _reloadPhc();
    } catch (error) {
      print(error);
      yield PhcFetchingError();

      yield* _reloadPhc();
    }
  }

  Stream<PhcState> _mapRefreshPhcToState(RefreshPhc event) async* {
    // yield PhcFetching();
    yield PhcLoading();
    // try {

    print("phc refresh");
    // print(phcInsert);

    // print(phc);
    // yield* _reloadPhc();
    try {
      final phc = await phcRepository.getPhc();
      //   final Phc phc = await phcRepository.getPhc();
      final phcInsert = await phcDao.insert(Phc.fromJson(phc));

      final phcData = Phc.fromJson(phc);

      print("refersh");
      yield PhcLoaded(phc: phcData);
      //   print(phc);
      //   yield PhcFetched(phc: phc);
    } catch (error) {
      print(error);

      yield PhcFetchingError();
      //   // yield state;
      yield* _reloadPhc();
    }
  }

  Stream<PhcState> _reloadPhc() async* {
    // yield PhcLoading();
    print("before phc reload");
    final phc = await phcDao.getAllPhc();
    print("reloadPhc");
    print(phc);
    if (phc != null) {
      yield PhcLoaded(phc: phc);
    } else {
      yield PhcLoadingError();
    }
  }

  Stream<PhcState> _mapPostPhcToState(PostPhc event) async* {
    try {
      final Callcard card = await phcRepository.sendingCallcard(event.callcard);
      // final Phc phc = await phcRepository.getPhc();
      // print("refersh");
      print(card);
      yield PhcPosted(callcard: card);
    } catch (_) {
      yield PhcPostingError();
      // yield state;
      // yield* _reloadPhc();
    }
  }
}
