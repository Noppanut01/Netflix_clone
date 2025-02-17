import 'package:flutter/material.dart';
import '../widgets/banner_widget.dart';
import 'dart:math';
import '../widgets/netflix_appbar_widget.dart'; // Import the new NetflixAppBar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _opacity = 1.0;
  bool _showCategories = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    double offset = _scrollController.offset;

    setState(() {
      // Reduce opacity when scrolling down
      _opacity = max(0, 1 - (offset / 200)); // Smooth fade effect

      // Hide categories when scrolling down
      _showCategories = offset < 150;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background & Content
          Container(
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
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    BannerWidget(),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/9227572/pexels-photo-9227572.jpeg?auto=compress&cs=tinysrgb&w=600",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating Glassmorphism AppBar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NetflixAppBar(
              opacity: _opacity,
              showCategories: _showCategories,
              appBarHeight:
                  _showCategories ? 180 : 120, // Shrinks when scrolling
            ),
          ),
        ],
      ),
    );
  }
}
