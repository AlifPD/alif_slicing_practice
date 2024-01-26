import 'dart:math';

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
      appBar: AppBar(
        title: Text("News"),
      ),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage('${value.selectedNews?.imgUrl}'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                          child: Text(
                            value.selectedNews?.title ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
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
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: Text(value.selectedNews?.content ?? "")),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF0e2045),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://picsum.photos/100/100"),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      value.selectedNews?.author ?? "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Author",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "${Random().nextInt(500)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.chat_bubble_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "${Random().nextInt(500)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
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
