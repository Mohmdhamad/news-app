import 'package:flutter/material.dart';
import 'package:news_app/features/home_screen/data/models/Articles.dart';
import 'package:news_app/core/database/remote/api_manger.dart';

class NewsProvider extends ChangeNotifier {
  List<News>? newsList;
  String? errorMessage;
  int page = 1;
  final int pageSize = 10;

  Future<void> getNewsBySourceId(String sourceId) async {
    page = 1;
    newsList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getNewsBySourceId(
          sourceId: sourceId, page: page, pageSize: pageSize);
      if (response?.status == 'error') {
        errorMessage = response!.message;
        newsList = [];
      } else {
        newsList = response!.articles;
      }
    } catch (e) {
      errorMessage = 'Error Loading News List.';
      newsList = [];
    }
    notifyListeners();
  }

  Future<void> loadMoreNews(String sourceId) async {
    page++;
    try {
      var response = await ApiManager.getNewsBySourceId(
          sourceId: sourceId, page: page, pageSize: pageSize);
      if (response?.status == 'ok') {
        newsList?.addAll(response?.articles ?? []);
        notifyListeners();
      }
    } catch (e) {
      print("Failed to load more news: $e");
    }
  }
}
