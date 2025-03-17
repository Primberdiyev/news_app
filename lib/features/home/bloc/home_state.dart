part of 'home_bloc.dart';

//@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({this.articles, this.selectedCountry, this.filterType});
  List<Article>? articles;
  CountryModel? selectedCountry;
  String? filterType;

  HomeSuccessState copyWith(
      {List<Article>? articles,
      CountryModel? selectedCountry,
      String? filterType}) {
    return HomeSuccessState(
      articles: articles ?? this.articles,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      filterType: filterType ?? this.filterType,
    );
  }
}

class HomeErrorState extends HomeState {
  HomeErrorState({required this.errorMessage});
  final String errorMessage;
}
