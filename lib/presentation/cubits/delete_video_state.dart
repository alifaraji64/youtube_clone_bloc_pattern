part of 'delete_video_cubit.dart';

@immutable
abstract class DeleteVideoState {
  const DeleteVideoState();
}

class DeleteVideoDone extends DeleteVideoState {}

class DeleteVideoError extends DeleteVideoState {
  final String msg;
  const DeleteVideoError({this.msg});
}
