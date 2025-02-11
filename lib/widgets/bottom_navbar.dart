import 'package:flutter/material.dart';
import 'package:netflix_clone/screens/home_screen.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: TabBar(
            dividerColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.photo_library_outlined),
                text: "New & Hot",
              ),
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF999999),
          ),
        ),
        body: TabBarView(children: [
          HomeScreen(),
          HomeScreen(),
          HomeScreen(),
        ]),
      ),
    );
  }
}
