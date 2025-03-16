import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';
import 'package:news_app/features/utils/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
  });
  final TextEditingController controller;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          filled: true,
          fillColor: AppColors.textFieldColor,
          hintStyle: AppTextStyles.body16W400.copyWith(
            color: AppColors.black.withValues(alpha: 0.5),
          ),
          contentPadding: const EdgeInsets.only(
            left: 12,
            top: 19,
            bottom: 17,
          ),
        ),
      ),
    );
  }
}
