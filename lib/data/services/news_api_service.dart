import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/data/services/news_api_exception.dart';

import '../models/article.dart';

class NewsApiService {
  final http.Client _client;

  NewsApiService({http.Client? client}) : _client = client ?? http.Client();

  // Mengambil berita terbaru.
  Future<List<Article>> fetchArticles({String? search, int offset = 0}) async {
    return _get('/articles/', {
      if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      'limit': '${ApiConstants.pageSize}',
      'offset': '$offset',
      'ordering': '-published_at',
    });
  }

  // Mencari berita berdasarkan keyword.
  Future<List<Article>> searchArticles(String query) async {
    if (query.trim().isEmpty) return [];

    return _get('/articles/', {
      'search': query.trim(),
      'limit': '${ApiConstants.pageSize}',
      'ordering': '-published_at',
    });
  }

  Future<List<Article>> _get(String path, Map<String, String> params) async {
    final uri = Uri.parse('${ApiConstants.baseUrl}$path')
        .replace(queryParameters: params);

    try {
      final response = await _client.get(uri).timeout(ApiConstants.timeout);

      if (response.statusCode != 200) {
        debugPrint('[SNAPI] HTTP ${response.statusCode}: ${response.body}');
        throw _formStatusCode(response.statusCode);
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      final articles = body['results'] as List<dynamic>? ?? [];

      return articles
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          .where((article) => article.isValid)
          .toSet()
          .toList();
    } on NewsApiException {
      rethrow;
    } on SocketException {
      throw NewsApiException.offline;
    } on http.ClientException {
      throw NewsApiException.offline;
    } on TimeoutException {
      throw NewsApiException.slowConnection;
    } catch (error) {
      debugPrint('[SNAPI] Unexpected error: $error');
      throw NewsApiException.unknown;
    }
  }

  NewsApiException _formStatusCode(int code) => switch (code) {
    429 => NewsApiException.tooManyRequests,
    >= 500 => NewsApiException.serverBusy,
    _ => NewsApiException.unknown,
  };

  void dispose() {
    _client.close();
  }
}
