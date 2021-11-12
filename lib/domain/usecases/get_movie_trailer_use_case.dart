import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/tmdb_base_use_case.dart';
import 'package:either_dart/either.dart';

class GetMovieTrailerUseCase
    extends UseCase<List<VideoEntity>, GetMovieTrailerListParam> {
  final MovieRepository _movieRepository;

  GetMovieTrailerUseCase(this._movieRepository);

  @override
  Future<Either<AppError, List<VideoEntity>>> call(
      GetMovieTrailerListParam params) async {
    return await _movieRepository.getMovieVideoList(params.movieID);
  }
}

class GetMovieTrailerListParam {
  final int movieID;

  GetMovieTrailerListParam({required this.movieID});
}
