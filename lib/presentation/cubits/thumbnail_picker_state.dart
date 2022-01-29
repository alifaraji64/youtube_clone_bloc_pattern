part of 'thumbnail_picker_cubit.dart';

@immutable
abstract class ThumbnailPickerState {
  const ThumbnailPickerState();
}

class ThumbnailPickerInitial extends ThumbnailPickerState {}

class ThumbnailPickerDone extends ThumbnailPickerState {
  final String selectedThumbnail;
  const ThumbnailPickerDone({this.selectedThumbnail});
}

class ThumbnailPickerError extends ThumbnailPickerState {
  final String msg;
  const ThumbnailPickerError({this.msg});
}
