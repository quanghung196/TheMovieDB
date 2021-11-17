import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_detail_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class GetMovieDetailUseCase
    extends UseCase<MovieDetailEntity, GetMovieDetailParams> {
  final MovieRepository _movieRepository;

  GetMovieDetailUseCase(this._movieRepository);

  @override
  Future<Either<AppError, MovieDetailEntity>> call(
      GetMovieDetailParams params) async {
    return await _movieRepository.getMovieDetail(params.movieID);
  }
}

class GetMovieDetailParams {
  final int movieID;

  const GetMovieDetailParams({required this.movieID});
}
