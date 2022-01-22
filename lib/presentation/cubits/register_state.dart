part of 'register_cubit.dart';

@immutable
abstract class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {}

class Registered extends RegisterState {}

class InProcess extends RegisterState {}

class Error extends RegisterState {
  final String msg;
  const Error(this.msg);
}
