import 'package:bloc_test_todo/data/datasources/auth_local_datasource.dart';
import 'package:bloc_test_todo/domain/repositories/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource local;

  AuthRepositoryImpl(this.local);

  @override
  Future<void> signUp(String username, String email, String password) async {
    await local.signUp(username: username, email: email, password: password);
  }

  @override
  Future<void> login(String email, String password) async {
    await local.login(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await local.logout();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await local.isLoggedIn();
  }
}
