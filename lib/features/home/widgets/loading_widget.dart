import 'package:flutter/material.dart';
import 'package:news_app/features/utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.blue,
      ),
    );
  }
}
