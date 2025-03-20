part of 'home_bloc.dart';

//@immutable
abstract class HomeEvent {}

class GetNewsEvent extends HomeEvent {
  GetNewsEvent({this.country, this.categoryName, this.filterType});
  CountryModel? country;
  String? categoryName;
  String? filterType;
}

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

class DeleteNewsByIdEvent extends HomeEvent {
  DeleteNewsByIdEvent({required this.article});
  Article article;
}

class EditNewsEvent extends HomeEvent {
  EditNewsEvent({
    required this.editedArticle,
    required this.lastArticle,
  });
  Article editedArticle;
  Article lastArticle;
}

class RefleshNewsEvent extends HomeEvent {}

class PickImageEvent extends HomeEvent {}

class CreateNewArticle extends HomeEvent {
  CreateNewArticle({
    required this.createdArticle,
    required this.selectedCategory,
  });
  Article createdArticle;
  String selectedCategory;
}

class ChangeCategoryEvent extends HomeEvent {
  ChangeCategoryEvent(this.category);
  String category;
}

class ChangeSlideIndexEvent extends HomeEvent {
  ChangeSlideIndexEvent(this.slideIndex);
  int slideIndex;
}
