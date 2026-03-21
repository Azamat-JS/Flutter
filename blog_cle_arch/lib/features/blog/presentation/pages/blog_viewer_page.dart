import 'dart:io';

import 'package:blog_cle_arch/core/theme/app_pallete.dart';
import 'package:blog_cle_arch/core/utils/calculate_reading_time.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'By ${blog.posterName}',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                '${blog.updatedAt} . ${calculateReadingTime(blog.content)} min',
                style: const TextStyle(
                  color: AppPallete.greyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(blog.imageUrl),
                  height: 290,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                blog.content,
                style: const TextStyle(fontSize: 16, height: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
