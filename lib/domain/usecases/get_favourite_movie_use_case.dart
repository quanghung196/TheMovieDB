import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class GetFavouriteMovieUseCase
    extends UseCase<List<MovieEntity>, GetFavouriteMovieParam> {
  final MovieRepository _movieRepository;

  GetFavouriteMovieUseCase(this._movieRepository);

  @override
  Future<Either<AppError, List<MovieEntity>>> call(
      GetFavouriteMovieParam params) async {
    return await _movieRepository.getFavouriteMovie(params.page);
  }
}

class GetFavouriteMovieParam {
  final int page;

  GetFavouriteMovieParam({required this.page});
}
