part of 'home_bloc.dart';

//@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  HomeSuccessState({
    required this.articles,
    this.selectedCountry,
    this.filterType,
    this.selectedCategory,
    this.pickedImageLink,
    this.currentSlideIndex,
  });
  List<Article> articles;
  CountryModel? selectedCountry;
  String? filterType;
  String? selectedCategory;
  String? pickedImageLink;
  int? currentSlideIndex;
  HomeSuccessState copyWith({
    List<Article>? articles,
    CountryModel? selectedCountry,
    String? filterType,
    String? selectedCategory,
    String? pickedImageLink,
    int? currentSlideIndex,
  }) {
    return HomeSuccessState(
      articles: articles ?? this.articles,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      filterType: filterType ?? this.filterType,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      pickedImageLink: pickedImageLink ?? this.pickedImageLink,
      currentSlideIndex: currentSlideIndex ?? this.currentSlideIndex,
    );
  }
}

class HomeErrorState extends HomeState {
  HomeErrorState({required this.errorMessage});
  final String errorMessage;
}
