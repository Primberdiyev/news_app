import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_images.dart';

class BuildUserImage extends StatelessWidget {
  const BuildUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String? imageLink = (state is HomeSuccessState)
            ? state.userModel?.imageAssetLink
            : null;
        return GestureDetector(
          onTap: () {
            context.read<HomeBloc>().add(PickUserImageEvent());
          },
          child: CircleAvatar(
            radius: 80,
            backgroundImage: imageLink != null
                ? FileImage(File(imageLink))
                : AssetImage(
                    AppImages.userDefault.image,
                  ) as ImageProvider,
          ),
        );
      },
    );
  }
}
