import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:either_dart/either.dart';

class GetQueryMovieListUseCase
    extends UseCase<List<MovieEntity>, GetQueryMovieListParam> {
  final MovieRepository _movieRepository;

  GetQueryMovieListUseCase(this._movieRepository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(
      GetQueryMovieListParam param) async {
    return await _movieRepository.getQueryMovieList(param.query);
  }
}

class GetQueryMovieListParam {
  final String query;

  GetQueryMovieListParam({required this.query});
}
