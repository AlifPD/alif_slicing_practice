import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:slicing_practice/models/news_model.dart';

class API {
  Future<List<NewsModels>> GetNewsList() async {
    final data = await rootBundle.loadString('assets/data/news_list.json');
    final dataDecoded = json.decode(data) as List<dynamic>;

    return dataDecoded.map((e) => NewsModels.fromJson(e)).toList();
  }
}
