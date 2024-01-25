import 'package:flutter/material.dart';
import 'package:slicing_practice/controller/news_list_provider.dart';
import 'package:slicing_practice/models/news_model.dart';
import 'package:provider/provider.dart';

class DetailNewsPageView extends StatelessWidget {
  const DetailNewsPageView({super.key});
  static const routeName = '/detail-news';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as NewsModels;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title ?? ""),
      ),
      body: Center(
        child: Consumer<NewsListProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                Text(value.selectedNews?.content ?? ""),
              ],
            );
          },
        ),
      ),
    );
  }
}
