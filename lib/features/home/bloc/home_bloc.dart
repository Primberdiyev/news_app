import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/core/services/isar_database_service.dart';
import 'package:news_app/features/home/models/country_model.dart';
import 'package:news_app/features/home/repositories/news_repositories.dart';
import 'package:news_app/features/utils/country_filter_components.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetNewsEvent>(getNewsEvent);
    on<FilterNewsEvent>(filterNewsEvent);
    on<DeleteNews>(deleteNews);
    on<FilterCountryEvent>(filterCountries);
    on<ChangeFilterTypeEvent>(changeFilterType);
  }
  List<Article>? allNews = [];

  final IsarDatabaseService databaseService = IsarDatabaseService();
  final NewsRepositories newsRepositories = NewsRepositories();

  final defaultCountry = CountryFilterComponents().countryComponents.first;

  void getNewsEvent(GetNewsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      ///  List<Article>? news = await databaseService.getAllArticles();
      // if (news.isEmpty) {
      //  final String countryName = event.countryName ?? defaultCountry.shortName;
      List<Article> news = await newsRepositories.fetchNews(
          category: event.categoryName, country: event.countryName);
      //   if ((news ?? []).isEmpty) {
      //     emit(HomeErrorState(errorMessage: AppTexts.notFount));
      //     return;
      //   }
      //   await databaseService.saveArticles(news ?? []);
      // }
      allNews = news;
      emit(HomeSuccessState(articles: news));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void filterNewsEvent(FilterNewsEvent event, Emitter<HomeState> emit) {
    try {
      if (event.enteredWord.isEmpty) {
        emit(HomeSuccessState(articles: allNews ?? []));

        return;
      }
      List<Article> filteredNews = (allNews ?? [])
          .where((e) => (e.title ?? '')
              .toUpperCase()
              .contains(event.enteredWord.toUpperCase()))
          .toList();

      emit(HomeSuccessState(articles: filteredNews));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
      log('error $e');
    }
  }

  void deleteNews(DeleteNews event, Emitter<HomeState> emit) async {
    await databaseService.clearDatabase();
  }

  void filterCountries(
      FilterCountryEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      final news = await newsRepositories.fetchNews(
          country: event.selectedCountry?.shortName ?? 'us',
          category: 'general');
      emit(HomeSuccessState(
          articles: news,
          selectedCountry: event.selectedCountry ?? defaultCountry));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }

  void changeFilterType(
      ChangeFilterTypeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    // final currentState = state as HomeSuccessState;
    try {
      final String? category =
          event.filterType == 'category' ? 'technology' : null;
      final String? country = event.filterType == 'country' ? 'us' : null;
      List<Article> news = await newsRepositories.fetchNews(
        category: category,
        country: country,
      );
      emit(HomeSuccessState(
          articles: news,
          filterType: event.filterType,
          selectedCountry: defaultCountry));
    } catch (e) {
      HomeErrorState(errorMessage: e.toString());
    }
  }
}
