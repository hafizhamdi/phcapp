import 'package:phcapp/src/database/phc_dao.dart';
import 'package:meta/meta.dart';

class PhcDaoClient {
  PhcDao phcDao;
  PhcDaoClient({@required this.phcDao}) : assert(phcDao != null);

  PhcDao get phcDaoInstance => phcDao;
}

// final phcDao = PhcDaoClient();
