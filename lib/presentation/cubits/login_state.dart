part of 'login_cubit.dart';

@immutable
abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginDone extends LoginState {}

class InProcess extends LoginState {}

class Error extends LoginState {
  final String msg;
  const Error(this.msg);
}
