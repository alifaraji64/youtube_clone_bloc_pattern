part of 'get_videos_cubit.dart';

@immutable
abstract class GetVideosState {
  const GetVideosState();
}

class GetVideosInitial extends GetVideosState {}

class GetVideosDone extends GetVideosState {
  final List videos;
  const GetVideosDone({this.videos});
}

class GetVideosError extends GetVideosState {
  final String msg;
  const GetVideosError({this.msg});
}
