import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/core/usecase/usecase.dart';
import 'package:blog_cle_arch/features/auth/domain/entities/user_entity.dart';
import 'package:blog_cle_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<UserEntity, NoParams> {
  final AuthRepository authRepository;
  const CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await authRepository.getCurrentUserData();
  }
}
