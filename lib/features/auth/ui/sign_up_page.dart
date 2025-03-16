import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/ui_kit/custom_text_field.dart';
import 'package:news_app/features/auth/bloc/auth_bloc.dart';
import 'package:news_app/features/auth/models/user_model.dart';
import 'package:news_app/features/auth/widgets/continue_button.dart';
import 'package:news_app/features/routes/name_routes.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController emailNameController = TextEditingController();

  final TextEditingController passwordNameController = TextEditingController();
  @override
  void dispose() {
    firstNameController.dispose();
    emailNameController.dispose();
    passwordNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          Navigator.pushReplacementNamed(context, NameRoutes.home);
        } else if (state is AuthErrorState) {
          log('error ${state.errorMessage}');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.only(
              top: 63,
              left: 25,
              right: 25,
            ),
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
                alignment: Alignment.centerLeft,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15),
                child: Text(
                  AppTexts.createAccount,
                  style: AppTextStyles.head32W600,
                ),
              ),
              CustomTextField(
                controller: firstNameController,
                hintText: AppTexts.firstName,
              ),
              CustomTextField(
                controller: emailNameController,
                hintText: AppTexts.emailAddress,
              ),
              CustomTextField(
                controller: passwordNameController,
                hintText: AppTexts.password,
              ),
              ContinueButton(
                function: () {
                  final UserModel userModel = UserModel(
                    firstName: firstNameController.text,
                    email: emailNameController.text,
                    password: passwordNameController.text,
                  );
                  context
                      .read<AuthBloc>()
                      .add(SignUpEvent(userModel: userModel));
                },
                isLoading: state is AuthLoadingState,
              ),
            ],
          ),
        );
      },
    );
  }
}
