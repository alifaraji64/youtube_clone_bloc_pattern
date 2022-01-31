import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/firebase_operations.dart';

part 'thumbnail_storage_state.dart';

class ThumbnailStorageCubit extends Cubit<ThumbnailStorageState> {
  ThumbnailStorageCubit() : super(ThumbnailStorageInitial());
  FirebaseOperations _firebaseOperations = FirebaseOperations();
  String url;
  uploadThumbnailToStorage(String selectedImage, String uid) async {
    emit(ThumbnailStorageWaiting());
    try {
      url = await _firebaseOperations.uploadThumbnailToStorage(
          '/thumbnails/', selectedImage, uid);
      emit(ThumbnailStorageDone(url: url));
      print('thumbnail uploaded');
    } catch (e) {
      print('error occured');
      print(e);
      emit(ThumbnailStorageError(msg: e.toString()));
    }
  }
}
