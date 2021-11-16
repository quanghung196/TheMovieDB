import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class CheckIfMovieInFavouriteListInDBUseCase extends UseCase<bool, CheckIfMovieInFavouriteListInDBParam> {
  final MovieRepository _movieRepository;

  CheckIfMovieInFavouriteListInDBUseCase(this._movieRepository);

  @override
  Future<Either<AppError, bool>> call(CheckIfMovieInFavouriteListInDBParam params) async {
    return await _movieRepository.checkIfMovieInFavouriteList(params.movieID);
  }
}

class CheckIfMovieInFavouriteListInDBParam{
  final int movieID;

  CheckIfMovieInFavouriteListInDBParam({required this.movieID});
}
