import 'dart:io';

import 'package:custom_listview_with_json_data/data/core/tmdb_exception.dart';
import 'package:custom_listview_with_json_data/data/data_sources/movie_local_data_source.dart';
import 'package:custom_listview_with_json_data/data/data_sources/movie_remote_data_source.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/cast_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_account_state_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_detail_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  //local
  @override
  Future<Either<AppError, bool>> checkIfMovieInFavouriteList(
      int movieID) async {
    try {
      final response =
          await localDataSource.checkIfMovieInFavouriteList(movieID);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.DATABASE));
    }
  }

  @override
  Future<Either<AppError, void>> deleteMovieFromFavouriteList(
      int movieID) async {
    try {
      final response =
          await localDataSource.deleteMovieFromFavouriteList(movieID);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.DATABASE));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavouriteMovieFromDB() async {
    try {
      final response = await localDataSource.getFavouriteMovieFromDB();
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.DATABASE));
    }
  }

  @override
  Future<Either<AppError, void>> saveMovieToFavouriteList(
      MovieEntity movieEntity) async {
    try {
      final response =
          await localDataSource.saveMovieToFavouriteList(movieEntity);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.DATABASE));
    }
  }

  //remote
  @override
  Future<Either<AppError, List<MovieEntity>>> getTrendingMovie() async {
    try {
      final moviesList = await remoteDataSource.getTrendingMovie();
      return Right(moviesList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getUpcomingMovie(int page) async {
    try {
      final moviesList = await remoteDataSource.getUpcomingMovieMovie(page);
      return Right(moviesList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPlayingNowMovie(
      int page) async {
    try {
      final moviesList = await remoteDataSource.getPlayingNowMovie(page);
      return Right(moviesList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopularMovie(int page) async {
    try {
      final moviesList = await remoteDataSource.getPopularMovie(page);
      return Right(moviesList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(
      int movieID) async {
    try {
      final movie = await remoteDataSource.getMovieDetail(movieID);
      return Right(movie.toEntity());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<CastEntity>>> getMovieCastList(
      int movieID) async {
    try {
      final castList = await remoteDataSource.getMovieCastList(movieID);
      return Right(castList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<VideoEntity>>> getMovieVideoList(
      int movieID) async {
    try {
      final videoList = await remoteDataSource.getMovieVideoList(movieID);
      return Right(videoList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getQueryMovieList(
      String query, int page) async {
    try {
      final moviesList = await remoteDataSource.getQueryMovieList(query, page);
      return Right(moviesList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getFavouriteMovie(
      int page) async {
    try {
      final moviesList = await remoteDataSource.getFavouriteMovie(page);
      return Right(moviesList.map((e) => e.toEntity()).toList());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, MovieAccountStateEntity>> getMovieAccountState(
      int movieID) async {
    try {
      final movieAccountState =
          await remoteDataSource.getMovieAccountState(movieID);
      return Right(movieAccountState.toEntity());
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, void>> postMovieFavouriteStatus(
      bool isFavourite, int movieID) async {
    try {
      await remoteDataSource.postMovieFavouriteStatus(isFavourite, movieID);
      return const Right(Unit);
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.UNAUTHORISE));
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }
}
