import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/core/database/remote/api_constants.dart';
import 'package:news_app/features/home_screen/data/models/NewsResponse.dart';
import 'package:news_app/features/home_screen/data/models/SourceResponse.dart';

class ApiManager {
  static Future<SourceResponse?> getSources(String categoryId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourcesEndPoint, {
      'apiKey': ApiConstants.apiKey,
      'category': categoryId,
    });
    http.Response response = await http.get(url);
    try {
      Map json = jsonDecode(response.body) as Map;
      return SourceResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse?> getNewsBySourceId(
      {String? sourceId, int? page, int? pageSize}) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsEndPoint, {
      'apiKey': ApiConstants.apiKey,
      'sources': sourceId,
      'pageSize': pageSize.toString(),
      'page': page.toString()
    });

    http.Response response = await http.get(url);
    try {
      Map json = jsonDecode(response.body) as Map;
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse?> getNewsSearchBySourceId(String query) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsEndPoint,
        {'apiKey': ApiConstants.apiKey, 'q': query});

    http.Response response = await http.get(url);
    try {
      Map json = jsonDecode(response.body) as Map;
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
