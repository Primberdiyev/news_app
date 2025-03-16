import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/services/hive_database_service.dart';
import 'package:news_app/features/auth/models/user_model.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashEvent>((event, emit) {});
    on<CheckAuthStatusEvent>(checkAuthStatus);
  }
  final HiveDatabaseService hiveDatabaseService = HiveDatabaseService();
  void checkAuthStatus(CheckAuthStatusEvent event, Emitter<SplashState> emit) {
    emit(SplashLoading());
    final UserModel? userModel = hiveDatabaseService.getUserModel();

    try {
      if (userModel == null) {
        emit(UnRegistered());
      }
      emit(Registered());
    } catch (_) {
      emit(UnRegistered());
    }
  }
}
