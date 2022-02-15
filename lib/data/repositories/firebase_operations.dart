import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseOperations {
  Future<String> uploadToStorage(String path, String file, String uid) async {
    String url;
    UploadTask uploadTask;
    Reference storageRef = FirebaseStorage.instance.ref().child(path + uid);
    uploadTask = storageRef.putFile(File(file));
    await uploadTask.whenComplete(() async {
      url = await storageRef.getDownloadURL();
    });
    return url;
  }

  Future<String> uploadVideoToStorage(
      String path, File file, String uid) async {
    String url;
    UploadTask uploadTask;
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(path + TimeOfDay.now().toString() + uid);
    uploadTask = storageRef.putFile(file);
    await uploadTask.whenComplete(() async {
      url = await storageRef.getDownloadURL();
    });
    return url;
  }

  Future<String> uploadThumbnailToStorage(
      String path, String file, String uid) async {
    String url;
    UploadTask uploadTask;
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(path + TimeOfDay.now().toString() + uid);
    uploadTask = storageRef.putFile(File(file));
    await uploadTask.whenComplete(() async {
      url = await storageRef.getDownloadURL();
    });
    return url;
  }
}
