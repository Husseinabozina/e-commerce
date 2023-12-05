part of 'register_cubit.dart';

class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterDone extends RegisterState {
  User user;
  RegisterDone({required this.user});
}

class RegisterError extends RegisterState {}

class ChooseImage extends RegisterState {}
