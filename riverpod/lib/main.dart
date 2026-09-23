import 'package:flutter/material.dart';
import 'package:podtestriver/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nameProvider = StateProvider<String?>((ref) => null);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod tutorial',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}
