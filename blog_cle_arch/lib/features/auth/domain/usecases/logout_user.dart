import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/core/usecase/usecase.dart';
import 'package:blog_cle_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUser implements UseCase<void, NoParams> {
  final AuthRepository repository;
  LogoutUser(this.repository);
  @override
  Future<Either<Failure, dynamic>> call(NoParams params) async {
    return await repository.logout();
  }
}
