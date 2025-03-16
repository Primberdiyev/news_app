import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';
import 'package:news_app/features/utils/app_texts.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.function,
    required this.isLoading,
  });
  final VoidCallback function;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
            minimumSize: Size(size - 50, 50),
            backgroundColor: AppColors.primary),
        child: !isLoading
            ? Text(
                AppTexts.continueText,
                style: AppTextStyles.body16W400.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
