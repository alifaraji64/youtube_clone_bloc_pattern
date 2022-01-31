import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/firebase_operations.dart';

part 'video_storage_state.dart';

class VideoStorageCubit extends Cubit<VideoStorageState> {
  VideoStorageCubit() : super(VideoStorageInitial());
  FirebaseOperations _firebaseOperations = FirebaseOperations();
  String url;
  uploadVideoToStorage(File selectedVideo, String uid) async {
    emit(VideoStorageWaiting());
    try {
      url = await _firebaseOperations.uploadVideoToStorage(
          '/videos/', selectedVideo, uid);
      emit(VideoStorageDone(url: url));
      print('video uploaded');
    } catch (e) {
      print('error occured');
      emit(VideoStorageError(msg: e.code.toString()));
    }
  }
}
