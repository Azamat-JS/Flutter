import 'package:flutter/material.dart';
import 'package:flutter_app/views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

// MaterialApp (Stateful)
// Scaffold
// App title
// Bottom Navigation setState()
// Selected index

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: WidgetTree(),
    );
  }
}
