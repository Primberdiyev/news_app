part of 'home_bloc.dart';

//@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({
    this.articles,
    this.selectedCountry,
    this.filterType,
    this.selectedCategory,
  });
  List<Article>? articles;
  CountryModel? selectedCountry;
  String? filterType;
  String? selectedCategory;

  HomeSuccessState copyWith({
    List<Article>? articles,
    CountryModel? selectedCountry,
    String? filterType,
    String? selectedCategory,
  }) {
    return HomeSuccessState(
      articles: articles ?? this.articles,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      filterType: filterType ?? this.filterType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class HomeErrorState extends HomeState {
  HomeErrorState({required this.errorMessage});
  final String errorMessage;
}
