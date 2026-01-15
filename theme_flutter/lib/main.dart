import 'package:flutter/material.dart';
import 'package:theme_flutter/pages/home_page.dart';
import 'package:theme_flutter/theme/them.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,
    );
  }
}
