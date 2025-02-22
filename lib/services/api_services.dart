import "dart:convert";
import "dart:developer";

import "package:netflix_clone/models/movie_model.dart";
import "package:http/http.dart" as http;
import "package:netflix_clone/models/popular_movies_model.dart";
import "package:netflix_clone/models/upcoming_movies_model.dart";
// import "package:netflix_clone/models/popular_movies_model.dart";
// import "package:netflix_clone/models/upcoming_movies_model.dart";
import "../common/utils.dart";

const baseUrl = "https://api.themoviedb.org/3/";
var key = '&api_key=$apiKey';
late String endPoint;

class ApiServices {
  Future<MoviesModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing?language=en-US";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get now playing success");
      return MoviesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load now playing movies");
  }

  Future<PopularMoviesModel> getPopularMovies() async {
    endPoint = "movie/popular?language=en-US";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get popular movies success");
      return PopularMoviesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load popular movies");
  }

  Future<UpcomingMoviesModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming?language=en-US";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get upcoming movies success");
      return UpcomingMoviesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load upcoming movies");
  }
}
