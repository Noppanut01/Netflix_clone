import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:netflix_clone/models/popular_movies_model.dart';
import 'package:netflix_clone/services/api_services.dart';
import '../common/utils.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<PopularMoviesModel> popularMovies;
  int randomIndex = Random().nextInt(20);

  @override
  void initState() {
    popularMovies = ApiServices().getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.66,
      child: Stack(
        children: [
          FutureBuilder(
            future: popularMovies,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData || snapshot.data.results == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "$imageUrl${snapshot.data.results![randomIndex].posterPath}",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.0,
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 7,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Stack(
                      alignment: Alignment(0, 0.96),
                      children: [
                        FutureBuilder(
                          future: popularMovies,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data.results == null) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "$imageUrl${snapshot.data.results![randomIndex].posterPath}",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
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
      ),
    );
  }

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
