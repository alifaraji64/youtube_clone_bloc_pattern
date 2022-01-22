part of 'avatar_to_mysql_cubit.dart';

@immutable
abstract class AvatarToMysqlState {
  const AvatarToMysqlState();
}

class AvatarToMysqError extends AvatarToMysqlState {
  final String msg;
  const AvatarToMysqError({this.msg});
}
