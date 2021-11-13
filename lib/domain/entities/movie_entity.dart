import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final int id;
  final String backdropPath;
  final String title;
  final num voteAverage;
  final String releaseDate;
  final String overview;
  final List<int> genreIds;

  const MovieEntity({
    required this.posterPath,
    required this.id,
    required this.backdropPath,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.genreIds,
  });

  static const Map<int, String> movieCategoryMap = {
    28: "Action",
    12: "Adventure",
    16: "Animation",
    35: "Comedy",
    80: "Crime",
    99: "Documentary",
    18: "Drama",
    10751: "Family",
    14: "Fantasy",
    36: "History",
    27: "Horror",
    10402: "Music",
    9648: "Mystery",
    10749: "Romance",
    878: "Science Fiction",
    10770: "TV Movie",
    53: "Thriller",
    10752: "War",
    37: "Western"
  };

  String getMovieCategory() {
    String movieCategory = '';
    for (int category in genreIds) {
      movieCategory = movieCategory + ', ' + (movieCategoryMap[category] ?? '');
    }
    return movieCategory.substring(2, movieCategory.length);
  }

  String loadMoviePosterPath() {
    return ApiConstants.BASE_IMAGE_URL + posterPath;
  }

  String loadMovieBackDropPath() {
    return ApiConstants.BASE_IMAGE_URL + backdropPath;
  }

  String getYearOfMovie() {
    return releaseDate.substring(0, 4);
  }

  @override
  List<Object?> get props => [id, title];

  @override
  bool get stringify => true;
}
