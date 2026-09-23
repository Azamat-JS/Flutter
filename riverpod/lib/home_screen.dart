import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podtestriver/main.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  void onSubmitName(WidgetRef ref, String value) {
    ref.read(userProvider.notifier).updateName(value);
  }

  void onSubmitAge(WidgetRef ref, String value) {
    ref.read(userProvider.notifier).updateAge(int.parse(value));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    /// watching whole User class
    // final user = ref.watch(userProvider.select((value) => value.name));  /// watching only one property of User class which is name;
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Column(
        children: [
          TextField(onSubmitted: (value) => onSubmitName(ref, value)),
          TextField(onSubmitted: (value) => onSubmitAge(ref, value)),
          Center(child: Text(user.age.toString())),
        ],
      ),
    );
  }
}
