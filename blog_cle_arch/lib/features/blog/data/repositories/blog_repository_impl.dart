import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/core/utils/image_storage.dart';
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
  BlogRepositoryImpl(this.remoteDataSource, this.imageStorage);

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required String posterName,
    required List<String> topics,
  }) async {
    final String id = const Uuid().v4();
    final BlogModel blog = BlogModel(
      id: id,
      posterId: posterId,
      posterName: posterName,
      title: title,
      content: content,
      imageUrl: '',
      topics: topics,
      updatedAt: DateTime.now(),
    );

    try {
      final imagePath = await imageStorage.saveImage(image, blog.id);

      final blogWithImage = blog.copyWith(imageUrl: imagePath);
      await remoteDataSource.uploadBlog(blogWithImage);
      return Right(blogWithImage);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
