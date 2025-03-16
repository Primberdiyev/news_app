import 'package:flutter/material.dart';
import 'package:news_app/core/ui_kit/custom_text_field.dart';
import 'package:news_app/features/auth/widgets/continue_button.dart';
import 'package:news_app/features/auth/widgets/question_text_widget.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        body: ListView(
          padding: EdgeInsets.only(
            top: 123,
            right: 25,
            left: 25,
          ),
          children: [
            Text(
              AppTexts.signIn,
              style: AppTextStyles.head32W600,
            ),
            CustomTextField(
              controller: emailController,
              hintText: AppTexts.emailAddress,
            ),
            CustomTextField(
              controller: passwordController,
              hintText: AppTexts.password,
            ),
            ContinueButton(
              function: () {},
            ),
            QuestionTextWidget(),
          ],
        ));
  }
}
