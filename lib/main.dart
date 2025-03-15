import 'package:flutter/material.dart';
import 'package:news_app/features/home/repositories/database.dart';
import 'package:news_app/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Database().init();
  runApp(MyApp());
}
