import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FileUploader {
  static Future<String?> uploadFileMobile(PlatformFile file) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("images/${file.name}");
    UploadTask uploadTask = firebaseStorageRef.putFile(File(file.path!));
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL().then((value) => (value));
  }

  static Future<String?> uploadFileWeb(PlatformFile file) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("images/${file.name}");
    UploadTask uploadTask = firebaseStorageRef.putData(file.bytes!);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL().then((value) => (value));
  }
}
