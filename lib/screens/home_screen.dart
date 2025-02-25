import 'package:flutter/material.dart';
import 'package:netflix_clone/models/popular_movies_model.dart';
import 'package:netflix_clone/models/upcoming_movies_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/movie_card_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie_model.dart';
import '../widgets/banner_widget.dart';
import 'dart:math';
import '../widgets/netflix_appbar_widget.dart';
import 'movie_details_screen.dart'; // Import the new NetflixAppBar

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
  ApiServices apiServices = ApiServices();
  late Future<MoviesModel> nowPlaying;
  late Future<PopularMoviesModel> popularMovies;
  late Future<UpcomingMoviesModel> upcomingMovies;

  int? movieId;
  bool isMovieIdLoaded = false;
  void _loadMovieId() async {
    if (isMovieIdLoaded) return; // Prevent redundant calls
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      movieId = prefs.getInt('movieId');
      isMovieIdLoaded = true; // Mark as loaded
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    nowPlaying = apiServices.getNowPlayingMovies();
    popularMovies = apiServices.getPopularMovies();
    upcomingMovies = apiServices.getUpcomingMovies();
    _loadMovieId();
    super.initState();
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
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black,
                        builder: (context) => MovieDetailsScreen(
                          movieId: movieId!,
                        ),
                      );
                    },
                    child: BannerWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: SizedBox(
                      height: 250,
                      child: MovieCardWidget(
                        future: nowPlaying,
                        headlineText: "Now playing",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: SizedBox(
                      height: 250,
                      child: MovieCardWidget(
                        future: popularMovies,
                        headlineText: "Popular",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: SizedBox(
                      height: 250,
                      child: MovieCardWidget(
                        future: upcomingMovies,
                        headlineText: "Upcoming movie",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // ),
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
