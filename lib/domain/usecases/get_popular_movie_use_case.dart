import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class GetPopularMovieUseCase extends UseCase<List<MovieEntity>, GetMovieParam> {
  final MovieRepository _movieRepository;

  GetPopularMovieUseCase(this._movieRepository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(GetMovieParam params) async {
    return await _movieRepository.getPopularMovie(params.page);
  }
}

class GetMovieParam {
  final int page;

  GetMovieParam({required this.page});
}
