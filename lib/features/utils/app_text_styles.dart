import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';

class AppTextStyles {
  static TextStyle get body16W400 => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      );
  static TextStyle get body24W600 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      );
}
