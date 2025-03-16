part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class UnRegistered extends SplashState {}

class Registered extends SplashState {}

class SplashLoading extends SplashState {}
