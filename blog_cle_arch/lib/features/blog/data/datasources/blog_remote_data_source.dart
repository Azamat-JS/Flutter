import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final FirebaseFirestore firestore;
  BlogRemoteDataSourceImpl(this.firestore);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await firestore
          .collection('blogs')
          .doc(blog.id)
          .set(blog.toJson());
      return BlogModel(
        id: blog.id,
        posterId: blog.posterId,
        title: blog.title,
        content: blog.content,
        imageUrl: blog.imageUrl,
        topics: blog.topics,
        updatedAt: blog.updatedAt,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
