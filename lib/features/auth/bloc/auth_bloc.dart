import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/services/hive_database_service.dart';
import 'package:news_app/features/auth/models/user_model.dart';
import 'package:news_app/features/utils/app_texts.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<SignUpEvent>(signUp);
    on<SignInEvent>(signIn);
  }
  final HiveDatabaseService hiveService = HiveDatabaseService();

  void signUp(SignUpEvent event, Emitter<AuthState> emit) {
    emit(AuthLoadingState());
    try {
      hiveService.writeToLocal(userModel: event.userModel);
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  void signIn(SignInEvent event, Emitter<AuthState> emit) {
    emit(AuthLoadingState());
    try {
      final UserModel? userModel = hiveService.getUserModel();
      if (userModel == null ||
          (userModel.email != event.email ||
              userModel.password != event.password)) {
        emit(AuthErrorState(errorMessage: AppTexts.notRegistered));
        return;
      }

      emit(AuthSuccessState());
    } catch (e) {
      AuthErrorState(errorMessage: e.toString());
    }
  }
}
