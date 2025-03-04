import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/screens/movie_details_screen.dart';
import 'package:netflix_clone/services/api_services.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<MoviesModel> downloads;
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    downloads = apiServices.getNowPlayingMovies(); // Fetch movies
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Row(
              children: [],
            ),
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
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      var movie = movies[index];
                      return ListTile(
                        leading: Image.network(
                          "$imageUrl${movie.posterPath}",
                          width: 120,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        title: Text(movie.title,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(movie.overview,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70)),
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
    );
  }
}
