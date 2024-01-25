import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
            useMaterial3: true),
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
    final selectedNews = newsProvider.newsList;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Today's News"),
                        Text(DateFormat("EEE, dd MMMM yyyy")
                            .format(DateTime.now())),
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
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Latest News",
                    ),
                  ),
                  SizedBox(
                    height: 300,
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
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 370,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${items[index].imgUrl}'),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 370,
                                      child: Text(
                                        "${items[index].title}",
                                        maxLines: 2,
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
              Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Text("Hot News"),
                      ),
                      Text("View All"),
                    ],
                  ),
                  SizedBox(
                    height: 550,
                    child: FutureBuilder(
                      future: API().GetNewsList(),
                      builder: (context, data) {
                        if (data.hasError) {
                          return Text("${data.error}");
                        } else if (data.hasData) {
                          var items = data.data as List<NewsModels>;
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  "${items[index].title}",
                                  maxLines: 2,
                                ),
                                subtitle: Text(
                                  "${items[index].description}",
                                  maxLines: 2,
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
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
