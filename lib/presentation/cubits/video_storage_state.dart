part of 'video_storage_cubit.dart';

@immutable
abstract class VideoStorageState {
  const VideoStorageState();
}

class VideoStorageInitial extends VideoStorageState {}

class VideoStorageWaiting extends VideoStorageState {}

class VideoStorageDone extends VideoStorageState {
  final String url;
  const VideoStorageDone({this.url});
}

class VideoStorageError extends VideoStorageState {
  final String msg;
  const VideoStorageError({this.msg});
}
