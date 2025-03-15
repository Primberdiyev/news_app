import 'package:flutter/material.dart';
import 'package:news_app/features/home/repositories/database.dart';
import 'package:news_app/features/utils/app_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.delete,
        color: AppColors.red,
      ),
      onPressed: () async {
        await Database().clearDatabase();
      },
    );
  }
}
