import 'package:blog_cle_arch/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_cle_arch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_cle_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_cle_arch/features/auth/domain/usecases/current_user.dart';
import 'package:blog_cle_arch/features/auth/domain/usecases/user_login.dart';
import 'package:blog_cle_arch/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_cle_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  _initAuth();
}

void _initAuth() {
  // datasource
  serviceLocator
    ..registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator<FirebaseAuth>(),
        serviceLocator<FirebaseFirestore>(),
      ),
    )
    // repository
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator<AuthRemoteDatasource>()),
    )
    // sign up usecase
    ..registerLazySingleton<UserSignUp>(
      () => UserSignUp(serviceLocator<AuthRepository>()),
    )
    // login usecase
    ..registerLazySingleton<UserLogin>(
      () => UserLogin(serviceLocator<AuthRepository>()),
    )
    ..registerLazySingleton<CurrentUser>(
      () => CurrentUser(serviceLocator<AuthRepository>()),
    )
    // bloc
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        currentUser: serviceLocator<CurrentUser>(),
      ),
    );
}
