import 'package:bloc/bloc.dart';
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
    on<DeleteNews>(deleteNews);
    on<ChangeFilterTypeEvent>(changeFilterType);
  }

  final IsarDatabaseService databaseService = IsarDatabaseService();
  final NewsRepositories newsRepositories = NewsRepositories();

  final defaultCountry = SortComponents.countryComponents.first;
  final defaultCategory = SortComponents.categories.first;
  List<Article> news = [];
  void getNewsEvent(GetNewsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      news = await newsRepositories.setAndGetNews(
          event.country?.shortName, event.categoryName);

      emit(HomeSuccessState(
        articles: news,
        selectedCountry: event.country,
        selectedCategory: event.categoryName,
        filterType: event.filterType,
      ));
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
      news = await newsRepositories.setAndGetNews(country?.shortName, category);
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

  void deleteNews(DeleteNews event, Emitter<HomeState> emit) async {
    await databaseService.clearDatabase();
  }
}
