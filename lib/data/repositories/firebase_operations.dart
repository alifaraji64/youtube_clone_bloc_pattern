import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseOperations {
  Future<String> uploadToStorage(String file, String uid) async {
    String url;
    UploadTask uploadTask;
    Reference storageRef =
        FirebaseStorage.instance.ref().child('/avatars/' + uid);
    uploadTask = storageRef.putFile(File(file));
    await uploadTask.whenComplete(() async {
      url = await storageRef.getDownloadURL();
    });
    return url;
  }
}
