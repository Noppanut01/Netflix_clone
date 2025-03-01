// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:netflix_clone/common/utils.dart';
// import 'package:netflix_clone/models/popular_movies_model.dart';
// import 'package:netflix_clone/models/search_movie_model.dart';
// import 'package:netflix_clone/screens/full_screen_video_player_screen.dart';
// import 'package:netflix_clone/screens/movie_details_screen.dart';
// import 'package:netflix_clone/services/api_services.dart';
// import 'package:netflix_clone/widgets/custom_round_icon_button.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   ApiServices apiServices = ApiServices();
//   TextEditingController searchController = TextEditingController();
//   SearchMovieModel? searchedMovie;
//   late Future<PopularMoviesModel> popularMovies;

//   void search(String query) {
//     apiServices.getSearchMovie(query).then((results) {
//       setState(() {
//         searchedMovie = results;
//       });
//     });
//   }

//   @override
//   void initState() {
//     popularMovies = apiServices.getPopularMovies();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     searchController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context); // This will pop the current screen
//           },
//         ),
//         title: CupertinoSearchTextField(
//           controller: searchController,
//           padding: const EdgeInsets.all(10.0),
//           prefixIcon: const Icon(
//             CupertinoIcons.search,
//             color: Colors.grey,
//           ),
//           suffixIcon: const Icon(
//             Icons.cancel,
//             color: Colors.grey,
//           ),
//           style: const TextStyle(color: Colors.white),
//           // ignore: deprecated_member_use
//           backgroundColor: Colors.grey.withOpacity(0.3),
//           onChanged: (value) {
//             if (value.isEmpty) {
//               setState(() {
//                 searchedMovie = null;
//               });
//             } else {
//               search(searchController.text);
//             }
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               searchController.text.isEmpty
//                   ? FutureBuilder<PopularMoviesModel>(
//                       future: popularMovies,
//                       builder: (context, snapshot) {
//                         if (snapshot.hasData) {
//                           var data = snapshot.data?.results;
//                           return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 const Text(
//                                   "Top Searches",
//                                   style: TextStyle(fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                 ),
//                                 ListView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   scrollDirection: Axis.vertical,
//                                   itemCount: data!.length,
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   MovieDetailsScreen(
//                                                 movieId: data[index].id,
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                         child: Container(
//                                           height: 100,
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               SizedBox(
//                                                 height: 100,
//                                                 width: 170,
//                                                 child: ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   child: Image.network(
//                                                     '$imageUrl${data[index].backdropPath}',
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 ),
//                                               ),
//                                               const SizedBox(
//                                                 width: 15,
//                                               ),
//                                               Text(
//                                                 data[index].title,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                               CustomRoundIconButton(
//                                                 icon: Icons.play_arrow,
//                                                 ontab: () {
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         FullScreenVideoPlayer(
//                                                       videoId: data[index]
//                                                           .id
//                                                           .toString(),
//                                                     ),
//                                                   );
//                                                 },
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 )
//                               ]);
//                         } else {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         }
//                       },
//                     )
//                   : searchedMovie == null
//                       ? const SizedBox.shrink()
//                       : GridView.builder(
//                           padding: EdgeInsets.zero,
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: searchedMovie?.results.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             mainAxisSpacing: 15,
//                             crossAxisSpacing: 5,
//                             childAspectRatio: 1.2 / 2,
//                           ),
//                           itemBuilder: (context, index) {
//                             return searchedMovie!.results[index].backdropPath ==
//                                     null
//                                 ? Column(
//                                     children: [
//                                       Image.asset(
//                                         "assets/icons/netflix.png",
//                                         height: 170,
//                                       ),
//                                       Text(
//                                         searchedMovie!.results[index].title,
//                                         maxLines: 2,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                         ),
//                                       )
//                                     ],
//                                   )
//                                 : Column(
//                                     children: [
//                                       InkWell(
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   MovieDetailsScreen(
//                                                       movieId: searchedMovie!
//                                                           .results[index].id),
//                                             ),
//                                           );
//                                         },
//                                         child: CachedNetworkImage(
//                                           imageUrl:
//                                               '$imageUrl${searchedMovie?.results[index].backdropPath}',
//                                           height: 170,
//                                         ),
//                                       ),
//                                       Text(
//                                         searchedMovie!.results[index].title,
//                                         maxLines: 2,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                           },
//                         )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/popular_movies_model.dart';
import 'package:netflix_clone/models/search_movie_model.dart';
import 'package:netflix_clone/screens/movie_details_screen.dart';
import 'package:netflix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  SearchMovieModel? searchedMovie;
  late Future<PopularMoviesModel> popularMovies;

  void search(String query) {
    apiServices.getSearchMovie(query).then((results) {
      setState(() {
        searchedMovie = results;
      });
    });
  }

  @override
  void initState() {
    popularMovies = apiServices.getPopularMovies();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // This will pop the current screen
          },
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width *
              0.86, // Set a fixed width for the search box
          child: CupertinoSearchTextField(
            controller: searchController,
            padding: const EdgeInsets.all(10.0),
            prefixIcon: const Icon(
              CupertinoIcons.search,
              color: Colors.grey,
            ),
            suffixIcon: const Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
            style: const TextStyle(color: Colors.white),
            backgroundColor: Colors.grey.withOpacity(0.3),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  searchedMovie = null;
                });
              } else {
                search(searchController.text);
              }
            },
          ),
        ),
        titleSpacing: -10, // Reduce the space between leading and title
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              searchController.text.isEmpty
                  ? FutureBuilder<PopularMoviesModel>(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data?.results;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                "Top Searches",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsScreen(
                                              movieId: data[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: 100,
                                              width: 170,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  '$imageUrl${data[index].backdropPath}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Expanded(
                                              child: Text(
                                                data[index].title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : searchedMovie == null
                      ? const SizedBox.shrink()
                      : GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchedMovie?.results.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.2 / 2,
                          ),
                          itemBuilder: (context, index) {
                            return searchedMovie!.results[index].backdropPath ==
                                    null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icons/netflix.png",
                                        height: 170,
                                      ),
                                      Text(
                                        searchedMovie!.results[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsScreen(
                                                      movieId: searchedMovie!
                                                          .results[index].id),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '$imageUrl${searchedMovie?.results[index].backdropPath}',
                                            height: 170,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        searchedMovie!.results[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        )
            ],
          ),
        ),
      ),
    );
  }
}
