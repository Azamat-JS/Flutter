import 'package:blog_cle_arch/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_cle_arch/core/network/connection_checker.dart';
import 'package:blog_cle_arch/core/utils/image_storage.dart';
import 'package:blog_cle_arch/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_cle_arch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_cle_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_cle_arch/features/auth/domain/usecases/current_user.dart';
import 'package:blog_cle_arch/features/auth/domain/usecases/logout_user.dart';
import 'package:blog_cle_arch/features/auth/domain/usecases/user_login.dart';
import 'package:blog_cle_arch/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_cle_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_cle_arch/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_cle_arch/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_cle_arch/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_cle_arch/features/blog/data/services/local_storage.dart';
import 'package:blog_cle_arch/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_cle_arch/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_cle_arch/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_cle_arch/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  serviceLocator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  final blogBox = await Hive.openBox('blogs');

  serviceLocator.registerLazySingleton<Box>(() => blogBox);

  serviceLocator.registerLazySingleton<ImageStorage>(() => LocalImageStorage());
  serviceLocator.registerLazySingleton(() => InternetConnection());
  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator<InternetConnection>()),
  );
  _initAuth();
  _initBlog();
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
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDatasource>(),
        serviceLocator<ConnectionChecker>(),
      ),
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
    ..registerLazySingleton<LogoutUser>(
      () => LogoutUser(serviceLocator<AuthRepository>()),
    )
    // bloc
    ..registerFactory<AuthBloc>(
      () => AuthBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        currentUser: serviceLocator<CurrentUser>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
        logoutUser: serviceLocator<LogoutUser>(),
      ),
    );
}

void _initBlog() {
  // datasource
  serviceLocator
    ..registerLazySingleton<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator<FirebaseFirestore>()),
    )
    ..registerLazySingleton<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl(serviceLocator<Box>()),
    )
    // repository
    ..registerLazySingleton<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator<BlogRemoteDataSource>(),
        serviceLocator<ImageStorage>(),
        serviceLocator<BlogLocalDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    // usecase
    ..registerLazySingleton<UploadBlog>(
      () => UploadBlog(serviceLocator<BlogRepository>()),
    )
    ..registerFactory(() => GetAllBlogs(serviceLocator<BlogRepository>()))
    // bloc
    ..registerFactory<BlogBloc>(
      () => BlogBloc(
        getAllBlogs: serviceLocator<GetAllBlogs>(),
        uploadBlog: serviceLocator<UploadBlog>(),
      ),
    );
}
