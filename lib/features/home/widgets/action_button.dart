import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.refresh,
        color: AppColors.red,
      ),
      onPressed: () {
        final homeBloc = context.read<HomeBloc>();
        homeBloc.add(RefleshNewsEvent());
      },
    );
  }
}
