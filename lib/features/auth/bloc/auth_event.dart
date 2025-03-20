part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  SignUpEvent({
    required this.userModel,
  });

  final UserModel userModel;
}

class SignInEvent extends AuthEvent {
  SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class DeleteUserEvent extends AuthEvent {}

class CheckUserAuth extends AuthEvent {}
