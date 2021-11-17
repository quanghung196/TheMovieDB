import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_account_state_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class GetMovieAccountStateUseCase
    extends UseCase<MovieAccountStateEntity, GetMovieAccountStateParam> {
  final MovieRepository _movieRepository;

  GetMovieAccountStateUseCase(this._movieRepository);

  @override
  Future<Either<AppError, MovieAccountStateEntity>> call(
      GetMovieAccountStateParam params) async {
    return await _movieRepository.getMovieAccountState(params.movieID);
  }
}

class GetMovieAccountStateParam {
  final int movieID;

  GetMovieAccountStateParam({required this.movieID});
}
