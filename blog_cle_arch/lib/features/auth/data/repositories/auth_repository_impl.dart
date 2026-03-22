import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/core/network/connection_checker.dart';
import 'package:blog_cle_arch/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_cle_arch/core/common/entities/user_entity.dart';
import 'package:blog_cle_arch/features/auth/data/models/user_model.dart';
import 'package:blog_cle_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImpl(this.remoteDatasource, this.connectionChecker);

  @override
  Future<Either<Failure, UserEntity>> getCurrentUserData() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDatasource.userSession;
        if (session == null) {
          return left(Failure('User not logged in'));
        }
        return right(
          UserModel(id: session.uid, email: session.email ?? '', name: ''),
        );
      }
      final userData = await remoteDatasource.getCurrentUserData();
      if (userData == null) {
        return left(Failure('User not logged in!'));
      }
      return right(userData);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserEntity>> _getUser(
    Future<UserEntity> Function() fn,
  ) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure('No Internet Connection!'));
      }
      final userData = await fn();
      return right(userData);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.toString()));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDatasource.signOut();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
