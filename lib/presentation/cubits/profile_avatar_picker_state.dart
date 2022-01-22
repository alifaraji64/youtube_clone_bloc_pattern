part of 'profile_avatar_picker_cubit.dart';

@immutable
abstract class ProfileAvatarPickerState {
  const ProfileAvatarPickerState();
}

class ProfileAvatarPickerDone extends ProfileAvatarPickerState {
  final String selectedImage;
  const ProfileAvatarPickerDone({this.selectedImage});
}

class ProfileAvatarPickerError extends ProfileAvatarPickerState {
  final String msg;
  const ProfileAvatarPickerError({this.msg});
}
