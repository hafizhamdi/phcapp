import 'dart:async';

import 'package:flutter/material.dart';

class PatInfoProvider extends ChangeNotifier {
  TextEditingController nameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  String idType = "";
  String gender = "";

  StreamController<String> genderController = new StreamController.broadcast();
  StreamController<String> idTypeController = new StreamController.broadcast();

  String get getName => nameController.text;
  set setName(value) => nameController.text = value;

  String get getId => idController.text;
  set setId(value) => idController.text = value;

  String get getDob => dobController.text;
  set setDob(value) => dobController.text = value;

  String get getAge => ageController.text;
  set setAge(value) => ageController.text = value;

  String get getGender => gender;
  set setGender(value) => gender = value;

  String get getIdtype => idType;
  set setIdType(value) => idType = value;
}
