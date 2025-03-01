// import 'dart:convert';

// class SearchMovieModel {
//   int page;
//   List<Result> results;
//   int totalPages;
//   int totalResults;

//   SearchMovieModel({
//     required this.page,
//     required this.results,
//     required this.totalPages,
//     required this.totalResults,
//   });

//   SearchMovieModel copyWith({
//     int? page,
//     List<Result>? results,
//     int? totalPages,
//     int? totalResults,
//   }) =>
//       SearchMovieModel(
//         page: page ?? this.page,
//         results: results ?? this.results,
//         totalPages: totalPages ?? this.totalPages,
//         totalResults: totalResults ?? this.totalResults,
//       );

//   factory SearchMovieModel.fromRawJson(String str) =>
//       SearchMovieModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory SearchMovieModel.fromJson(Map<String, dynamic> json) =>
//       SearchMovieModel(
//         page: json["page"],
//         results:
//             List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//         totalPages: json["total_pages"],
//         totalResults: json["total_results"],
//       );

//   Map<String, dynamic> toJson() => {
//         "page": page,
//         "results": List<dynamic>.from(results.map((x) => x.toJson())),
//         "total_pages": totalPages,
//         "total_results": totalResults,
//       };
// }

// class Result {
//   bool adult;
//   String? backdropPath;
//   List<int> genreIds;
//   int id;
//   OriginalLanguage originalLanguage;
//   String originalTitle;
//   String overview;
//   double popularity;
//   String? posterPath;
//   String releaseDate;
//   String title;
//   bool video;
//   double voteAverage;
//   int voteCount;

//   Result({
//     required this.adult,
//     required this.backdropPath,
//     required this.genreIds,
//     required this.id,
//     required this.originalLanguage,
//     required this.originalTitle,
//     required this.overview,
//     required this.popularity,
//     required this.posterPath,
//     required this.releaseDate,
//     required this.title,
//     required this.video,
//     required this.voteAverage,
//     required this.voteCount,
//   });

//   Result copyWith({
//     bool? adult,
//     String? backdropPath,
//     List<int>? genreIds,
//     int? id,
//     OriginalLanguage? originalLanguage,
//     String? originalTitle,
//     String? overview,
//     double? popularity,
//     String? posterPath,
//     String? releaseDate,
//     String? title,
//     bool? video,
//     double? voteAverage,
//     int? voteCount,
//   }) =>
//       Result(
//         adult: adult ?? this.adult,
//         backdropPath: backdropPath ?? this.backdropPath,
//         genreIds: genreIds ?? this.genreIds,
//         id: id ?? this.id,
//         originalLanguage: originalLanguage ?? this.originalLanguage,
//         originalTitle: originalTitle ?? this.originalTitle,
//         overview: overview ?? this.overview,
//         popularity: popularity ?? this.popularity,
//         posterPath: posterPath ?? this.posterPath,
//         releaseDate: releaseDate ?? this.releaseDate,
//         title: title ?? this.title,
//         video: video ?? this.video,
//         voteAverage: voteAverage ?? this.voteAverage,
//         voteCount: voteCount ?? this.voteCount,
//       );

//   factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         adult: json["adult"],
//         backdropPath: json["backdrop_path"],
//         genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
//         id: json["id"],
//         originalLanguage:
//             originalLanguageValues.map[json["original_language"]]!,
//         originalTitle: json["original_title"],
//         overview: json["overview"],
//         popularity: json["popularity"]?.toDouble(),
//         posterPath: json["poster_path"],
//         releaseDate: json["release_date"],
//         title: json["title"],
//         video: json["video"],
//         voteAverage: json["vote_average"]?.toDouble(),
//         voteCount: json["vote_count"],
//       );

//   Map<String, dynamic> toJson() => {
//         "adult": adult,
//         "backdrop_path": backdropPath,
//         "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
//         "id": id,
//         "original_language": originalLanguageValues.reverse[originalLanguage],
//         "original_title": originalTitle,
//         "overview": overview,
//         "popularity": popularity,
//         "poster_path": posterPath,
//         "release_date": releaseDate,
//         "title": title,
//         "video": video,
//         "vote_average": voteAverage,
//         "vote_count": voteCount,
//       };
// }

// enum OriginalLanguage { EN, FR, JA }

// final originalLanguageValues = EnumValues({
//   "en": OriginalLanguage.EN,
//   "fr": OriginalLanguage.FR,
//   "ja": OriginalLanguage.JA
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

import 'dart:convert';

class SearchMovieModel {
  int page;
  List<Result> results;
  int totalPages;
  int totalResults;

  SearchMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  SearchMovieModel copyWith({
    int? page,
    List<Result>? results,
    int? totalPages,
    int? totalResults,
  }) =>
      SearchMovieModel(
        page: page ?? this.page,
        results: results ?? this.results,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory SearchMovieModel.fromRawJson(String str) =>
      SearchMovieModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) =>
      SearchMovieModel(
        page: json["page"] ?? 1,
        results: json["results"] != null
            ? List<Result>.from(json["results"].map((x) => Result.fromJson(x)))
            : [],
        totalPages: json["total_pages"] ?? 0,
        totalResults: json["total_results"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Result {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage? originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  String? releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  Result({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Result copyWith({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    OriginalLanguage? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) =>
      Result(
        adult: adult ?? this.adult,
        backdropPath: backdropPath ?? this.backdropPath,
        genreIds: genreIds ?? this.genreIds,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        overview: overview ?? this.overview,
        popularity: popularity ?? this.popularity,
        posterPath: posterPath ?? this.posterPath,
        releaseDate: releaseDate ?? this.releaseDate,
        title: title ?? this.title,
        video: video ?? this.video,
        voteAverage: voteAverage ?? this.voteAverage,
        voteCount: voteCount ?? this.voteCount,
      );

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"] ?? false,
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"].map((x) => x))
            : [],
        id: json["id"] ?? 0,
        originalLanguage: json["original_language"] != null
            ? _parseOriginalLanguage(json["original_language"])
            : null,
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        popularity: (json["popularity"] ?? 0).toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"] ?? "",
        video: json["video"] ?? false,
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
        voteCount: json["vote_count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage != null
            ? originalLanguageValues.reverse[originalLanguage]
            : null,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

// Helper function to safely parse original language
OriginalLanguage? _parseOriginalLanguage(String? languageStr) {
  if (languageStr == null) return null;
  return originalLanguageValues.map[languageStr];
}

enum OriginalLanguage { EN, FR, JA }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "fr": OriginalLanguage.FR,
  "ja": OriginalLanguage.JA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
