import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/core/services/isar_database_service.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:news_app/features/home/models/news_model.dart';
import 'package:news_app/features/utils/app_texts.dart';
import 'package:news_app/features/utils/constants.dart';

class NewsRepositories {
  final IsarDatabaseService databaseService = IsarDatabaseService();
  Future fetchNews({String? country, String? category}) async {
    final String apiKey = Constants.key;
    final String type =
        country == null ? "category=$category" : "country=$country";
    final String url =
        'https://newsapi.org/v2/top-headlines?$type&apiKey=$apiKey';

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

  Future<List<Article>> setAndGetNews(String? country, String? category) async {
    final String filterBy = country ?? category ?? AppTexts.defaultFilter;
    List<Article> news =
        await databaseService.getAllArticles(getCategory: filterBy);
    if (news.isEmpty) {
      news = await fetchNews(
        category: category,
        country: country,
      );
      await databaseService.saveArticles(
        articles: news,
        category: filterBy,
      );
    }
    return news;
  }
}
