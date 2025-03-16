import 'package:flutter/material.dart';
import 'package:news_app/core/services/database_service.dart';
import 'package:news_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().init();
  runApp(MyApp());
}
