part of 'thumbnail_storage_cubit.dart';

@immutable
abstract class ThumbnailStorageState {
  const ThumbnailStorageState();
}

class ThumbnailStorageInitial extends ThumbnailStorageState {}

class ThumbnailStorageWaiting extends ThumbnailStorageState {}

class ThumbnailStorageDone extends ThumbnailStorageState {
  final String url;
  const ThumbnailStorageDone({this.url});
}

class ThumbnailStorageError extends ThumbnailStorageState {
  final String msg;
  const ThumbnailStorageError({this.msg});
}
