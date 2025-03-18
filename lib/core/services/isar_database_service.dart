import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:news_app/features/home/models/article_model.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabaseService {
  static late final Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [ArticleSchema],
      directory: dir.path,
    );
  }

  Future<void> saveArticles({
    required List<Article> articles,
    required String category,
  }) async {
    List<Article> newArticles = articles.map((e) {
      return e..category = category;
    }).toList();
    await isar.writeTxn(() async {
      await isar.articles.putAll(newArticles);
    });
  }

  Future<List<Article>> getAllArticles({required String getCategory}) async {
    List<Article> news = [];
    news = await isar.articles.filter().categoryEqualTo(getCategory).findAll();
    return news;
  }

  Future<void> clearDatabase() async {
    await isar.writeTxn(() async {
      await isar.articles.clear();
    });
  }

  Future<void> deleteNewsById({required Id id}) async {
    try {
      await isar.writeTxn(() async {
        isar.articles.delete(id);
      });
    } catch (e) {
      log('error during deleting article$e');
    }
  }
}
