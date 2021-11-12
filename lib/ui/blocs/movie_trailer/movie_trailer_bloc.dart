import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_movie_trailer_use_case.dart';
import 'package:equatable/equatable.dart';

part 'movie_trailer_event.dart';

part 'movie_trailer_state.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {

  final GetMovieTrailerUseCase getMovieTrailerUseCase;

  MovieTrailerBloc({required this.getMovieTrailerUseCase}) : super(MovieTrailerInitial());

  @override
  Stream<MovieTrailerState> mapEventToState(MovieTrailerEvent event) async* {
    if (event is TrailerLoadEvent) {
      final movieTrailerEither = await getMovieTrailerUseCase(
          GetMovieTrailerListParam(movieID: event.movieID));
      yield movieTrailerEither.fold(
              (error) => NoMovieTrailerLoaded(),
              (response) {
            return MovieTrailerLoaded(videoList: response);
          });
    }
  }
}
