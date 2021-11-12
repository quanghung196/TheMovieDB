import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/cast_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:either_dart/either.dart';

class GetMovieCastListUseCase
    extends UseCase<List<CastEntity>, GetMovieCastListParam> {
  final MovieRepository _movieRepository;

  GetMovieCastListUseCase(this._movieRepository);

  @override
  Future<Either<AppError, List<CastEntity>>> call(
      GetMovieCastListParam params) async {
    return await _movieRepository.getMovieCastList(params.movieID);
  }
}

class GetMovieCastListParam {
  final int movieID;

  GetMovieCastListParam({required this.movieID});
}
