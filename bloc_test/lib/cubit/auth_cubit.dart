import 'package:bloc_test/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (email == 'test@gmail.com' && password == '123456') {
        emit(AuthAuthenticated(email));
      } else {
        emit(AuthError('Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (email.isNotEmpty && password.isNotEmpty) {
        emit(AuthAuthenticated(email));
      } else {
        emit(AuthError('Email and password cannot be empty'));
      }
    } catch (e) {
      emit(AuthError('An unexpected error occurred'));
    }
  }

  void logout() {
    emit(AuthUnauthenticated());
  }
}
