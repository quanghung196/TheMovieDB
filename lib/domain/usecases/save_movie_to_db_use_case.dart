import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:either_dart/src/either.dart';

class SaveMovieToDBUseCase extends UseCase<void, MovieEntity> {

  final MovieRepository _movieRepository;


  SaveMovieToDBUseCase(this._movieRepository);

  @override
  Future<Either<AppError, void>> call(MovieEntity params) async {
    return await _movieRepository.saveMovieToFavouriteList(params);
  }
}
