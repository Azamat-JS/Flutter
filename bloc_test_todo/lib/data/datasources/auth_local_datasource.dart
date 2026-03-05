import 'package:bloc_test_todo/data/models/auth_model.dart';
import 'package:bloc_test_todo/data/models/session_model.dart';
import 'package:isar/isar.dart';

abstract interface class AuthLocalDatasource {
  Future<bool> isLoggedIn();

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<void> login({required String email, required String password});

  Future<void> logout();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final Isar isar;

  AuthLocalDatasourceImpl(this.isar);

  @override
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    final existing = await isar.userModels
        .filter()
        .emailEqualTo(email)
        .findFirst();

    if (existing != null) {
      throw Exception('User already exists');
    }
    final user = UserModel()
      ..username = username
      ..email = email
      ..password = password;

    await isar.writeTxn(() async {
      final userId = await isar.userModels.put(user);

      final session = SessionModel()
        ..id = 0
        ..userId = userId;

      await isar.sessionModels.put(session);
    });
  }

  @override
  Future<void> login({required String email, required String password}) async {
    final user = await isar.userModels
        .filter()
        .emailEqualTo(email)
        .passwordEqualTo(password)
        .findFirst();

    if (user == null) {
      throw Exception('Invalid credentials');
    }

    await _saveSession(user.id);
  }

  @override
  Future<void> logout() async {
    await _clearSession();
  }

  @override
  Future<bool> isLoggedIn() async {
    final session = await isar.sessionModels.get(0);
    return session?.userId != null;
  }

  Future<void> _saveSession(int userId) async {
    final session = SessionModel()
      ..id = 0
      ..userId = userId;

    await isar.writeTxn(() async {
      await isar.sessionModels.put(session);
    });
  }

  Future<void> _clearSession() async {
    await isar.writeTxn(() async {
      await isar.sessionModels.delete(0);
    });
  }
}
