import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podtestriver/main.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String userNo = "2";
  @override
  Widget build(BuildContext context) {
    return ref
        .watch(fetchUserProvider)
        .when(
          data: (data) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  TextField(
                    onSubmitted: (value) => setState(() {
                      userNo = value;
                    }),
                  ),
                  Center(child: Text(data.name)),
                ],
              ),
            );
          },
          error: (error, stackTrace) {
            return Scaffold(body: Center(child: Text(error.toString())));
          },
          loading: () {
            return Scaffold(
              body: Center(child: CircularProgressIndicator.adaptive()),
            );
          },
        );
  }
}
