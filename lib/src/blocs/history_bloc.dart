import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/history.dart';
import 'package:phcapp/src/models/phc.dart';

abstract class HistoryEvent extends Equatable {
  HistoryEvent();
}

class LoadHistory extends HistoryEvent {
  LoadHistory();

  @override
  List<Object> get props => [];
}

class AddHistory extends HistoryEvent {
  final Callcard callcard;
  AddHistory({this.callcard});
}

class RemoveHistory extends HistoryEvent {
  int index;
  RemoveHistory({this.index});
}

class RemoveAllHistory extends HistoryEvent {
  RemoveAllHistory();
}

abstract class HistoryState extends Equatable {
  final List<History> listHistory;

  HistoryState({this.listHistory});

  @override
  List<Object> get props => [listHistory];
}

class HistoryEmpty extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<History> listHistory;

  HistoryLoaded({this.listHistory});

  @override
  List<Object> get props => [listHistory];
}

class HistoryAdded extends HistoryState {}

class HistoryRemoved extends HistoryState {}

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final PhcDao phcDao;
  HistoryBloc({this.phcDao});

  @override
  // TODO: implement initialState
  HistoryState get initialState => HistoryEmpty();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is LoadHistory) {
      //read from sembast store - History
      yield* reloadHistoryToState();

      // yield HistoryLoaded(listCallcards: new List<Callcard>());
    } else if (event is AddHistory) {
      yield* mapAddHistoryToState(event);
    } else if (event is RemoveHistory) {
      yield HistoryLoaded();
    } else if (event is RemoveAllHistory) {
      final removeAll = await phcDao.clearAllSuccessHistory();

      yield HistoryLoaded(listHistory: removeAll);
      // yield* reloadHistoryToState();
      // print(removeAll);

      // yield HistoryLoaded(listHistory: []);
      // yield* reloadHistoryToState();
    }
  }

  Stream<HistoryState> mapAddHistoryToState(AddHistory event) async* {
    // print("mapAddHistoryToState");
    int statusSend = 1;
    final insert = await phcDao.insertHistory(event.callcard, statusSend);

    yield* reloadHistoryToState();
  }

  Stream<HistoryState> reloadHistoryToState() async* {
    final showAll = await phcDao.showAllHistory();
    // debugPrint()
    // print(showAll);
    // print("IM HERE RELOAD HISTORY");
    yield HistoryLoaded(listHistory: showAll);
  }
}
