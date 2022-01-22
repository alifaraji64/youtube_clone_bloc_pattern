part of 'avatar_storage_cubit.dart';

@immutable
abstract class AvatarStorageState {
  const AvatarStorageState();
}

class AvatarStorageInitial extends AvatarStorageState {}

class AvatarStorageDone extends AvatarStorageState {
  final String url;
  const AvatarStorageDone({this.url});
}

class AvatarStorageWaiting extends AvatarStorageState {}

class AvatarStorageError extends AvatarStorageState {
  final String msg;
  const AvatarStorageError({this.msg});
}
