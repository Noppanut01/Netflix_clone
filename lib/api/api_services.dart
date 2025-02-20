import "dart:convert";
import "dart:developer";

import "package:netflix_clone/models/movie_model.dart";
import "package:http/http.dart" as http;
import "../common/utils.dart";

const baseUrl = "https://api.themoviedb.org/3/";
var key = '?api_key=$apiKey';
late String endPoint;

class ApiServices {
  Future<MovieModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Get now playing success");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("failed to load upcoming movies");
  }
}
