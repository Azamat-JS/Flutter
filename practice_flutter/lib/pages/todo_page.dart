import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController myController = TextEditingController();
  String userText = "";

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void greetUser() {
    String username = myController.text;
    setState(() {
      userText = 'Salom, $username!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(userText),
              SizedBox(height: 20),
              TextField(
                controller: myController,
                decoration: InputDecoration(hintText: 'Enter your name..'),
              ),
              ElevatedButton(onPressed: greetUser, child: Text('Greet User')),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
