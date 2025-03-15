import 'package:news_app/features/home/models/article_model.dart';

class NewsModel {
  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: (json['articles'] as List?)
          ?.map((article) => Article.fromJson(article))
          .toList(),
    );
  }
  final String? status;
  final int? totalResults;
  final List<Article>? articles;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles?.map((article) => article.toJson()).toList(),
    };
  }
}

class Source {
  Source({this.id, this.name});
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'],
      name: json['name'],
    );
  }
  final String? id;
  final String? name;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
