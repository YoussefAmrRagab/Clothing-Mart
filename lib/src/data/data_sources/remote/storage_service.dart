import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../util/extensions.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<void> uploadUserImage(String imagePath, File imageFile) async =>
      await _storage.ref().child(imagePath).putFile(
            imageFile,
            SettableMetadata(contentType: "image/${imageFile.extension}"),
          );

  Future<String> getImageUrl(String imagePath) async =>
      await _storage.ref().child(imagePath).getDownloadURL();

  Future<void> deleteImage(String imagePath) async =>
      await _storage.ref().child(imagePath).delete();
}
