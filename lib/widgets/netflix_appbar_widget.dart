import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/download_screen.dart';
import '../screens/cast_screen.dart';
import '../screens/search_screen.dart';
import 'category_widget.dart';

class NetflixAppBar extends StatefulWidget {
  final double opacity;
  final bool showCategories;
  final double appBarHeight;

  const NetflixAppBar({
    super.key,
    required this.opacity,
    required this.showCategories,
    required this.appBarHeight,
  });

  @override
  // ignore: library_private_types_in_public_api
  _NetflixAppBarState createState() => _NetflixAppBarState();
}

class _NetflixAppBarState extends State<NetflixAppBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 100, sigmaY: 100), // Glassmorphism effect
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300), // Smooth animation
          curve: Curves.easeInOut,
          height: widget.appBarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: widget.showCategories
                ? Border(bottom: BorderSide.none)
                : Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      width: 1,
                    ),
                  ),
          ),
          child: Wrap(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    // Top Bar with Title and Icons
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
                              InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Color(0xFF2B2B2B),
                                      barrierColor: Colors.transparent,
                                      builder: (context) => CastScreen(),
                                    );
                                  },
                                  child: Icon(Icons.cast,
                                      color: Colors.white, size: 27)),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DefaultTextStyle(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                          // backgroundColor: Colors.transparent,
                                        ),
                                        child: DownloadScreen(),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.download,
                                    color: Colors.white, size: 27),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DefaultTextStyle(
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                          // backgroundColor: Colors.transparent,
                                        ),
                                        child: SearchScreen(),
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  CupertinoIcons.search,
                                  color: Colors.white,
                                  size: 27,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // 🛠️ FIX: Use AnimatedSize to prevent overflow
                    AnimatedSize(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      child: widget.showCategories
                          ? Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    CategoryWidget(title: "Tv Shows"),
                                    SizedBox(width: 10),
                                    CategoryWidget(title: "Movies"),
                                    SizedBox(width: 10),
                                    CategoryWidget(title: "Categories ▼"),
                                  ],
                                ),
                              ],
                            )
                          : SizedBox(), // Avoid keeping empty space
                    ),
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
