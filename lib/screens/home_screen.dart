import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/banner_widget.dart';
import '../widgets/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF383737),
            Color(0xFF262626),
            Color(0xFF1F1F20),
            Colors.transparent
          ],
          stops: [0.0, 0.5, 0.7, 1],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "For Ojang",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 27,
                                ),
                                Icon(
                                  Icons.download,
                                  color: Colors.white,
                                  size: 27,
                                ),
                                Icon(
                                  CupertinoIcons.search,
                                  color: Colors.white,
                                  size: 27,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          CategoryWidget(
                            title: "Tv Shows",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CategoryWidget(
                            title: "Movies",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CategoryWidget(
                            title: "Categories ▼",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              BannerWidget(),
              SizedBox(
                height:
                    250, // Adjust height to match Netflix thumbnail aspect ratio
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10, // Number of items
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 150, // Adjust width based on design
                      margin: const EdgeInsets.only(
                          right: 10), // Space between items
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
