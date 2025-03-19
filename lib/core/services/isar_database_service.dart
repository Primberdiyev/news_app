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
    try {
      List<Article> newArticles = articles.map((e) {
        return e..category = category;
      }).toList();
      await isar.writeTxn(() async {
        await isar.articles.putAll(newArticles);
      });
    } catch (e) {
      log('error on saving articles');
    }
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

  Future<void> editNews({required Article article}) async {
    try {
      await isar.writeTxn(() async {
        final id = article.id;
        final item = await isar.articles.get(id);
        final Article newItem = item?.copyWith(
              title: article.title,
              description: article.description,
              author: article.author,
            ) ??
            article;
        await isar.articles.put(newItem);
      });
    } catch (e) {
      log('error on editing $e');
    }
  }

  Future<void> createArticle(Article article) async {
    await isar.writeTxn(() async {
      await isar.articles.put(article);
    });
  }
}
