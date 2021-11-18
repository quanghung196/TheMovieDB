import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

import 'get_popular_movie_use_case.dart';

class GetPlayingNowMovieUseCase extends UseCase<List<MovieEntity>, GetMovieParam> {
  final MovieRepository _movieRepository;

  GetPlayingNowMovieUseCase(this._movieRepository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(GetMovieParam params) async {
    return await _movieRepository.getPlayingNowMovie(params.page);
  }
}
