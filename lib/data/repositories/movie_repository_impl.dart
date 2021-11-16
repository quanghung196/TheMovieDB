import 'dart:io';

import 'package:custom_listview_with_json_data/data/data_sources/movie_local_data_source.dart';
import 'package:custom_listview_with_json_data/data/data_sources/movie_remote_data_source.dart';
import 'package:custom_listview_with_json_data/data/models/movie_cast_and_crew_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_response.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';

import 'package:dartz/dartz.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  //remote
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
  Future<Either<AppError, List<CastModel>>> getMovieCastList(
      int movieID) async {
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
  Future<Either<AppError, List<VideoEntity>>> getMovieVideoList(
      int movieID) async {
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
  Future<Either<AppError, List<MovieEntity>>> getQueryMovieList(
      String query) async {
    try {
      final moviesList = await remoteDataSource.getQueryMovieList(query);
      return Right(moviesList);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  //local
  @override
  Future<Either<AppError, bool>> checkIfMovieInFavouriteList(
      int movieID) async {
    try {
      final response = await localDataSource.checkIfMovieInFavouriteList(movieID);
      return Right(response);
    } on Exception {
      return const Left(AppError(AppErrorType.DATABASE));
    }
  }

  @override
  Future<Either<AppError, void>> deleteMovieFromFavouriteList(
      int movieID) async {
    try {
      final response = await localDataSource.deleteMovieFromFavouriteList(movieID);
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
}
