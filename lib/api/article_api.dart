// article_service.dart
import 'package:dio/dio.dart';
import 'package:mulabbi/models/article_model.dart';

class ArticleService {
  static final Dio _dio = Dio();
  static const String _baseUrl =
      'https://682c6814d29df7a95be6eabb.mockapi.io/api/contents';

  static Future<ArticleModel?> fetchArticleById(String id) async {
    try {
      final response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        final result = data.firstWhere(
          (e) => e['_id'] == id,
          orElse: () => null,
        );
        return result != null ? ArticleModel.fromJson(result) : null;
      } else {
        throw Exception("فشل في جلب البيانات");
      }
    } catch (e) {
      print("خطأ في fetchArticleById: $e");
      return null;
    }
  }

  static Future<List<ArticleModel>> fetchAllArticles() async {
    try {
      final response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((e) => ArticleModel.fromJson(e)).toList();
      } else {
        throw Exception("فشل في جلب البيانات");
      }
    } catch (e) {
      print("خطأ في fetchAllArticles: $e");
      return [];
    }
  }

  static Future<ArticleModel?> fetchArticleByTitle(String title) async {
    try {
      final articles = await fetchAllArticles();
      final article = articles.firstWhere(
        (element) => element.title == title,
        orElse: () => ArticleModel(title: 'غير موجود'),
      );
      return article.title == 'غير موجود' ? null : article;
    } catch (e) {
      print("خطأ في fetchArticleByTitle: $e");
      return null;
    }
  }
}
