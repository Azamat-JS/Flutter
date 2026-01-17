import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeData = ThemeMode.light;

  ThemeMode get themeData => _themeData;

  set themeData(ThemeMode themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == ThemeMode.light) {
      themeData = ThemeMode.dark;
    } else {
      themeData = ThemeMode.light;
    }
  }
}
