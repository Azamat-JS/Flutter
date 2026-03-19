import 'package:blog_cle_arch/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const BlogEditor({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppPallete.greyColor,
          fontStyle: FontStyle.italic,
        ),
      ),
      maxLines: null,
    );
  }
}
