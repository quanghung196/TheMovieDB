import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/no_params.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_trending_movie_use_case.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/loading/loading_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrendingMovieUseCase getTrendingMovieUseCase;
  final MovieBackdropBloc movieBackdropBloc;
  final LoadingBloc loadingBloc;

  MovieCarouselBloc(
      {required this.loadingBloc,
      required this.movieBackdropBloc,
      required this.getTrendingMovieUseCase})
      : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(MovieCarouselEvent event) async* {
    if (event is CarouselLoadEvent) {
      loadingBloc.add(StartLoadingEvent());
      final moviesTrendingEither = await getTrendingMovieUseCase(NoParams());
      yield moviesTrendingEither
          .fold((error) => MovieCarouselError(error.appErrorType), (response) {
        movieBackdropBloc
            .add(MovieBackdropChangedEvent(response[event.defaultIndex]));
        return MovieCarouselLoaded(
            movies: response, defaultIndex: event.defaultIndex);
      });
      loadingBloc.add(FinishLoadingEvent());
    }
  }
}
