import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallInfoProvider extends ChangeNotifier{


  TextEditingController receivedController = TextEditingController(
      text: DateFormat("dd/MM/yyyy HH:mm").format(DateTime.now()));
  TextEditingController cardNoController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController eventCodeController = TextEditingController();
  TextEditingController incidentController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();


}