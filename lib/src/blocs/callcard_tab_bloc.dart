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
    Callcard callcard = new Callcard(
      callInformation: event.callInformation,
      responseTeam: event.responseTeam,
      responseTime: event.responseTime,
      patients: event.patients,
      // sceneAssessment: event.sceneAssessment
    );

    try {
      //publish to api
      final response = await phcRepository.sendingCallcard(callcard);
      print("FINISH AWAIT DAHH");

      if (response != null) {
        print("response sending calcard not null");
        int status_send = 1;
        final insert = await phcDao.insertHistory(callcard, status_send);
        print(insert);

        // historyBloc.add(AddHistory(callcard: callcard));

        // publish success
        historyBloc.add(LoadHistory());
        // yield CallcardToPublishSuccess();
        // yield CallcardToPublishEmpty();
        // yield CallcardToPublishSuccess();
      }

      // await Future.delayed(Duration(seconds: 2));
    } catch (_) {
      //publish failed
      print('publish failed something wrong');
      int status_send = 0;
      final insert = await phcDao.insertHistory(callcard, status_send);

      historyBloc.add(LoadHistory());
      // final update = await phcDao.updateHistory(callcard, status_send);
      // yield CallcardToPublishFailed();
      // yield CallcardToPublishEmpty();
    }
  }

  Stream<TabState> publishCallcardToState(PublishCallcard event) async* {
    Callcard callcard = new Callcard(
      callInformation: event.callInformation,
      responseTeam: event.responseTeam,
      responseTime: event.responseTime,
      patients: event.patients,
      // sceneAssessment: event.sceneAssessment
    );

    try {
      //publish to api
      final response = await phcRepository.sendingCallcard(callcard);
      print("FINISH AWAIT DAHH");

      if (response != null) {
        print("response sending calcard not null");
        int status_send = 1;
        final insert = await phcDao.insertHistory(callcard, status_send);
        print(insert);

        // historyBloc.add(AddHistory(callcard: callcard));

        // publish success
        yield CallcardToPublishSuccess();
        yield CallcardToPublishEmpty();
        // yield CallcardToPublishSuccess();
      }

      // await Future.delayed(Duration(seconds: 2));
    } catch (_) {
      //publish failed
      print('publish failed something wrong');
      int status_send = 0;
      final insert = await phcDao.insertHistory(callcard, status_send);

      // final update = await phcDao.updateHistory(callcard, status_send);
      yield CallcardToPublishFailed();
      yield CallcardToPublishEmpty();
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
  final CallInformation callInformation;
  final ResponseTeam responseTeam;
  final ResponseTime responseTime;
  final SceneAssessment sceneAssessment;
  final List<Patient> patients;
  PublishCallcard(
      {this.callInformation,
      this.responseTeam,
      this.responseTime,
      this.sceneAssessment,
      this.patients});

  @override
  List<Object> get props =>
      [callInformation, responseTeam, responseTime, sceneAssessment, patients];
}

class RepublishCallcard extends TabEvent {
  final CallInformation callInformation;
  final ResponseTeam responseTeam;
  final ResponseTime responseTime;
  final SceneAssessment sceneAssessment;
  final List<Patient> patients;
  RepublishCallcard(
      {this.callInformation,
      this.responseTeam,
      this.responseTime,
      this.sceneAssessment,
      this.patients});

  @override
  List<Object> get props =>
      [callInformation, responseTeam, responseTime, sceneAssessment, patients];
}

class CallcardToPublishEmpty extends TabState {}

class CallcardToPublishSuccess extends TabState {
  CallcardToPublishSuccess();
  @override
  List<Object> get props => [];
}

class CallcardToPublishFailed extends TabState {}

class CallcardToPublishLoading extends TabState {}
