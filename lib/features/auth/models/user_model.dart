import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  UserModel(
      {required this.firstName,
      required this.email,
      required this.password,
      this.imageAssetLink});
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String? imageAssetLink;

  UserModel copyWith({
    String? firstName,
    String? email,
    String? password,
    String? imageAssetLink,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      password: password ?? this.password,
      imageAssetLink: imageAssetLink ?? this.imageAssetLink,
    );
  }
}
