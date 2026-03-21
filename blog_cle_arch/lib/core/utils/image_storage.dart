import 'dart:io';

abstract interface class ImageStorage {
  Future<String> saveImage(File image, String id);
}
