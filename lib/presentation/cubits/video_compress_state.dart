part of 'video_compress_cubit.dart';

@immutable
abstract class VideoCompressState {
  const VideoCompressState();
}

class VideoCompressInitial extends VideoCompressState {}

class VideoCompressDone extends VideoCompressState {}

class VideoCompressInProgress extends VideoCompressState {
  final double progress;
  const VideoCompressInProgress({this.progress});
}

class VideoCompressError extends VideoCompressState {
  final String msg;
  const VideoCompressError({this.msg});
}
