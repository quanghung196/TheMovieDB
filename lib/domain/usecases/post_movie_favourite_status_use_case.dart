import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:dartz/dartz.dart';

class PostFavouriteMovieStatusUseCase
    extends UseCase<void, PostFavouriteMovieStatusParam> {
  final MovieRepository _movieRepository;

  PostFavouriteMovieStatusUseCase(this._movieRepository);

  @override
  Future<Either<AppError, void>> call(
      PostFavouriteMovieStatusParam params) async {
    return await _movieRepository.postMovieFavouriteStatus(
        params.isFavourite, params.movieID);
  }
}

class PostFavouriteMovieStatusParam {
  final bool isFavourite;
  final int movieID;

  PostFavouriteMovieStatusParam(
      {required this.isFavourite, required this.movieID});
}
