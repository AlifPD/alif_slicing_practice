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
        title: const Text("News"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Consumer<NewsListProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Container(
                      height: 250,
                      padding: const EdgeInsets.all(0),
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
                          margin: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                          child: Text(
                            value.selectedNews?.title ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            DateFormat("EEE, dd MMMM yyyy | HH:mm:ss").format(
                                DateTime.parse(
                                    value.selectedNews?.publishedTime ?? "")),
                            maxLines: 1,
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Text(
                            value.selectedNews?.content ?? "",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF0e2045),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: const Image(
                                fit: BoxFit.fill,
                                image:
                                    NetworkImage("https://picsum.photos/60/60"),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "Author",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        value.selectedNews?.author ?? "",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "${Random().nextInt(500)}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.chat_bubble_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "${Random().nextInt(500)}",
                                        style: const TextStyle(
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
