import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final email = event.email;
        final password = event.password;

        if (password.length < 6) {
          return emit(
            AuthFailure('Password must be at least 6 characters long.'),
          );
        }
        await Future.delayed(const Duration(seconds: 2));
        return emit(AuthSuccess(uid: '$email-$password'));
      } catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    });

    on<AuthLogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        return emit(AuthInitial());
      } catch (e) {
        return emit(AuthFailure(e.toString()));
      }
    });
  }
}
