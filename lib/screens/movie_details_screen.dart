// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:netflix_clone/common/utils.dart';
// import 'package:netflix_clone/screens/cast_screen.dart';
// import 'package:netflix_clone/widgets/custom_round_icon_button.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import '../models/movie_detail_model.dart';
// import '../models/recommendation_movies_model.dart';
// import '../services/api_services.dart';

// class MovieDetailsScreen extends StatefulWidget {
//   final int movieId;
//   const MovieDetailsScreen({super.key, required this.movieId});

//   @override
//   State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
// }

// class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
//   late Future<MovieDetailModel> movieDetail;
//   late Future<MovieRecommendationsModel> movieRecommendationModel;
//   late Future<String?> movieTrailerKey;
//   YoutubePlayerController? _youtubeController;

//   @override
//   void initState() {
//     super.initState();
//     fetchInitialData();
//   }

//   void fetchInitialData() {
//     final apiServices = ApiServices();
//     movieDetail = apiServices.getMovieDetail(widget.movieId);
//     movieRecommendationModel =
//         apiServices.getMovieRecommendations(widget.movieId);
//     movieTrailerKey =
//         apiServices.getMovieTrailer(widget.movieId).then((trailerModel) {
//       return trailerModel.results.isNotEmpty
//           ? trailerModel.results[0].key
//           : null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Scrollable content below the video
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 70),
//                   FutureBuilder<MovieDetailModel>(
//                     future: movieDetail,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return _buildLoadingIndicator();
//                       } else if (snapshot.hasError ||
//                           !snapshot.hasData ||
//                           snapshot.data == null) {
//                         return _buildErrorMessage(
//                             "Movie details not available");
//                       }

//                       final movieDetails = snapshot.data!;
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                               height:
//                                   240), // Add some space for the video player
//                           Text(
//                             movieDetails.title,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 24,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             movieDetails.overview,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                           SizedBox(height: 20),
//                           Text(
//                             "More like this",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           FutureBuilder<MovieRecommendationsModel>(
//                             future: movieRecommendationModel,
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return _buildLoadingIndicator();
//                               } else if (snapshot.hasError ||
//                                   !snapshot.hasData ||
//                                   snapshot.data!.results.isEmpty) {
//                                 return _buildErrorMessage(
//                                     "No recommendations available");
//                               }

//                               final recommendations = snapshot.data!;
//                               return Padding(
//                                 padding: const EdgeInsets.all(1.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(height: 20),
//                                     GridView.builder(
//                                       physics: BouncingScrollPhysics(),
//                                       padding: EdgeInsets.zero,
//                                       itemCount: recommendations.results.length,
//                                       gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 3,
//                                         mainAxisSpacing: 15,
//                                         childAspectRatio: 1.5 / 2,
//                                       ),
//                                       shrinkWrap: true,
//                                       itemBuilder: (context, index) {
//                                         return ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           child: InkWell(
//                                             onTap: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       MovieDetailsScreen(
//                                                     movieId: recommendations
//                                                         .results[index].id,
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                             child: CachedNetworkImage(
//                                               imageUrl:
//                                                   "$imageUrl${recommendations.results[index].posterPath}",
//                                               placeholder: (context, url) =>
//                                                   _buildLoadingIndicator(),
//                                               errorWidget:
//                                                   (context, url, error) => Icon(
//                                                       Icons.error,
//                                                       color: Colors.white),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Fixed Video Player at the top
//           Positioned(
//             top: 60,
//             left: 0,
//             right: 0,
//             child: FutureBuilder<String?>(
//               future: movieTrailerKey,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return _buildLoadingIndicator(heightFactor: 0.4);
//                 } else if (snapshot.hasError ||
//                     !snapshot.hasData ||
//                     snapshot.data == null) {
//                   return _buildErrorMessage("Trailer not available",
//                       heightFactor: 0.4);
//                 }

//                 _youtubeController = YoutubePlayerController(
//                   initialVideoId: snapshot.data!,
//                   flags: YoutubePlayerFlags(
//                     autoPlay: true,
//                     mute: false,
//                     isLive: false,
//                   ),
//                 );

//                 return YoutubePlayerBuilder(
//                   player: YoutubePlayer(controller: _youtubeController!),
//                   builder: (context, player) {
//                     return Container(
//                       color: Colors.black,
//                       height: 240, // Set fixed height for the video player
//                       child: player,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           // Close Button and Cast Button
//           Positioned(
//             top: 70,
//             right: 10,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CustomRoundIconButton(
//                   icon: Icons.cast,
//                   ontab: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       backgroundColor: Color(0xFF2B2B2B),
//                       builder: (context) => SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.6,
//                         child: CastScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(width: 10),
//                 CustomRoundIconButton(
//                   icon: Icons.close,
//                   ontab: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLoadingIndicator({double heightFactor = 0.2}) {
//     return Container(
//       height: MediaQuery.of(context).size.height * heightFactor,
//       alignment: Alignment.center,
//       child: CircularProgressIndicator(),
//     );
//   }

//   Widget _buildErrorMessage(String message, {double heightFactor = 0.2}) {
//     return Container(
//       height: MediaQuery.of(context).size.height * heightFactor,
//       alignment: Alignment.center,
//       child: Text(
//         message,
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _youtubeController?.dispose();
//     super.dispose();
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/screens/cast_screen.dart';
import 'package:netflix_clone/widgets/custom_round_icon_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/movie_detail_model.dart';
import '../models/recommendation_movies_model.dart';
import '../services/api_services.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Future<MovieDetailModel> movieDetail;
  late Future<MovieRecommendationsModel> movieRecommendationModel;
  late Future<String?> movieTrailerKey;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() {
    final apiServices = ApiServices();
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    movieRecommendationModel =
        apiServices.getMovieRecommendations(widget.movieId);
    movieTrailerKey =
        apiServices.getMovieTrailer(widget.movieId).then((trailerModel) {
      return trailerModel.results.isNotEmpty
          ? trailerModel.results[0].key
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Fixed Video Player at the top
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: FutureBuilder<String?>(
              future: movieTrailerKey,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildLoadingIndicator(heightFactor: 0.4);
                } else if (snapshot.hasError ||
                    !snapshot.hasData ||
                    snapshot.data == null) {
                  return _buildErrorMessage("Trailer not available",
                      heightFactor: 0.4);
                }

                _youtubeController = YoutubePlayerController(
                  initialVideoId: snapshot.data!,
                  flags: YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                    isLive: false,
                  ),
                );

                return YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: _youtubeController!),
                  builder: (context, player) {
                    return Container(
                      color: Colors.black,
                      height: 240, // Set fixed height for the video player
                      child: player,
                    );
                  },
                );
              },
            ),
          ),

          // Scrollable content below the video
          Positioned(
            top:
                300, // Set the top value to 240, so the content starts after the video
            left: 0,
            right: 0,
            bottom: 0, // Allow the content to occupy the remaining space
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<MovieDetailModel>(
                      future: movieDetail,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return _buildLoadingIndicator();
                        } else if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data == null) {
                          return _buildErrorMessage(
                              "Movie details not available");
                        }

                        final movieDetails = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movieDetails.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              movieDetails.overview,
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "More like this",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 20),
                            FutureBuilder<MovieRecommendationsModel>(
                              future: movieRecommendationModel,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return _buildLoadingIndicator();
                                } else if (snapshot.hasError ||
                                    !snapshot.hasData ||
                                    snapshot.data!.results.isEmpty) {
                                  return _buildErrorMessage(
                                      "No recommendations available");
                                }

                                final recommendations = snapshot.data!;
                                return Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20),
                                      GridView.builder(
                                        physics: BouncingScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        itemCount:
                                            recommendations.results.length,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 15,
                                          childAspectRatio: 1.5 / 2,
                                        ),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetailsScreen(
                                                      movieId: recommendations
                                                          .results[index].id,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${recommendations.results[index].posterPath}",
                                                placeholder: (context, url) =>
                                                    _buildLoadingIndicator(),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.error,
                                                        color: Colors.white),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Close Button and Cast Button
          Positioned(
            top: 70,
            right: 10,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomRoundIconButton(
                  icon: Icons.cast,
                  ontab: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Color(0xFF2B2B2B),
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: CastScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(width: 10),
                CustomRoundIconButton(
                  icon: Icons.close,
                  ontab: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator({double heightFactor = 0.2}) {
    return Container(
      height: MediaQuery.of(context).size.height * heightFactor,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorMessage(String message, {double heightFactor = 0.2}) {
    return Container(
      height: MediaQuery.of(context).size.height * heightFactor,
      alignment: Alignment.center,
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }
}
