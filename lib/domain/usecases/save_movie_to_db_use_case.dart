import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class SaveMovieToDBUseCase extends UseCase<void, SaveMovieToDBParam> {
  final MovieRepository _movieRepository;

  SaveMovieToDBUseCase(this._movieRepository);

  @override
  Future<Either<AppError, void>> call(SaveMovieToDBParam params) async {
    return await _movieRepository.saveMovieToFavouriteList(params.movieEntity);
  }
}

class SaveMovieToDBParam {
  final MovieEntity movieEntity;

  SaveMovieToDBParam({required this.movieEntity});
}
