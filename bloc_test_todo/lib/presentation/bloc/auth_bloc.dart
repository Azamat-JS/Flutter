import 'package:bloc_test_todo/domain/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import "package:flutter/foundation.dart";

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      final loggedIn = await repository.isLoggedIn();
      if (loggedIn) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnAuthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await repository.signUp(event.username, event.email, event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await repository.login(event.email, event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await repository.logout();
      emit(AuthUnAuthenticated());
    });
  }
}
