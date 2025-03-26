import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/features/auth/models/user_model.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

class HiveDatabaseService {
  static late final Box boxUsers;
  Future<void> setUpHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    boxUsers = await Hive.openBox<UserModel>(AppTexts.userBox);
  }

  final userKey = Constants.userKey;

  void writeToLocal({required UserModel userModel}) async {
    boxUsers.put(userKey, userModel);
  }

  UserModel? getUserModel() {
    final UserModel userModel = boxUsers.get(userKey);
    return userModel;
  }

  void clearUserModel() {
    boxUsers.delete(userKey);
  }

  void saveImageLink({required String imageLink}) async {
    final userModel = getUserModel();
    final newUser = userModel?.copyWith(imageAssetLink: imageLink);
    boxUsers.put(userKey, newUser);
  }

  Future<void> pickUserImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final pickedImage = File(image.path);
    final Directory directory = await getApplicationDocumentsDirectory();
    final savedFile = await pickedImage
        .copy('${directory.path}/${Constants.userImageLinkName}');
    saveImageLink(imageLink: savedFile.path);
  }
}
