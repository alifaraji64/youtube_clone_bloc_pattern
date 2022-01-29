import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/firebase_operations.dart';

part 'avatar_storage_state.dart';

class AvatarStorageCubit extends Cubit<AvatarStorageState> {
  AvatarStorageCubit() : super(AvatarStorageInitial());
  FirebaseOperations _firebaseOperations = FirebaseOperations();
  String url;
  uploadToFirebase(String selectedImage, String uid) async {
    emit(AvatarStorageWaiting());
    try {
      url = await _firebaseOperations.uploadToStorage(
          '/avatars/', selectedImage, uid);
      emit(AvatarStorageDone(url: url));
    } catch (e) {
      print('error occured');
      emit(AvatarStorageError(msg: e.code.toString()));
    }
  }
}
