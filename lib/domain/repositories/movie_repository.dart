import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:either_dart/either.dart';

abstract class MovieRepository {
  Future<Either<AppError, List<MovieEntity>>> getTrendingMovie();
  Future<Either<AppError, List<MovieEntity>>> getPopularMovie();
  Future<Either<AppError, List<MovieEntity>>> getPlayingNowMovie();
  Future<Either<AppError, List<MovieEntity>>> getUpcomingMovie();
  //Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id);
  // Future<Either<AppError, List<CastEntity>>> getCastCrew(int id);
  // Future<Either<AppError, List<VideoEntity>>> getVideos(int id);
  // Future<Either<AppError, List<MovieEntity>>> getSearchedMovies(
  //     String searchTerm);
  // Future<Either<AppError, void>> saveMovie(MovieEntity movieEntity);
  // Future<Either<AppError, List<MovieEntity>>> getFavoriteMovies();
  // Future<Either<AppError, void>> deleteFavoriteMovie(int movieId);
  // Future<Either<AppError, bool>> checkIfMovieFavorite(int movieId);
}