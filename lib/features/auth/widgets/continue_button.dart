import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key, required this.function});
  final VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            backgroundColor: AppColors.primary),
        child: Text(
          AppTexts.continueText,
          style: AppTextStyles.body16W400
              .copyWith(color: AppColors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
