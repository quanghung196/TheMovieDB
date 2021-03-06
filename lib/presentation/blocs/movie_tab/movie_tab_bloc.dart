import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_playing_now_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_popular_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_upcoming_movie_use_case.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/loading/loading_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'movie_tab_event.dart';
part 'movie_tab_state.dart';

class MovieTabBloc extends Bloc<MovieTabEvent, MovieTabState> {
  final GetPopularMovieUseCase getPopularMovieUseCase;
  final GetPlayingNowMovieUseCase getPlayingNowMovieUseCase;
  final GetUpcomingMovieUseCase getUpcomingMovieUseCase;
  final LoadingBloc loadingBloc;

  static const int MAX_ITEM_IN_ONE_PAGE = 20;

  List<MovieEntity> movieList = [];
  int initializePage = 1;
  bool hasMorePage = false;

  int increasePageByOne() => initializePage++;

  void executeLoadMore(List<MovieEntity> movieList) {
    if (movieList.length < MAX_ITEM_IN_ONE_PAGE) {
      hasMorePage = false;
    } else {
      hasMorePage = true;
      increasePageByOne();
    }
  }

  MovieTabBloc(
      {required this.loadingBloc,
      required this.getPopularMovieUseCase,
      required this.getPlayingNowMovieUseCase,
      required this.getUpcomingMovieUseCase})
      : super(MovieTabInitial());

  @override
  Stream<MovieTabState> mapEventToState(MovieTabEvent event) async* {
    if (event is MovieTabChangedEvent) {
      if (!event.hasLoadMore) {
        initializePage = 1;
        yield MovieTabLoading(currentTabIndex: event.currentTabIndex);
      } else {
        loadingBloc.add(StartLoadingEvent());
      }
      await Future.delayed(const Duration(milliseconds: 500));
      late Either<AppError, List<MovieEntity>> moviesEither;
      switch (event.currentTabIndex) {
        case 0:
          moviesEither =
              await getPopularMovieUseCase(GetMovieParam(page: initializePage));
          break;
        case 1:
          moviesEither = await getPlayingNowMovieUseCase(
              GetMovieParam(page: initializePage));
          break;
        case 2:
          moviesEither = await getUpcomingMovieUseCase(
              GetMovieParam(page: initializePage));
          break;
      }
      yield moviesEither.fold(
          (error) => MovieTabLoadedError(
              currentTabIndex: event.currentTabIndex,
              appErrorType: error.appErrorType), (response) {
        movieList.addAll(response);
        executeLoadMore(response);
        return MovieTabChanged(
            currentTabIndex: event.currentTabIndex, movies: response);
      });
      loadingBloc.add(FinishLoadingEvent());
    }
  }
}
