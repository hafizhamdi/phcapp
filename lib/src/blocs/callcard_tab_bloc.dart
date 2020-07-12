import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phcapp/src/blocs/blocs.dart';
import 'package:phcapp/src/database/phc_dao.dart';
import 'package:phcapp/src/models/phc.dart';
import 'package:phcapp/src/repositories/repositories.dart';

class CallCardTabBloc extends Bloc<TabEvent, TabState> {
  final PhcDao phcDao;
  final PhcRepository phcRepository;
  final HistoryBloc historyBloc;

  CallCardTabBloc({this.phcDao, this.phcRepository, this.historyBloc});

  @override
  TabState get initialState => CallcardToPublishEmpty();

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is PublishCallcard) {
      // yield CallcardToPublishSuccess();
      // yield CallcardToPublishEmpty();

      yield* publishCallcardToState(event);
    } else if (event is RepublishCallcard) {
      yield* republishCallcardToState(event);
    }
  }

  Stream<TabState> republishCallcardToState(RepublishCallcard event) async* {
    yield CallcardToPublishLoading();
    Callcard callcard = new Callcard(
      authorizedUser: event.authorizedUser,
        callInformation: event.callInformation,
        responseTeam: event.responseTeam,
        responseTime: event.responseTime,
        patients: List<Patient>.from(event.patients).toList(),
        sceneAssessment: event.sceneAssessment);

    try {
      //publish to api
      final response = await phcRepository.sendingCallcard(callcard);
      print("FINISH AWAIT DAHH");

      if (response != null) {
        print("response sending calcard not null");
        // final insert = await phcDao.insertHistory(callcard, status_send);
        // print(insert);

        try {
          int status_send = 1;
          final insert = await phcDao.insertHistory(callcard, status_send);
          // historyBloc.add(LoadHistory());
          // yield CallcardToPublishSuccess();
        } catch (_) {
          // int status_send = 0;
          // final insert = await phcDao.insertHistory(callcard, status_send);
          yield CallcardToSavingError();
        }

        // historyBloc.add(AddHistory(callcard: callcard));

        // publish success
        // historyBloc.add(LoadHistory());
        // yield CallcardToPublishSuccess();
        // yield CallcardToPublishEmpty();
        // yield CallcardToPublishSuccess();
      }
      yield CallcardToPublishSuccess();

      // await Future.delayed(Duration(seconds: 2));
    } catch (_) {
      //publish failed
      print('publish failed something wrong');
      int status_send = 0;

      try {
        final insert = await phcDao.insertHistory(callcard, status_send);
        // historyBloc.add(LoadHistory());
      } catch (_) {
        yield CallcardToSavingError();
      }
      // final update = await phcDao.updateHistory(callcard, status_send);
      // yield CallcardToPublishFailed();
      // yield CallcardToPublishEmpty();
    }
  }

  Stream<TabState> publishCallcardToState(PublishCallcard event) async* {
    yield CallcardToPublishLoading();
    Callcard callcard = new Callcard(
      authorizedUser: event.authorizedUser,
        callInformation: event.callInformation,
        responseTeam: event.responseTeam,
        responseTime: event.responseTime,
        patients: List<Patient>.from(event.patients).toList(),
        sceneAssessment: event.sceneAssessment);

    // Callcard callcard = new Callcard(
    //   callInformation: event.callInformation,
    //   responseTeam: event.responseTeam,
    //   responseTime: event.responseTime,
    //   patients: event.patients,
    //   // sceneAssessment: event.sceneAssessment
    // );

    // print(callcard.toJson());
    try {
      //publish to api
      print("ready to publish to sending callcard");
      final response = await phcRepository.sendingCallcard(callcard);
      print("FINISH AWAIT DAHH");

      if (response != null) {
        print("response sending calcard not null");
        int status_send = 1;
        // final insert = await phcDao.insertHistory(callcard, status_send);
        // print(insert);
        try {
          final insert = await phcDao.insertHistory(callcard, status_send);
          // historyBloc.add(LoadHistory());
          print("insert history success");
          // yield CallcardToPublishSuccess();
        } catch (_) {
          yield CallcardToSavingError();
        }

        // historyBloc.add(AddHistory(callcard: callcard));

        // publish success
        yield CallcardToPublishSuccess();
        // yield CallcardToPublishEmpty();
        // yield CallcardToPublishSuccess();
      }

      // await Future.delayed(Duration(seconds: 2));
    } catch (_) {
      //publish failed
      print('publish failed something wrong');
      int status_send = 0;
      try {
        final insert = await phcDao.insertHistory(callcard, status_send);
      } catch (_) {
        yield CallcardToSavingError();
      }
      // final update = await phcDao.updateHistory(callcard, status_send);
      yield CallcardToPublishFailed();
      // yield CallcardToPublishEmpty();
    }
  }
}

abstract class TabState extends Equatable {
  TabState();
}

abstract class TabEvent {
  TabEvent();
}

class PublishCallcard extends TabEvent {
  final authorizedUser;
  final CallInformation callInformation;
  final ResponseTeam responseTeam;
  final ResponseTime responseTime;
  final SceneAssessment sceneAssessment;
  final List<Patient> patients;
  PublishCallcard(
      {
        this.authorizedUser,
        this.callInformation,
      this.responseTeam,
      this.responseTime,
      this.sceneAssessment,
      this.patients});

  @override
  List<Object> get props =>
      [authorizedUser, callInformation, responseTeam, responseTime, sceneAssessment, patients];
}

class RepublishCallcard extends TabEvent {
  final authorizedUser;
  final CallInformation callInformation;
  final ResponseTeam responseTeam;
  final ResponseTime responseTime;
  final SceneAssessment sceneAssessment;
  final List<Patient> patients;
  RepublishCallcard(
      {
        this.authorizedUser,
        this.callInformation,
      this.responseTeam,
      this.responseTime,
      this.sceneAssessment,
      this.patients});

  @override
  List<Object> get props =>
      [authorizedUser,callInformation, responseTeam, responseTime, sceneAssessment, patients];
}

class CallcardToPublishEmpty extends TabState {}

class CallcardToSavingError extends TabState {}

class CallcardToPublishSuccess extends TabState {
  CallcardToPublishSuccess();
  @override
  List<Object> get props => [];
}

class CallcardToPublishFailed extends TabState {}

class CallcardToPublishLoading extends TabState {}
