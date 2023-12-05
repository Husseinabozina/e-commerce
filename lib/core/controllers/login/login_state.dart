part of 'login_cubit.dart';

class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  User user;
  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {}
