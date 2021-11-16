import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class DeleteMovieFromDBUseCase extends UseCase<void, DeleteMovieFromDBParam> {
  final MovieRepository _movieRepository;

  DeleteMovieFromDBUseCase(this._movieRepository);

  @override
  Future<Either<AppError, void>> call(DeleteMovieFromDBParam params) async {
    return await _movieRepository.deleteMovieFromFavouriteList(params.movieID);
  }
}

class DeleteMovieFromDBParam {
  final int movieID;

  DeleteMovieFromDBParam({required this.movieID});
}
