import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({this.isLightTheme});

  ThemeData get getThemeData => isLightTheme ? lightTheme : darkTheme;

  set setThemeData(bool val) {
    if (val) {
      isLightTheme = true;
    } else {
      isLightTheme = false;
    }
    notifyListeners();
  }
}

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.purple,
  brightness: Brightness.dark,
  backgroundColor: Color(0xFF000000),
  accentColor: Colors.pinkAccent,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.black54,
);
// cardColor: Colors.purple[500]);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.purple,
  brightness: Brightness.light,
  backgroundColor: Colors.purple, //Color(0xFFE5E5E5),
  accentColor: Colors.pink,

  // cardColor: Colors.purple[200],
  accentIconTheme: IconThemeData(color: Colors.white),
  // accentIconTheme: IconThemeData(color: Colors.red),
  // unselectedWidgetColor: Colors.red,i
  dividerColor: Colors.white54,
  // indicatorColor: Colors.pink[200],
  // unselectedWidgetColor: Color(0xbc477b)
);
