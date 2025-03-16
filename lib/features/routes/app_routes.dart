import 'package:flutter/material.dart';
import 'package:news_app/features/auth/ui/sign_in_page.dart';
import 'package:news_app/features/auth/ui/sign_up_page.dart';
import 'package:news_app/features/routes/name_routes.dart';
import 'package:news_app/features/splash/splash_page.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NameRoutes.signIn:
      return MaterialPageRoute(builder: (context) => SignInPage());
    case NameRoutes.signUp:
      return MaterialPageRoute(builder: (context) => SignUpPage());
  }
  return MaterialPageRoute(builder: (context) => SplashPage());
}
