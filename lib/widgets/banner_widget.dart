import 'dart:math';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/popular_movies_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/utils.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<PopularMoviesModel> popularMovies;
  int? randomIndex;
  bool hasSavedMovieId = false;

  @override
  void initState() {
    super.initState();
    popularMovies = ApiServices().getPopularMovies();
  }

  /// Function to save movie ID in SharedPreferences only once
  Future<void> saveMovieId(int movieId) async {
    if (hasSavedMovieId) return; // Prevent redundant saving

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedMovieId = prefs.getInt('movieId');

    if (savedMovieId != movieId) {
      if (kDebugMode) {
        print("Saving Movie ID: $movieId");
      }
      await prefs.setInt('movieId', movieId);
      hasSavedMovieId = true; // Mark as saved
    }
  }

  @override
  Widget build(BuildContext context) {
    double bannerHeight = MediaQuery.of(context).size.height * 0.66;

    return SizedBox(
      height: bannerHeight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: bannerHeight),
        child: FutureBuilder(
          future: popularMovies,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData || snapshot.data.results == null) {
              return Center(child: CircularProgressIndicator());
            }

            /// Ensure randomIndex is assigned only once
            if (randomIndex == null) {
              randomIndex = Random().nextInt(snapshot.data.results.length);
              int selectedMovieId = snapshot.data.results[randomIndex!].id;
              saveMovieId(selectedMovieId); // Save only once
            }

            return Stack(
              children: [
                /// Blurred Background
                SizedBox(
                  height: bannerHeight,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      height: bannerHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "$imageUrl${snapshot.data.results![randomIndex!].posterPath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                /// Movie Banner & Buttons
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 7,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Stack(
                            alignment: Alignment(0, 0.96),
                            children: [
                              /// Movie Poster
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "$imageUrl${snapshot.data.results![randomIndex!].posterPath}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              /// Action Buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildButton(
                                    Icons.play_arrow_rounded,
                                    "Play",
                                    Colors.white,
                                    Colors.black,
                                  ),
                                  SizedBox(width: 15),
                                  _buildButton(
                                    Icons.check,
                                    "My List",
                                    Color(0xFF2A2A2B),
                                    Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Button Widget
  Widget _buildButton(
      IconData icon, String text, Color bgColor, Color iconColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.37,
      padding: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(icon, size: 30, color: iconColor),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 17,
              color: iconColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
