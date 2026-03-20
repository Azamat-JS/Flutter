import 'dart:io';

import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/features/blog/data/models/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract interface class BlogRemoteDataSource {
  Future<void> uploadBlog(BlogModel blog);

  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  BlogRemoteDataSourceImpl(this.firestore, this.storage);

  @override
  Future<void> uploadBlog(BlogModel blog) async {
    try {
      await firestore.collection('blogs').doc(blog.id).set(blog.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      final ref = storage.ref().child('blogs/${blog.id}.jpg');

      await ref.putFile(image);

      final imageUrl = await ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

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
}
