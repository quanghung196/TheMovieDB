import 'dart:io';

import 'package:custom_listview_with_json_data/data/data_sources/tmdb_remote_data_source.dart';
import 'package:custom_listview_with_json_data/data/models/movie_detail.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:either_dart/src/either.dart';

class MovieRepositoryImpl extends MovieRepository {

  final TheMovieDBApi remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<MovieDetail>>> getTrendingMovie() async {
    try {
      final moviesDetail = await remoteDataSource.getTrendingMovie();
      return Right(moviesDetail);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieDetail>>> getUpcomingMovie() async {
    try {
      final moviesDetail = await remoteDataSource.getUpcomingMovieMovie();
      return Right(moviesDetail);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieDetail>>> getPlayingNowMovie() async {
    try {
      final moviesDetail = await remoteDataSource.getPlayingNowMovie();
      return Right(moviesDetail);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }

  @override
  Future<Either<AppError, List<MovieDetail>>> getPopularMovie() async {
    try {
      final moviesDetail = await remoteDataSource.getPopularMovie();
      return Right(moviesDetail);
    } on SocketException {
      return const Left(AppError(AppErrorType.NETWORK));
    } on Exception {
      return const Left(AppError(AppErrorType.API));
    }
  }
}
