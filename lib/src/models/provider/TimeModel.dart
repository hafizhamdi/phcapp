import 'package:flutter/cupertino.dart';

enum TimeClass { dispatch, enroute }

class TimeModel extends ChangeNotifier {
  DateTime dispatchTime;

  void changeTime(TimeClass type, DateTime paramTime) {
    if (type == TimeClass.dispatch) {
      dispatchTime = paramTime;

      notifyListeners();
    }
  }
}
