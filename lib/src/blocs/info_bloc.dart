import 'dart:async';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/info_model.dart';

class InfoBloc {
  final _repository = Repository();
  StreamController<String> _callcard_no = new StreamController<String>();
  StreamController<String> _call_received = new StreamController<String>();
  StreamController<String> _contact_no = new StreamController<String>();
  StreamController<String> _event_code = new StreamController<String>();
  StreamController<String> _priority = new StreamController<String>();
  StreamController<String> _incident_desc = new StreamController<String>();
  StreamController<String> _incident_loc = new StreamController<String>();
  StreamController<String> _landmark = new StreamController<String>();
  StreamController<String> _location_type = new StreamController<String>();
  StreamController<String> _distance_to_scene = new StreamController<String>();
  StreamController<String> _plate_no = new StreamController<String>();
  StreamController<String> _assign_id = new StreamController<String>();



  Stream<String> get callNoStream => _callcard_no.stream;
  Stream<String> get contactNoStream => _callcard_no.stream;
  Stream<String> get eventCodeStream => _callcard_no.stream;
  Stream<String> get priorityStream => _callcard_no.stream;
  Stream<String> get incDescStream => _callcard_no.stream;
  Stream<String> get incLocStream => _callcard_no.stream;
  Stream<String> get landmarkStream => _callcard_no.stream;
  Stream<String> get locTypeStream => _callcard_no.stream;
  Stream<String> get distSceneStream => _callcard_no.stream;

  updateCallcardNo(String text) => _callcard_no.sink.add(text);
  updateCallReceived(String text) => _call_received.sink.add(text);
  updateContactNo(String text) => _contact_no.sink.add(text);
  updateEventCode(String text) => _event_code.sink.add(text);
  updatePriority(String text) => _priority.sink.add(text);
  updateIncidentDesc(String text) => _incident_desc.sink.add(text);
  updateIncidentLoc(String text) => _incident_loc.sink.add(text);
  updateLandmark(String text) => _landmark.sink.add(text);
  updateLocationType(String text) => _location_type.sink.add(text);
  updateDistanceScene(String text) => _distance_to_scene.sink.add(text);

  addCallInfo() {
    InfoModel data = new InfoModel(
      callcard_no: _callcard_no.toString(),
      // call_received: DateTime.parse(_call_received.value),
      caller_contactno: _contact_no.toString(),
      event_code: _event_code.toString(),
      priority: _priority.toString(),
      incident_desc: _incident_desc.toString(),
      incident_location: _incident_loc.toString(),
      landmark: _landmark.toString(),
      location_type: _location_type.toString(),
      distance_toscene: _distance_to_scene.toString(),
      plate_no: _plate_no.toString(),
      assign_id: _assign_id.toString(),
    );
    // InfoModel info = InfoModel()
    _repository.addCallInfo(data);
  }
  // uploadCallInfo(){
  //   _repository
  // }

  // final _phcFetcher = PublishSubject<PhcModel>();
  // final _updateInfo = PublishSubject<InfoModel>();

  // Observable<PhcModel> get allCallcards => _phcFetcher.stream;

  // fetchAllCallcards() async {
  //   PhcModel phcModel = await _repository.fetchAllCallcards();
  //   _phcFetcher.sink.add(phcModel);

  // }

  dispose() {
    // _repository.close;
    _callcard_no.close();
    _call_received.close();
    _contact_no.close();
    _event_code.close();
    _priority.close();
    _incident_desc.close();
    _incident_loc.close();
    _landmark.close();
    _location_type.close();
    _distance_to_scene.close();
  }
  // _phcFetcher.close();}
}

final bloc = InfoBloc();
