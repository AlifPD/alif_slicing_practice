import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slicing_practice/controller/news_list_provider.dart';
import 'package:provider/provider.dart';

class DetailNewsPageView extends StatelessWidget {
  const DetailNewsPageView({super.key});
  static const routeName = '/detail-news';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Consumer<NewsListProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Container(
                      height: 250,
                      padding: EdgeInsets.all(0),
                      child: Image(
                        image: NetworkImage('${value.selectedNews?.imgUrl}'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.selectedNews?.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat("EEE, dd MMMM yyyy | HH:mm:ss").format(
                              DateTime.parse(
                                  value.selectedNews?.publishedTime ?? "")),
                          maxLines: 1,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          value.selectedNews?.description ?? "",
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        Text(value.selectedNews?.content ?? ""),
                      ],
                    ),
                    Card(
                      color: Color(0xFF0e2045),
                      child: Row(
                        children: [
                          Image(
                            image:
                                NetworkImage("https://picsum.photos/100/100"),
                          ),
                          Column(
                            children: [
                              Text(
                                "Author",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(value.selectedNews?.author ?? "",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
