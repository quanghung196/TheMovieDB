import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String posterPath;
  final int id;
  final String backdropPath;
  final String title;
  final num? voteAverage;
  final String releaseDate;
  final String overview;

  const MovieEntity({
    required this.posterPath,
    required this.id,
    required this.backdropPath,
    required this.title,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
  });

  String loadMoviePosterPath() {
    return ApiConstants.BASE_IMAGE_URL + posterPath;
  }

  String loadMovieBackDropPath() {
    return ApiConstants.BASE_IMAGE_URL + backdropPath;
  }

  @override
  List<Object?> get props => [id, title];

  @override
  bool get stringify => true;
}