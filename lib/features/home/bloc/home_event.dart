part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetNewsEvent extends HomeEvent {}

class DeleteNews extends HomeEvent {}

class FilterNewsEvent extends HomeEvent {
  FilterNewsEvent(
    this.enteredWord,
  );

  final String enteredWord;
}
