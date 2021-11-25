import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 1)
class MovieEntity extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String posterPath;
  @HiveField(3)
  final String backdropPath;
  @HiveField(4)
  final String overview;
  @HiveField(5)
  final num voteAverage;
  @HiveField(6)
  final String releaseDate;
  @HiveField(7)
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

  String movieVoteAverage() {
    if (voteAverage == 0) {
      return 'NR';
    }
    return voteAverage.toString();
  }

  String getMovieCategory() {
    String movieCategory = '';
    for (int category in genreIds) {
      movieCategory = movieCategory + ', ' + (movieCategoryMap[category] ?? '');
    }
    return movieCategory.isNotEmpty
        ? movieCategory.substring(2, movieCategory.length)
        : '';
  }

  String loadMoviePosterPath() {
    return ApiConstants.BASE_IMAGE_URL + posterPath;
  }

  String loadMovieBackDropPath() {
    return ApiConstants.BASE_IMAGE_URL + backdropPath;
  }

  String getYearOfMovie() {
    return releaseDate.isNotEmpty ? releaseDate.substring(0, 4) : '';
  }

  @override
  List<Object?> get props => [id, title];

  @override
  bool get stringify => true;
}
