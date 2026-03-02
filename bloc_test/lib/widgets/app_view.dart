import 'package:bloc_test/cubit/auth_cubit.dart';
import 'package:bloc_test/cubit/auth_state.dart';
import 'package:bloc_test/pages/home_page.dart';
import 'package:bloc_test/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return HomePage(email: state.email);
        }
        return LoginPage();
      },
    );
  }
}
