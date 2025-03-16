import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/bloc/home_bloc.dart';
import 'package:news_app/features/routes/app_routes.dart';
import 'package:news_app/features/splash/splash_page.dart';
import 'package:news_app/features/utils/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        primaryColor: AppColors.white,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: SplashPage(),
      ),
    );
  }
}
