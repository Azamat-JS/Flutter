import 'package:bloc_test/cubit/auth_cubit.dart';
import 'package:bloc_test/cubit/auth_state.dart';
import 'package:bloc_test/cubit/counter_cubit.dart';
import 'package:bloc_test/pages/home_page.dart';
import 'package:bloc_test/pages/login_page.dart';
import 'package:bloc_test/widgets/app_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterCubit>(create: (context) => CounterCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: AppView(),
      ),
    );
  }
}
