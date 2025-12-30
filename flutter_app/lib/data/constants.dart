import 'package:flutter/material.dart';

class KConstants {
  static const String themeModeKey = 'theme_mode';
}

class KTextStyle {
  static const TextStyle normalTealText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 1, 120, 7),
    wordSpacing: 3.0,
  );

  static const TextStyle descriptionText = TextStyle(
    fontSize: 16,
    color: Color.fromARGB(255, 7, 86, 30),
    letterSpacing: 1.2,
  );
}

class KValue {
  static const String welcomeText = 'Welcome to the Home Page!';
  static const String cleanUI = 'Clean UI';
  static const String fixBug = 'Fix Bug';
  static const String descriptionText =
      'This is an amazing Flutter application.';
}
