import 'dart:io';

import 'package:blog_cle_arch/core/utils/calculate_reading_time.dart';
import 'package:blog_cle_arch/features/blog/domain/entity/blog_entity.dart';
import 'package:blog_cle_arch/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final BlogEntity blog;
  final Color color;

  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    final isNetwork = blog.imageUrl.startsWith('http');

    Widget imageWidget;

    if (isNetwork) {
      imageWidget = Image.network(
        blog.imageUrl,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _brokenImage();
        },
      );
    } else {
      final file = File(blog.imageUrl);

      if (file.existsSync()) {
        imageWidget = Image.file(
          file,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      } else {
        imageWidget = _brokenImage();
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, BlogViewerPage.route(blog));
      },
      child: Container(
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // allows container to fit content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imageWidget,
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: blog.topics
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Chip(label: Text(e)),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              blog.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('${calculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }

  Widget _brokenImage() {
    return Container(
      height: 200, // match image height
      color: Colors.grey,
      child: const Center(child: Icon(Icons.broken_image)),
    );
  }
}
