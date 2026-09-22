import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:podtestriver/main.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (context, ref, child) {
          final name = ref.watch(nameProvider);
          return Column(children: [Center(child: Text(name))]);
        },
      ),
    );
  }
}
