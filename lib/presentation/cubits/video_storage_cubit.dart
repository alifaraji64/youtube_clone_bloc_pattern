import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/firebase_operations.dart';

part 'video_storage_state.dart';

class VideoStorageCubit extends Cubit<VideoStorageState> {
  VideoStorageCubit() : super(null);
  FirebaseOperations _firebaseOperations = FirebaseOperations();
  String url;
  uploadToFirebase(File selectedVideo, String uid) async {
    emit(VideoStorageWaiting());
    try {
      url = await _firebaseOperations.uploadVideoToStorage(
          '/videos/', selectedVideo, uid);
      emit(VideoStorageDone(url: url));
      print('video uploaded');
      print(url);
    } catch (e) {
      print('error occured');
      emit(VideoStorageError(msg: e.code.toString()));
    }
  }
}
