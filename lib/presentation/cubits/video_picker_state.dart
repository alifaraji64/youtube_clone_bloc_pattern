part of 'video_picker_cubit.dart';

@immutable
abstract class VideoPickerState {
  const VideoPickerState();
}

class VideoPickerInitial extends VideoPickerState {}

class VideoPickerDone extends VideoPickerState {
  final String selectedVideo;
  const VideoPickerDone({this.selectedVideo});
}

class VideoPickerError extends VideoPickerState {
  final String msg;
  const VideoPickerError({this.msg});
}
