import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/user_info.dart';

part 'video_picker_state.dart';

class VideoPickerCubit extends Cubit<VideoPickerState> {
  VideoPickerCubit() : super(VideoPickerInitial());
  UserInfo _userInfo = UserInfo();
  String selectedVideo;
  Future pickVideo() async {
    try {
      selectedVideo = await _userInfo.pickVideo();
      emit(VideoPickerDone(selectedVideo: selectedVideo));
    } on CustomException catch (e) {
      emit(VideoPickerError(msg: e.msg));
    } catch (e) {
      emit(VideoPickerError(
          msg: 'some unknown error occured while picking the video'));
    }
  }
}
