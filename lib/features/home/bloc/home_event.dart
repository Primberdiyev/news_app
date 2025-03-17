part of 'home_bloc.dart';

//@immutable
abstract class HomeEvent {}

class GetNewsEvent extends HomeEvent {
  GetNewsEvent({this.country, this.categoryName, this.filterType});
  CountryModel? country;
  String? categoryName;
  String? filterType;
}

class DeleteNews extends HomeEvent {}

class FilterNewsEvent extends HomeEvent {
  FilterNewsEvent(
    this.enteredWord,
  );
  final String enteredWord;
}

class ChangeFilterTypeEvent extends HomeEvent {
  ChangeFilterTypeEvent(this.filterType);

  String filterType;
}
