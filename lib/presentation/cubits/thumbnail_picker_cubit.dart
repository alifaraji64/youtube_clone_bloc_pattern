import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/user_info.dart';

part 'thumbnail_picker_state.dart';

class ThumbnailPickerCubit extends Cubit<ThumbnailPickerState> {
  ThumbnailPickerCubit() : super(ThumbnailPickerInitial());
  UserInfo _userInfo = UserInfo();
  String selectedThumbnail;
  Future pickThumbnail() async {
    try {
      selectedThumbnail = await _userInfo.pickImage();
      emit(ThumbnailPickerDone(selectedThumbnail: selectedThumbnail));
    } on CustomException catch (e) {
      emit(ThumbnailPickerError(msg: e.msg));
    } catch (e) {
      emit(ThumbnailPickerError(
          msg: 'some unknown error occured while picking the thumbnail'));
    }
  }

  clearThumbnail() {
    selectedThumbnail = null;
    emit(ThumbnailPickerInitial());
  }
}
