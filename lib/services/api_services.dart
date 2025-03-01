import "dart:convert";
import "dart:developer";

import "package:netflix_clone/models/movie_detail_model.dart";
import "package:netflix_clone/models/movie_model.dart";
import "package:http/http.dart" as http;
import "package:netflix_clone/models/movie_trailer_model.dart";
import "package:netflix_clone/models/popular_movies_model.dart";
import "package:netflix_clone/models/recommendation_movies_model.dart";
import "package:netflix_clone/models/search_movie_model.dart";
import "package:netflix_clone/models/upcoming_movies_model.dart";
// import "package:netflix_clone/models/popular_movies_model.dart";
// import "package:netflix_clone/models/upcoming_movies_model.dart";
import "../common/utils.dart";

const baseUrl = "https://api.themoviedb.org/3/";
var key = 'api_key=$apiKey';
late String endPoint;

class ApiServices {
  Future<MoviesModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing?language=en-US&";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get now playing success");
      return MoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load now playing movies");
    }
  }

  Future<PopularMoviesModel> getPopularMovies() async {
    endPoint = "movie/popular?language=en-US&";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get popular movies success");
      return PopularMoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load popular movies");
    }
  }

  Future<UpcomingMoviesModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming?language=en-US&";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get upcoming movies success");
      return UpcomingMoviesModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load upcoming movies");
    }
  }

  Future<MovieRecommendationsModel> getMovieRecommendations(int movieId) async {
    endPoint = "movie/$movieId/recommendations?";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get recommendation movies success");
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load recommendation movies");
    }
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    endPoint = "movie/$movieId?";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get movie detail success");
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load movie detail");
    }
  }

  Future<MovieTrailerModel> getMovieTrailer(int movieId) async {
    endPoint = "movie/$movieId/videos?";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get movie detail success");
      return MovieTrailerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load movie detail");
    }
  }

  Future<SearchMovieModel> getSearchMovie(String movie) async {
    endPoint = "search/movie?query=$movie&";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get search movie success");
      return SearchMovieModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("failed to load search movie");
    }
  }
}
