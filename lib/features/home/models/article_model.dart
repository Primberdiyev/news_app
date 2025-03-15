import 'package:isar/isar.dart';
import 'package:news_app/features/home/models/news_model.dart';

part 'article_model.g.dart';

@collection
class Article {
  Article({
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.sourceId,
    this.source,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final source = Source.fromJson(json['source']);
    return Article(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      sourceId: source.id,
      source: source,
    );
  }
  Id id = Isar.autoIncrement;

  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  final String? sourceId;

  @ignore
  Source? source;

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'source': source?.toJson(),
    };
  }
}
