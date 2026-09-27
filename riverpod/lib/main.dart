import 'package:flutter/material.dart';
import 'package:podtestriver/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podtestriver/logger_riverpod.dart';
import 'package:podtestriver/user.dart';

final fetchUserProvider = FutureProvider.family.autoDispose((
  ref,
  String input,
) {
  ref.onDispose(() {});
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.fetchUserData(input);
});

final streamProvider = StreamProvider((ref) async* {
  yield [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
});

void main() {
  runApp(ProviderScope(observers: [LoggerRiverpod()], child: const MyApp()));
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
