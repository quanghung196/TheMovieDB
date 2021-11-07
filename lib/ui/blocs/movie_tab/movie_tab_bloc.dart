import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/no_params.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_playing_now_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_popular_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_upcoming_movie_use_case.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

part 'movie_tab_event.dart';

part 'movie_tab_state.dart';

class MovieTabBloc extends Bloc<MovieTabEvent, MovieTabState> {
  final GetPopularMovieUseCase getPopularMovieUseCase;
  final GetPlayingNowMovieUseCase getPlayingNowMovieUseCase;
  final GetUpcomingMovieUseCase getUpcomingMovieUseCase;

  MovieTabBloc(
      {required this.getPopularMovieUseCase,
      required this.getPlayingNowMovieUseCase,
      required this.getUpcomingMovieUseCase})
      : super(MovieTabInitial());

  @override
  Stream<MovieTabState> mapEventToState(MovieTabEvent event) async* {
    if (event is MovieTabChangedEvent) {
      late Either<AppError, List<MovieEntity>> moviesEither;
      switch (event.currentTabIndex) {
        case 0:
          moviesEither = await getPopularMovieUseCase(NoParams());
          break;
        case 1:
          moviesEither = await getPlayingNowMovieUseCase(NoParams());
          break;
        case 2:
          moviesEither = await getUpcomingMovieUseCase(NoParams());
          break;
      }
      yield moviesEither.fold(
          (error) => MovieTabLoadedError(
              currentTabIndex: event.currentTabIndex,
              appErrorType: error.appErrorType), (response) {
        return MovieTabChanged(
            currentTabIndex: event.currentTabIndex, movies: response);
      });
    }
  }
}
