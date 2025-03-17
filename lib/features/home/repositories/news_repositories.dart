import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/features/home/models/news_model.dart';
import 'package:news_app/features/utils/constants.dart';

class NewsRepositories {
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
}
