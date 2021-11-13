import 'dart:io';

import 'package:custom_listview_with_json_data/data/data_sources/tmdb_remote_data_source.dart';
import 'package:custom_listview_with_json_data/data/models/movie_cast_and_crew_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_response.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:either_dart/src/either.dart';

class MovieRepositoryImpl extends MovieRepository {

  final TheMovieDBApi remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<MovieModel>>> getTrendingMovie() async {
    try {
      final moviesList = await remoteDataSource.getTrendingMovie();
      return Right(moviesList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getUpcomingMovie() async {
    try {
      final moviesList = await remoteDataSource.getUpcomingMovieMovie();
      return Right(moviesList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPlayingNowMovie() async {
    try {
      final moviesList = await remoteDataSource.getPlayingNowMovie();
      return Right(moviesList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieModel>>> getPopularMovie() async {
    try {
      final moviesList = await remoteDataSource.getPopularMovie();
      return Right(moviesList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<CastModel>>> getMovieCastList(int movieID) async {
    try {
      final castList = await remoteDataSource.getMovieCastList(movieID);
      return Right(castList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<VideoEntity>>> getMovieVideoList(int movieID) async {
    try {
      final videoList = await remoteDataSource.getMovieVideoList(movieID);
      return Right(videoList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getQueryMovieList(String query) async {
    try {
      final moviesList = await remoteDataSource.getQueryMovieList(query);
      return Right(moviesList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }
}
