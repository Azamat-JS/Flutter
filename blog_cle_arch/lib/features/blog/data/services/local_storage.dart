import 'dart:io';

import 'package:blog_cle_arch/core/error/exceptions.dart';
import 'package:blog_cle_arch/core/utils/image_storage.dart';
import 'package:path_provider/path_provider.dart';

class LocalImageStorage implements ImageStorage {
  @override
  Future<String> saveImage(File image, String id) async {
    try {
      final dir = await getApplicationDocumentsDirectory();

      final imagesDir = Directory('${dir.path}/images');

      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      final extension = image.path.split('.').last;
      final filePath =
          '${imagesDir.path}/${id}_${DateTime.now().millisecondsSinceEpoch}.$extension';

      final newImage = await image.copy(filePath);

      return newImage.path;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
