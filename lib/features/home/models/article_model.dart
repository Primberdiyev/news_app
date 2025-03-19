import 'package:isar/isar.dart';
import 'package:news_app/features/home/models/news_model.dart';

part 'article_model.g.dart';

@collection
class Article {
  Article({
    this.id = Isar.autoIncrement,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.sourceId,
    this.source,
    this.category,
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
  Id id;

  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;
  final String? sourceId;
  final String? category;

  @ignore
  Source? source;

  Article copyWith({
    Id? id,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
    String? sourceId,
    String? category,
  }) {
    return Article(
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      sourceId: sourceId ?? this.sourceId,
      source: source,
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }
}
