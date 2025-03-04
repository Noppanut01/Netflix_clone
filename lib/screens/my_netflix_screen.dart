// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:netflix_clone/screens/more_setting_screen.dart';
// import 'package:netflix_clone/widgets/dynamic_appbar_widget.dart';
// import 'search_screen.dart';

// class MyNetflixScreen extends StatelessWidget {
//   const MyNetflixScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             DynamicAppbarWidget(
//               opacity: 1,
//               appBarHeight: 70,
//               title: "My Netflix",
//               icon1: Icons.cast,
//               icon2: CupertinoIcons.search,
//               icon3: CupertinoIcons.bars,
//               onTap1: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => DefaultTextStyle(
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.normal,
//                         decoration: TextDecoration.none,
//                       ),
//                       child: SearchScreen(),
//                     ),
//                   ),
//                 );
//               },
//               onTap2: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   backgroundColor: Color(0xFF2B2B2B),
//                   barrierColor: Colors.transparent,
//                   builder: (context) => MoreSettingScreen(),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/screens/download_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:netflix_clone/screens/more_setting_screen.dart';
import 'package:netflix_clone/screens/choose_icon_screen.dart';
import 'package:netflix_clone/widgets/dynamic_appbar_widget.dart';

import '../models/movie_model.dart';
import '../services/api_services.dart';
import 'movie_details_screen.dart';
import 'notification_screen.dart';

class MyNetflixScreen extends StatefulWidget {
  const MyNetflixScreen({super.key});

  @override
  State<MyNetflixScreen> createState() => _MyNetflixScreenState();
}

class _MyNetflixScreenState extends State<MyNetflixScreen> {
  String? selectedIcon;
  late Future<MoviesModel> downloads;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    downloads = apiServices.getNowPlayingMovies(); // Fetch movies
    _loadSelectedIcon();
  }

  // Load selected icon from SharedPreferences
  Future<void> _loadSelectedIcon() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIcon = prefs.getString('selectedIcon');
    });
  }

  // Callback to update UI when icon is selected
  void _updateSelectedIcon(String newIcon) {
    setState(() {
      selectedIcon = newIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DynamicAppbarWidget(
              opacity: 1,
              appBarHeight: 70,
              title: "My Netflix",
              icon1: Icons.cast,
              icon2: CupertinoIcons.search,
              icon3: CupertinoIcons.bars,
              onTap1: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF2B2B2B),
                  barrierColor: Colors.transparent,
                  builder: (context) => ChooseIconScreen(
                    onIconSelected:
                        _updateSelectedIcon, // Update icon dynamically
                  ),
                );
              },
              onTap2: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xFF2B2B2B),
                  barrierColor: Colors.transparent,
                  builder: (context) => const MoreSettingScreen(),
                );
              },
            ),
            const SizedBox(height: 20),
            // Display the selected profile icon in a square style
            if (selectedIcon != null)
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(selectedIcon!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Text(
                "No Icon Selected",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ojang",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(CupertinoIcons.bell_solid, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Notifications",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<MoviesModel>(
                future: downloads,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white)),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data!.results.isEmpty) {
                    return const Center(
                      child: Text('No downloads available',
                          style: TextStyle(color: Colors.white)),
                    );
                  } else {
                    var movies = snapshot.data!.results;
                    return ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        var movie = movies[index];
                        return ListTile(
                          leading: Image.network(
                            "$imageUrl${movie.posterPath}",
                            width: 100,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          title: Text(movie.title,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(movie.overview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70)),
                          // trailing: const Icon(Icons.arrow_forward_ios,
                          //     color: Colors.white),
                          onTap: () {
                            // Navigate to MovieDetailScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsScreen(movieId: movie.id),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DownloadScreen()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.download, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Downloads",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<MoviesModel>(
                future: downloads,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.white)),
                    );
                  } else if (!snapshot.hasData ||
                      snapshot.data!.results.isEmpty) {
                    return const Center(
                      child: Text('No downloads available',
                          style: TextStyle(color: Colors.white)),
                    );
                  } else {
                    var movies = snapshot.data!.results;
                    return ListView.builder(
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        var movie = movies[index];
                        return ListTile(
                          leading: Image.network(
                            "$imageUrl${movie.posterPath}",
                            width: 100,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          title: Text(movie.title,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(movie.overview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70)),
                          // trailing: const Icon(Icons.arrow_forward_ios,
                          //     color: Colors.white),
                          onTap: () {
                            // Navigate to MovieDetailScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailsScreen(movieId: movie.id),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
