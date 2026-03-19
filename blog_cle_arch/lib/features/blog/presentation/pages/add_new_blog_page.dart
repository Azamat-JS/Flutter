import 'dart:io';

import 'package:blog_cle_arch/core/theme/app_pallete.dart';
import 'package:blog_cle_arch/core/utils/pick_image.dart';
import 'package:blog_cle_arch/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static MaterialPageRoute<void> route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;
  bool isPickingImage = false;

  Future<void> selectImage() async {
    if (isPickingImage) return;
    setState(() {
      isPickingImage = true;
    });
    final pickedImage = await pickImage();
    if (!mounted) return;
    setState(() {
      isPickingImage = false;
      if (pickedImage != null) {
        image = pickedImage;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('a'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_rounded)),
        ],
      ),
      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: DottedBorder(
                  options: const RoundedRectDottedBorderOptions(
                    radius: Radius.circular(10),
                    strokeCap: StrokeCap.round,
                    dashPattern: [12, 5],
                    strokeWidth: 2,
                    padding: EdgeInsets.all(16),
                    color: AppPallete.borderColor,
                  ),
                  child: GestureDetector(
                    onTap: selectImage,
                    child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Builder(
                        builder: (context) {
                          if (isPickingImage) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                          if (image != null) {
                            final pixelRatio = MediaQuery.of(
                              context,
                            ).devicePixelRatio;
                            final cacheWidth =
                                (MediaQuery.of(context).size.width * pixelRatio)
                                    .round();
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                image!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                cacheWidth: cacheWidth,
                                filterQuality: FilterQuality.low,
                              ),
                            );
                          }
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open, size: 50),
                              SizedBox(height: 15),
                              Text(
                                'Select your image',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      ['Technology', 'Business', 'Programming', 'Entertainment']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (selectedTopics.contains(e)) {
                                    selectedTopics.remove(e);
                                  } else {
                                    selectedTopics.add(e);
                                  }
                                  setState(() {});
                                },
                                child: FilterChip(
                                  label: Text(e),
                                  selected: selectedTopics.contains(e),
                                  onSelected: (isSelected) {
                                    setState(() {
                                      if (isSelected) {
                                        selectedTopics.add(e);
                                      } else {
                                        selectedTopics.remove(e);
                                      }
                                    });
                                  },
                                  selectedColor: AppPallete.gradient1,
                                  backgroundColor: AppPallete.backgroundColor,
                                  side: selectedTopics.contains(e)
                                      ? null
                                      : const BorderSide(
                                          color: AppPallete.borderColor,
                                        ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(controller: titleController, hintText: 'Blog title'),
              const SizedBox(height: 10),
              BlogEditor(
                controller: contentController,
                hintText: 'Blog content',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
