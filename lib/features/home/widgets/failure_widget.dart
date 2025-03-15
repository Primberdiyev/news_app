import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error),
          Text(
            AppTexts.wentWrong,
            style: AppTextStyles.body16W400
                .copyWith(color: AppColors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
