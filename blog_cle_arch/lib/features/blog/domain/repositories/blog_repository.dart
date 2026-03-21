import 'dart:io';

import 'package:blog_cle_arch/core/error/failures.dart';
import 'package:blog_cle_arch/features/blog/domain/entity/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required String posterName,
    required List<String> topics,
  });

  Future<Either<Failure, List<BlogEntity>>> getAllBlogs();
}
