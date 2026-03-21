import 'package:blog_cle_arch/features/blog/domain/entity/blog_entity.dart';
import 'package:flutter/material.dart';

class BlogViewerPage extends StatelessWidget {
  static route(BlogEntity blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blog: blog));
  final BlogEntity blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            blog.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
