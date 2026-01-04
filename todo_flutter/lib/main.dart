import 'package:flutter/material.dart';
import 'package:todo_flutter/pages/first_page.dart';
import 'package:todo_flutter/pages/home_page.dart';
import 'package:todo_flutter/pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void userTapped() {
    print('funtion tapped');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FirstPage(),
      routes: {
        '/first': (context) => FirstPage(),
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
