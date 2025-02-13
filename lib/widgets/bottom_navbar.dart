import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/my_netflix_screen.dart';

import '../screens/new_and_hot_screen.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      top: false,
      bottom: true,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.black,
            height: 70,
            child: TabBar(
              dividerColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(Icons.home_filled),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.photo_library_outlined),
                  text: "New & Hot",
                ),
                Tab(
                  icon: Icon(Icons.rectangle_outlined),
                  text: "My Netflix",
                ),
              ],
              indicatorColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xFF999999),
            ),
          ),
          body: TabBarView(children: [
            HomeScreen(),
            NewAndHotScreen(),
            MyNetflixScreen(),
          ]),
        ),
      ),
    );
  }
}
