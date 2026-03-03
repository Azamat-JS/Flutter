import 'package:bloc_test/cubit/auth_cubit.dart';
import 'package:bloc_test/cubit/auth_state.dart';
import 'package:bloc_test/pages/count_page.dart';
import 'package:bloc_test/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterCubit>().state;
    final authState = context.watch<AuthCubit>().state;
    String email = '';
    if (authState is AuthAuthenticated) {
      email = authState.email;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: () {
                context.read<AuthCubit>().logout();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, $email!'),
            SizedBox(height: 30),
            Text('Counter value'),
            Text(
              '$counter',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                  },

                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                  ),
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CountPage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.grey[300]),
              ),
              child: Icon(Icons.arrow_right, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
