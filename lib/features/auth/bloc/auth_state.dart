part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {
  AuthSuccessState({this.isRegistered});

  final bool? isRegistered;
}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  AuthErrorState({required this.errorMessage});

  final String errorMessage;
}
