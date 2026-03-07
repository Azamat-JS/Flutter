import 'package:bloc_test_todo/presentation/bloc/auth_bloc.dart';
import 'package:bloc_test_todo/presentation/pages/home_page.dart';
import 'package:bloc_test_todo/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        if (state is AuthAuthenticated) {
          return const HomePage();
        }

        if (state is AuthFailure) {
          return const LoginPage();
        }

        if (state is AuthUnAuthenticated) {
          return const LoginPage();
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}
