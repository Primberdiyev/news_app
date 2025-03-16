import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class QuestionTextWidget extends StatelessWidget {
  const QuestionTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppTexts.haveAccount,
          style: AppTextStyles.body16W400,
        ),
        GestureDetector(
          child: Text(
            AppTexts.createOne,
            style: AppTextStyles.body14W400,
          ),
        ),
      ],
    );
  }
}
