import 'package:flutter/material.dart';
import 'package:theme_flutter/components/box.dart';
import 'package:theme_flutter/components/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: Center(
        child: MyBox(
          color: Colors.blue[300],
          child: MyButton(color: Colors.blue[200], onTap: () {}),
        ),
      ),
    );
  }
}
