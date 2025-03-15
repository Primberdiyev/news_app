import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/home/repositories/database.dart';
import 'package:news_app/features/home/repositories/news_repositories.dart';
import 'package:news_app/features/utils/app_texts.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetNewsEvent>(getNewsEvent);
    on<FilterNewsEvent>(filterNewsEvent);
  }
  List<Article>? allNews = [];

  void getNewsEvent(GetNewsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      List<Article>? news = await Database().getAllArticles();
      if (news.isEmpty) {
        news = await NewsRepositories().fetchNews();
        if ((news ?? []).isEmpty) {
          emit(HomeErrorState(errorMessage: AppTexts.notFount));
          return;
        }
        await Database().saveArticles(news ?? []);
      }
      allNews = news;
      emit(HomeSuccessState(articles: news ?? []));
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
}
