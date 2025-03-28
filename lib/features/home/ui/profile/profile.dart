import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/ui_kit/custom_button.dart';
import 'package:news_app/core/ui_kit/custom_text_field.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  @override
  void initState() {
    context.read<HomeBloc>().add(GetUserModel());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String? imageLink = (state is HomeSuccessState)
            ? state.userModel?.imageAssetLink
            : null;
        String userName =
            (state is HomeSuccessState) ? state.userModel?.firstName ?? "" : '';
        String lastName =
            (state is HomeSuccessState) ? state.userModel?.password ?? "" : '';
        nameController.text = userName;
        lastNameController.text = lastName;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
              CustomTextField(
                  controller: nameController, hintText: AppTexts.firstName),
              CustomTextField(
                controller: lastNameController,
                hintText: AppTexts.password,
                showPassword:
                    state is HomeSuccessState ? state.isObscured : false,
                maxLine: 1,
                function: () => context
                    .read<HomeBloc>()
                    .add(ChangeShowPasswordValueEvent()),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Image.asset(
                    AppImages.logOut.image,
                    height: 30,
                    width: 30,
                  ),
                  Text(
                    AppTexts.logOut,
                    style:
                        AppTextStyles.body18W400.copyWith(color: AppColors.red),
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonHeight: 50,
                      color: AppColors.primary,
                      text: AppTexts.save,
                      textColor: AppColors.white,
                      function: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
