part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignUpRequested(this.username, this.email, this.password);
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}
