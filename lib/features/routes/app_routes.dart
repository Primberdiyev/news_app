import 'package:flutter/material.dart';
import 'package:news_app/features/auth/ui/sign_in_page.dart';
import 'package:news_app/features/auth/ui/sign_up_page.dart';
import 'package:news_app/features/home/ui/add_article_page.dart';
import 'package:news_app/features/home/ui/home_page.dart';
import 'package:news_app/features/routes/name_routes.dart';
import 'package:news_app/features/splash_page.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NameRoutes.signIn:
      return MaterialPageRoute(builder: (context) => SignInPage());
    case NameRoutes.signUp:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case NameRoutes.home:
      return MaterialPageRoute(builder: (context) => HomePage());
    case NameRoutes.addtArticle:
      return MaterialPageRoute(builder: (context) => AddArticlePage());
  }
  return MaterialPageRoute(builder: (context) => SplashPage());
}
