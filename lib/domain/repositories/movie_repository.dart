import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/cast_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_account_state_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_detail_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  //remote
  Future<Either<AppError, List<MovieEntity>>> getTrendingMovie();

  Future<Either<AppError, List<MovieEntity>>> getPopularMovie(int page);

  Future<Either<AppError, List<MovieEntity>>> getPlayingNowMovie(int page);

  Future<Either<AppError, List<MovieEntity>>> getUpcomingMovie(int page);

  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int movieID);

  Future<Either<AppError, List<CastEntity>>> getMovieCastList(int movieID);

  Future<Either<AppError, List<VideoEntity>>> getMovieVideoList(int movieID);

  Future<Either<AppError, List<MovieEntity>>> getQueryMovieList(String query, int page);

  Future<Either<AppError, List<MovieEntity>>> getFavouriteMovie(int page);

  Future<Either<AppError, MovieAccountStateEntity>> getMovieAccountState(
      int movieID);

  Future<Either<AppError, void>> postMovieFavouriteStatus(
      bool isFavourite, int movieID);

  //local
  Future<Either<AppError, void>> saveMovieToFavouriteList(
      MovieEntity movieEntity);

  Future<Either<AppError, List<MovieEntity>>> getFavouriteMovieFromDB();

  Future<Either<AppError, void>> deleteMovieFromFavouriteList(int movieID);

  Future<Either<AppError, bool>> checkIfMovieInFavouriteList(int movieID);
}
