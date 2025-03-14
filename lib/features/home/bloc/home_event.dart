part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetNewsEvent extends HomeEvent {}

class FilterNewsEvent extends HomeEvent {
  FilterNewsEvent(this.enteredWord, {required this.news});

  final List<Article> news;
  final String enteredWord;
}
