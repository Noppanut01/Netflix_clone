import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/widgets/coming_soon_movie_widget.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/models/upcoming_movies_model.dart';
import 'package:netflix_clone/widgets/everyone_watching_movie_widget.dart';
import '../models/popular_movies_model.dart';
import '../widgets/dynamic_appbar_widget.dart';
import 'download_screen.dart';
import 'search_screen.dart';

class NewAndHotScreen extends StatefulWidget {
  const NewAndHotScreen({super.key});

  @override
  State<NewAndHotScreen> createState() => _NewAndHotScreenState();
}

class _NewAndHotScreenState extends State<NewAndHotScreen> {
  late Future<UpcomingMoviesModel> upcomingMovies;
  late Future<PopularMoviesModel> popularMovies;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upcomingMovies = apiServices.getUpcomingMovies();
    popularMovies = apiServices.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              DynamicAppbarWidget(
                opacity: 0.5,
                appBarHeight: 70,
                title: "New & Hot",
                icon1: Icons.cast,
                icon2: Icons.download,
                icon3: CupertinoIcons.search,
                onTap1: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        child: DownloadScreen(),
                      ),
                    ),
                  );
                },
                onTap2: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                        ),
                        child: SearchScreen(),
                      ),
                    ),
                  );
                },
              ),
              TabBar(
                dividerColor: Colors.transparent,
                isScrollable: false,
                indicatorColor: Colors.white,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
                tabs: [
                  Tab(
                    text: "   🍿 Coming Soon    ",
                  ),
                  Tab(
                    text: "   🔥 Everyone's Watching    ",
                  ),
                ],
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<UpcomingMoviesModel>(
                      future: upcomingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.results.isEmpty) {
                          return const Center(
                              child: Text('No upcoming movies found'));
                        }

                        final movies = snapshot.data!.results;
                        return SingleChildScrollView(
                          child: Column(
                            children: movies.map((movie) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ComingSoonMovieWidget(
                                  imageUrl: "$imageUrl${movie.posterPath}",
                                  overview: movie.overview,
                                  logoUrl: "$imageUrl${movie.backdropPath}",
                                  month: DateFormat('MMM')
                                      .format(movie.releaseDate),
                                  day: movie.releaseDate.day.toString(),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                    FutureBuilder<PopularMoviesModel>(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.results.isEmpty) {
                          return const Center(
                              child: Text('No popular movies found'));
                        }

                        final popularMovies = snapshot.data!.results;
                        return SingleChildScrollView(
                          child: Column(
                            children: popularMovies.map((movie) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: EveryoneWatchingMovieWidget(
                                  imageUrl: "$imageUrl${movie.posterPath}",
                                  overview: movie.overview,
                                  logoUrl: "$imageUrl${movie.backdropPath}",
                                  movieId: movie.id,
                                  movieTitle: movie.title,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
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
