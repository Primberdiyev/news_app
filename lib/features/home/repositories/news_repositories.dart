import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/features/home/dialogs/news_dialog.dart';
import 'package:news_app/features/home/models/news_model.dart';
import 'package:news_app/features/utils/constants.dart';

class NewsRepositories {
  Future fetchNews() async {
    final String apiKey = Constants.key;
    final String url =
        'https://newsapi.org/v2/everything?q=technology&sortBy=publishedAt&apiKey=$apiKey'; // q parametri qo‘shildi

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final allNews = NewsModel.fromJson(data);
        return allNews.articles;
      } else {
        log('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      log('Exception $e');
      return null;
    }
  }

  void showMyDNewDialog({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String description,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return NewsDialog(
          imageLink: imageUrl,
          title: title,
          description: description,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
