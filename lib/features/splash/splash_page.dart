import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/routes/name_routes.dart';
import 'package:news_app/features/splash/bloc/splash_bloc.dart';
import 'package:news_app/features/utils/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    context.read<SplashBloc>().add(CheckAuthStatusEvent());
    context.read<HomeBloc>().add(GetNewsEvent(countryName: 'us'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is Registered) {
          Navigator.pushReplacementNamed(context, NameRoutes.home);
        } else if (state is UnRegistered) {
          Navigator.pushReplacementNamed(context, NameRoutes.signIn);
        }
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(
            AppImages.splash.image,
            height: 200,
          ),
        ),
      ),
    );
  }
}
