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

  Future<void> saveArticles(List<Article> articles) async {
    await isar.writeTxn(() async {
      await isar.articles.putAll(articles);
    });
  }

  Future<List<Article>> getAllArticles() async {
    List<Article> news = [];
    news = await isar.articles.where().findAll();
    return news;
  }

  Future<void> clearDatabase() async {
    await isar.writeTxn(() async {
      await isar.articles.clear();
    });
  }
}
