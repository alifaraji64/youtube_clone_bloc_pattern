part of 'video_to_mysql_cubit.dart';

@immutable
abstract class VideoToMysqlState {
  const VideoToMysqlState();
}

class VideoToMysqlDone extends VideoToMysqlState {}

class VideoToMysqlWaiting extends VideoToMysqlState {}

class VideoToMysqlError extends VideoToMysqlState {
  final String msg;
  const VideoToMysqlError({this.msg});
}
