import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import '../models/phc_model.dart';

class PhcBloc {
  final _repository = Repository();
  final _phcFetcher = PublishSubject<PhcModel>();
  // final _updateInfo = PublishSubject<InfoModel>();
  


  Observable<PhcModel> get allCallcards => _phcFetcher.stream;

  fetchAllCallcards() async {
    PhcModel phcModel = await _repository.fetchAllCallcards();
    _phcFetcher.sink.add(phcModel);

  }

  dispose(){
    _phcFetcher.close();
  }

}

final bloc = PhcBloc();