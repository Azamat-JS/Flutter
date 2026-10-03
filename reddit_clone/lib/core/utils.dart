import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

Future<List<PlatformFile?>> pickImage() async {
  final image = await FilePicker.pickFiles(type: FileType.image);
  return image;
}
