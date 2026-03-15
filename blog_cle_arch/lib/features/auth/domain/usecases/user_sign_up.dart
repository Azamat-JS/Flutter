import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/core/usecase/usecase.dart';
import 'package:blog_cle_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, String>> call(UserSignUpParams params) async {
    if (params.password.length < 6) {
      return left(Failure('Password must be at least 6 characters'));
    }
    if (params.email.isEmpty ||
        params.password.isEmpty ||
        params.name.isEmpty) {
      return left(Failure('All fields are required'));
    }
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
