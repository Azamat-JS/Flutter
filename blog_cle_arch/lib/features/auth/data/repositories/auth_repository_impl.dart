import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_cle_arch/features/auth/domain/entities/user_entity.dart';
import 'package:blog_cle_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  const AuthRepositoryImpl(this.remoteDatasource);
  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userData = await remoteDatasource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userData);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
