import 'package:custom_listview_with_json_data/common/extensions/num_extensions.dart';
import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';

class MovieDetailEntity {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final num voteAverage;
  final String releaseDate;
  final List<GenresEntity> genres;

  const MovieDetailEntity({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.genres,
    required this.voteAverage,
    required this.releaseDate,
  });

  MovieEntity toMovieEntity() {
    return MovieEntity(
        id: id,
        title: title,
        posterPath: posterPath,
        backdropPath: backdropPath,
        overview: overview,
        genreIds: getMovieGenresID(),
        voteAverage: voteAverage,
        releaseDate: releaseDate);
  }

  List<int> getMovieGenresID() {
    List<int> genresID = [];
    for (var genre in genres) {
      genresID.add(genre.id);
    }
    return genresID;
  }

  String movieVoteAverage() {
    if (voteAverage == 0) {
      return 'NR';
    }
    return voteAverage.convertToPercentageString();
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
}

class GenresEntity {
  final int id;
  final String name;

  GenresEntity({required this.id, required this.name});
}
