import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract interface class BlogRemoteDataSource {
  Future<void> uploadBlog(BlogModel blog);
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final FirebaseFirestore firestore;

  BlogRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final snapshot = await firestore
          .collection('blogs')
          .orderBy('updated_at', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => BlogModel.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> uploadBlog(BlogModel blog) async {
    try {
      await firestore.collection('blogs').doc(blog.id).set(blog.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
