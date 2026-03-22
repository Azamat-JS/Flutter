import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/core/network/connection_checker.dart';
import 'package:blog_cle_arch/core/utils/image_storage.dart';
import 'package:blog_cle_arch/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_cle_arch/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_cle_arch/features/blog/data/models/blog_model.dart';
import 'package:blog_cle_arch/features/blog/domain/entity/blog_entity.dart';
import 'package:blog_cle_arch/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final ImageStorage imageStorage;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;
  BlogRepositoryImpl(
    this.remoteDataSource,
    this.imageStorage,
    this.blogLocalDataSource,
    this.connectionChecker,
  );

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required String posterName,
    required List<String> topics,
  }) async {
    if (!await connectionChecker.isConnected) {
      return left(Failure('No Internet Connection!'));
    }

    final id = const Uuid().v4();

    try {
      final imagePath = await imageStorage.saveImage(image, id);

      final localBlog = BlogModel(
        id: id,
        posterId: posterId,
        posterName: posterName,
        title: title,
        content: content,
        imageUrl: imagePath,
        topics: topics,
        updatedAt: DateTime.now(),
      );

      await remoteDataSource.uploadBlog(localBlog);

      blogLocalDataSource.uploadLocalBlogs(blogs: [localBlog]);

      return right(localBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    try {
      final localBlogs = blogLocalDataSource.loadBlogs();

      if (localBlogs.isNotEmpty) {
        return right(localBlogs);
      }

      if (await connectionChecker.isConnected) {
        final remoteBlogs = await remoteDataSource.getAllBlogs();
        return right(remoteBlogs);
      }

      return left(Failure('No data available'));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
