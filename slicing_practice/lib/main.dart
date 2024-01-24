import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Slicing Practice",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true),
      home: HomeViewUI(),
    );
  }
}

class HomeViewUI extends StatelessWidget {
  const HomeViewUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(children: [
          Card(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Container(
                width: 300,
                height: 100,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("TODAY'S NEWS"),
                        Text(DateFormat("EE, dd MMMM yyyy")
                            .format(DateTime.now())),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Image(
                            image: NetworkImage('https://picsum.photos/50/50')),
                      ),
                    ),
                  ],
                )),
          ),
          Row(
            children: [
              Text("Latest News"),
            ],
          ),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(),
                items: [
                  Column(
                    children: [
                      Image(
                          image: NetworkImage('https://picsum.photos/300/150')),
                      Text(
                          "Jakarta Flood Caused by 15km-high Rain Clouds: Expert"),
                      Text(
                          "${DateFormat("EE, dd MMMM yyyy").format(DateTime.now())}| 8 Hours ago"),
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                          image: NetworkImage('https://picsum.photos/300/150')),
                      Text(
                          "Jakarta Flood Caused by 15km-high Rain Clouds: Expert"),
                      Text(
                          "${DateFormat("EE, dd MMMM yyyy").format(DateTime.now())}| 8 Hours ago"),
                    ],
                  ),
                  Column(
                    children: [
                      Image(
                          image: NetworkImage('https://picsum.photos/300/150')),
                      Text(
                          "Jakarta Flood Caused by 15km-high Rain Clouds: Expert"),
                      Text(
                          "${DateFormat("EE, dd MMMM yyyy").format(DateTime.now())}| 8 Hours ago"),
                    ],
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
