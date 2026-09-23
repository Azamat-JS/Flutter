import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podtestriver/main.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final user = ref.watch(userProvider);  /// watching whole User class
    ///////////---------------
    ///
    // final user = ref.watch(userProvider.select((value) => value.name));  /// watching only one property of User class which is name;

    final user = ref.watch(fetchUserProvider);

    return user.when(
      data: (data) {
        return Scaffold(
          appBar: AppBar(title: Text("")),
          body: Column(children: [Center(child: Text(""))]),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return Center(child: CircularProgressIndicator.adaptive());
      },
    );

    /// For Future Provider
  }
}
