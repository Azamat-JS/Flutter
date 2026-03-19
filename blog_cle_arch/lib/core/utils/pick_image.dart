import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

final _imagePicker = ImagePicker();

Future<File?> pickImage({
  ImageSource source = ImageSource.gallery,
  double maxWidth = 1600,
  double maxHeight = 1600,
  int imageQuality = 80,
}) async {
  try {
    final xFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      requestFullMetadata: false,
    );
    if (xFile != null) {
      return File(xFile.path);
    }
    return null;
  } catch (e) {
    debugPrint('Image pick err: $e');
    return null;
  }
}
