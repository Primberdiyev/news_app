import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/features/auth/models/user_model.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/constants.dart';

class HiveDatabaseService {
  static late final Box boxUsers;

  Future<void> setUpHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    boxUsers = await Hive.openBox<UserModel>(AppTexts.userBox);
  }

  void writeToLocal({required UserModel userModel}) async {
    boxUsers.put(Constants.userKey, userModel);
  }

  UserModel? getUserModel() {
    return boxUsers.get(Constants.userKey);
  }

  void clearUserModel() {
    boxUsers.delete(Constants.userKey);
  }
}
