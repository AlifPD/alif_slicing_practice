import 'package:flutter/material.dart';
import 'package:slicing_practice/api/news_list_services.dart';
import 'package:slicing_practice/models/news_model.dart';

class NewsListProvider extends ChangeNotifier {
  Future<List<NewsModels>> _newsList = API().GetNewsList();

  // List<NewsModels> get newsList {
  //   FutureBuilder(future: API().GetNewsList(), builder: (context, data) {
  //     return data
  //   });
  // }
  List<NewsModels>? get newsList {
    _newsList.then((value) {
      return value;
    });
    return null;
  }

  NewsModels? selectedNews;

  void selectNews(NewsModels data) {
    selectedNews = data;
    notifyListeners();
  }
}
