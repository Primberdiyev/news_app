import 'package:flutter/material.dart';
import 'package:news_app/core/ui_kit/custom_text_field.dart';
import 'package:news_app/features/auth/widgets/continue_button.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailNameController = TextEditingController();

  final TextEditingController passwordNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            controller: lastNameController,
            hintText: AppTexts.lasttName,
          ),
          CustomTextField(
            controller: emailNameController,
            hintText: AppTexts.emailAddress,
          ),
          CustomTextField(
            controller: passwordNameController,
            hintText: AppTexts.password,
          ),
          ContinueButton(function: () {})
        ],
      ),
    );
  }
}
