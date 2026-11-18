import '../models/article.dart';
import '../services/news_api_service.dart';

class NewsRepository {
  NewsRepository(this._apiService);

  final NewsApiService _apiService;

  Future<List<Article>> getTopHeadlines({String? searchQuery}) async {
    return _apiService.fetchArticles(search: searchQuery);
  }

  Future<List<Article>> searchArticles(String query) async {
    return _apiService.fetchArticles(search: query);
  }
}
