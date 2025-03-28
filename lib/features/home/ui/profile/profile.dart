import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_images.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    context.read<HomeBloc>().add(GetUserModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String? imageLink = (state is HomeSuccessState)
            ? state.userModel?.imageAssetLink
            : null;
        return Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(PickUserImageEvent());
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage:
                    imageLink != null && File(imageLink).existsSync()
                        ? FileImage(File(imageLink))
                        : AssetImage(
                            AppImages.userDefault.image,
                          ) as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset(
                    AppImages.logOut.image,
                    height: 30,
                    width: 30,
                  ),
                ),
                Text(
                  AppTexts.logOut,
                  style:
                      AppTextStyles.body18W400.copyWith(color: AppColors.red),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
