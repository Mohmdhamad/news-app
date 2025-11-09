import 'package:flutter/material.dart';
import 'package:news_app/features/home_screen/data/models/Sources.dart';
import 'package:news_app/core/database/remote/api_manger.dart';

class CategoryProvider extends ChangeNotifier {
  List<Source>? sourcesList;

  String? errorMessage;

  void getSources(String categoryId) async {
    sourcesList = null;
    errorMessage = null;
    notifyListeners();
    try {
      var response = await ApiManager.getSources(
        categoryId,
      );
      if (response?.status == 'error') {
        errorMessage = response!.message;
      } else {
        sourcesList = response!.sources;
      }
    } catch (e) {
      errorMessage = 'Error Loading Source List';
    }
    notifyListeners();
  }
}
