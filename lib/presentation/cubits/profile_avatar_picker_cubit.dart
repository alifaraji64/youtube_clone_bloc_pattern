import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_clone/data/repositories/user_info.dart';

part 'profile_avatar_picker_state.dart';

class ProfileAvatarPickerCubit extends Cubit<ProfileAvatarPickerState> {
  ProfileAvatarPickerCubit() : super(null);
  UserInfo _userInfo = UserInfo();
  String selectedImage;
  Future pickProfileAvatar() async {
    try {
      selectedImage = await _userInfo.pickImage();
      emit(ProfileAvatarPickerDone(selectedImage: selectedImage));
    } on CustomException catch (e) {
      emit(ProfileAvatarPickerError(msg: e.msg));
    } catch (e) {
      emit(ProfileAvatarPickerError(
          msg: 'some unknown error occured while picking the avatar'));
      print('error occured while picking the avatar');
    }
  }
}
