import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:loginbloc/Authentification/repositories/database/database_repository.dart';
import 'package:loginbloc/Authentification/repositories/storage/base_storage_repository.dart';
import 'package:loginbloc/user_model.dart';


class StorageRepository extends BaseStorageRepository {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
Future<void> uploadImage(User user, XFile image) async {
  try {
    String filePath = 'profilePics/${user.uid}/${image.name}';
    await storage
        .ref(filePath)
        .putFile(File(image.path))
        .then((p0) => DatabaseRepository().updateUserPictures(user, filePath));
  } catch (err) {
    print(err);
  }
}


 @override
  Future<String> getDownloadURL(User user, String imageName) async {
    String downloadURL =
        await storage.ref('profilePics/${user.uid}/$imageName').getDownloadURL();
    return downloadURL;
  }
}
