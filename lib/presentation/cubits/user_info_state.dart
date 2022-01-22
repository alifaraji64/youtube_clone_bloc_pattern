part of 'user_info_cubit.dart';

@immutable
abstract class UserInfoState {
  const UserInfoState();
}

class UserInfoInitial extends UserInfoState {}

class UserInfoLoaded extends UserInfoState {
  final User user;
  const UserInfoLoaded({this.user});
}

class Error extends UserInfoState {
  final String msg;
  const Error({this.msg});
}
