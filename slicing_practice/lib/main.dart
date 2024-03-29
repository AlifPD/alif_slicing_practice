import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:slicing_practice/api/news_list_services.dart';
import 'package:slicing_practice/controller/news_list_provider.dart';
import 'package:slicing_practice/models/news_model.dart';
import 'package:provider/provider.dart';
import 'package:slicing_practice/views/detail_news_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NewsListProvider(),
        )
      ],
      child: MaterialApp(
        title: "Slicing Practice",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(),
        ),
        routes: {
          DetailNewsPageView.routeName: (context) => const DetailNewsPageView(),
        },
        home: const HomeViewUI(),
      ),
    );
  }
}

class HomeViewUI extends StatelessWidget {
  const HomeViewUI({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsListProvider>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Today's News",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            DateFormat("EEE, dd MMMM yyyy")
                                .format(DateTime.now()),
                            style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Stack(
                      alignment: Alignment.topRight,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage('https://picsum.photos/60/60'),
                        ),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 6),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Latest News",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 220, maxHeight: 320),
                      child: FutureBuilder(
                        future: API().GetNewsList(),
                        builder: (context, data) {
                          if (data.hasError) {
                            return Center(
                              child: Text("${data.error}"),
                            );
                          } else if (data.hasData) {
                            var items = data.data as List<NewsModels>;
                            return ListView.builder(
                              padding: const EdgeInsets.all(0),
                              scrollDirection: Axis.horizontal,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    newsProvider.selectNews(items[index]);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DetailNewsPageView(),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        width: 370,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${items[index].imgUrl}'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        width: 370,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${items[index].title}",
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              DateFormat(
                                                      "EEE, dd MMM yyyy | HH:mm:ss")
                                                  .format(DateTime.parse(
                                                      items[index]
                                                              .publishedTime ??
                                                          "")),
                                              style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Hot News",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints(minHeight: 200, maxHeight: 600),
                      child: FutureBuilder(
                        future: API().GetNewsList(),
                        builder: (context, data) {
                          if (data.hasError) {
                            return Text("${data.error}");
                          } else if (data.hasData) {
                            var items = data.data as List<NewsModels>;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // print(items[index].author);
                                    newsProvider.selectNews(items[index]);
                                    Navigator.pushNamed(
                                      context,
                                      DetailNewsPageView.routeName,
                                      arguments:
                                          NewsModels(title: items[index].title),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(
                                      "${items[index].title}",
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      DateFormat("EEE, dd MMMM yyyy | HH:mm:ss")
                                          .format(DateTime.parse(
                                              items[index].publishedTime ??
                                                  "")),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                    leading: Container(
                                      width: 60,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              "${items[index].imgUrl}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
