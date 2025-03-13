import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/features/home/models/news_model.dart';
import 'package:news_app/features/home/repositories/news_repositories.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetNewsEvent>(getNewsEvent);
  }

  void getNewsEvent(GetNewsEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    try {
      final news = await NewsRepositories().fetchNews();
      emit(HomeSuccessState(articles: news));
    } catch (e) {
      emit(HomeErrorState(errorMessage: e.toString()));
    }
  }
}
