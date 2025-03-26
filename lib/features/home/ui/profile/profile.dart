import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/utils/app_images.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    context.read<HomeBloc>().add(GetUserModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String? imageLink = (state is HomeSuccessState)
            ? state.userModel?.imageAssetLink
            : null;
        return Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                context.read<HomeBloc>().add(PickUserImageEvent());
              },
              child: CircleAvatar(
                radius: 80,
                backgroundImage:
                    imageLink != null && File(imageLink).existsSync()
                        ? FileImage(File(imageLink))
                        : AssetImage(
                            AppImages.userDefault.image,
                          ) as ImageProvider,
              ),
            ),
          ],
        );
      },
    );
  }
}
