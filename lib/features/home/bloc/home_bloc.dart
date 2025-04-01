import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:news_app/core/services/hive_database_service.dart';
import 'package:news_app/features/auth/models/user_model.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/core/services/isar_database_service.dart';
import 'package:news_app/features/home/models/country_model.dart';
import 'package:news_app/features/home/repositories/news_repositories.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/constants.dart';
import 'package:news_app/features/utils/sort_components.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetNewsEvent>(getNewsEvent);
    on<ChangeFilterTypeEvent>(changeFilterType);
    on<DeleteNewsByIdEvent>(deleteNewsById);
    on<EditNewsEvent>(editNews);
    on<RefleshNewsEvent>(refleshNews);
    on<PickImageEvent>(pickImage);
    on<CreateNewArticle>(createNewArticle);
    on<ChangeCategoryEvent>(changeCategory);
    on<ChangeSlideIndexEvent>(changeSliderIndex);
    on<GetTeslaNewEvent>(getTeslaNews);
    on<FilterNewsEvent>(filterNews);
    on<GetUserModel>(getUserModel);
    on<PickUserImageEvent>(pickUserImage);
    on<ChangeShowPasswordValueEvent>(changeShowPasswordValue);
    on<DeleteUserModelEvent>(deleteUserModel);
    on<ChangeUserDetailEvent>(changeUserDetail);
  }

  final IsarDatabaseService databaseService = IsarDatabaseService();
  final NewsRepositories newsRepositories = NewsRepositories();
  final defaultCountry = SortComponents.countryComponents.first;
  final defaultCategory = SortComponents.categories.first;
  final HiveDatabaseService hiveDatabaseService = HiveDatabaseService();
  void getNewsEvent(GetNewsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      final news = await newsRepositories.setAndGetNews(
        country: event.country?.shortName,
        category: event.categoryName,
        isTesla: event.isTesla ?? false,
      );
      emit(HomeSuccessState(
          articles: news,
          selectedCountry: event.country,
          selectedCategory: event.categoryName,
          filterType: event.filterType,
          originalArticles: news));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void changeFilterType(
      ChangeFilterTypeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final String? category =
          event.filterType == AppTexts.category ? Constants.technology : null;
      final CountryModel? country =
          event.filterType == AppTexts.country ? defaultCountry : null;
      final news = await newsRepositories.setAndGetNews(
          country: country?.shortName, category: category);
      emit(HomeSuccessState(
        articles: news,
        filterType: event.filterType,
        selectedCountry: country,
        selectedCategory: category,
      ));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void deleteNewsById(
      DeleteNewsByIdEvent event, Emitter<HomeState> emit) async {
    databaseService.deleteNewsById(id: event.article.id);
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      final news = currentState.articles;
      news.remove(event.article);
      emit(currentState.copyWith(articles: news));
    }
  }

  void editNews(EditNewsEvent event, Emitter<HomeState> emit) async {
    await databaseService.editNews(article: event.editedArticle);
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      final news = currentState.articles;
      news[news.indexOf(event.lastArticle)] = event.editedArticle;
      emit(currentState.copyWith(articles: news));
    }
  }

  void refleshNews(RefleshNewsEvent event, Emitter<HomeState> emit) async {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      await databaseService.clearDatabase();
      add(GetNewsEvent(
        country: currentState.selectedCountry,
        categoryName: currentState.selectedCategory,
        filterType: currentState.filterType,
      ));
    }
  }

  void pickImage(PickImageEvent event, Emitter<HomeState> emit) async {
    final currentSuccesState = state as HomeSuccessState;

    emit(HomeLoadingState());
    final imageLink = await newsRepositories.getImageLink();
    emit(currentSuccesState.copyWith(pickedImageLink: imageLink));
  }

  void createNewArticle(CreateNewArticle event, Emitter<HomeState> emit) async {
    final successState = state as HomeSuccessState;
    emit(HomeLoadingState());
    try {
      await databaseService.createArticle(event.createdArticle);
      emit(successState.copyWith(selectedCategory: event.selectedCategory));
    } catch (e) {
      log('error on creating article $e');
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void changeCategory(ChangeCategoryEvent event, Emitter<HomeState> emit) {
    if (state is HomeSuccessState) {
      final currentstate = state as HomeSuccessState;
      emit(currentstate.copyWith(selectedCategory: event.category));
    }
  }

  void changeSliderIndex(ChangeSlideIndexEvent event, Emitter<HomeState> emit) {
    final currentState = state as HomeSuccessState;
    emit(currentState.copyWith(currentSlideIndex: event.slideIndex));
  }

  void getTeslaNews(GetTeslaNewEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      final news = await newsRepositories.setAndGetNews(isTesla: true);

      emit(HomeSuccessState(articles: news, originalArticles: news));
    } catch (e) {
      log('error on getting news by query $e');
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void filterNews(FilterNewsEvent event, Emitter<HomeState> emit) {
    if (state is HomeSuccessState) {
      final currentState = state as HomeSuccessState;
      final news = currentState.originalArticles;

      final filteredNews = (news ?? [])
          .where((element) => (element.title ?? '')
              .toLowerCase()
              .contains(event.enteredWord.toLowerCase()))
          .toList();
      emit(currentState.copyWith(articles: filteredNews));
    }
  }

  void getUserModel(GetUserModel event, Emitter<HomeState> emit) async {
    final currentState = state as HomeSuccessState;
    final userModel = hiveDatabaseService.getUserModel();
    emit(currentState.copyWith(userModel: userModel));
  }

  void pickUserImage(PickUserImageEvent event, Emitter<HomeState> emit) async {
    try {
      final currentState = state as HomeSuccessState;
      await hiveDatabaseService.pickUserImage();
      final userModel = hiveDatabaseService.getUserModel();

      emit(currentState.copyWith(userModel: userModel));
    } catch (e) {
      log('error $e');
    }
  }

  void changeShowPasswordValue(
      ChangeShowPasswordValueEvent event, Emitter<HomeState> emit) {
    final currentState = state as HomeSuccessState;
    emit(currentState.copyWith(isObscured: !currentState.isObscured));
  }

  void deleteUserModel(DeleteUserModelEvent event, Emitter<HomeState> emit) {
    hiveDatabaseService.deleteUserModel();
  }

  void changeUserDetail(ChangeUserDetailEvent event, Emitter<HomeState> emit) {
    final currentState = state as HomeSuccessState;
    hiveDatabaseService.writeToLocal(userModel: event.userModel);
    final userModel = hiveDatabaseService.getUserModel();
    emit(currentState.copyWith(userModel: userModel));
  }
}
