part of 'home_bloc.dart';

//@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({required this.articles});
  List<Article> articles;
}

class HomeErrorState extends HomeState {
  HomeErrorState({required this.errorMessage});
  final String errorMessage;
}
