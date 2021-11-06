import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/no_params.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_trending_movie_use_case.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_carousel_event.dart';

part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrendingMovieUseCase getTrendingMovieUseCase;
  final MovieBackdropBloc movieBackdropBloc;

  MovieCarouselBloc(
      {required this.movieBackdropBloc, required this.getTrendingMovieUseCase})
      : super(MovieCarouselInitial());

  @override
  Stream<MovieCarouselState> mapEventToState(MovieCarouselEvent event) async* {
    if (event is CarouselLoadEvent) {
      final moviesTrendingEither = await getTrendingMovieUseCase(NoParams());
      yield moviesTrendingEither
          .fold((error) => MovieCarouselError(error.appErrorType), (response) {
        movieBackdropBloc
            .add(MovieBackdropChangedEvent(response[event.defaultIndex]));
        return MovieCarouselLoaded(
            movies: response, defaultIndex: event.defaultIndex);
      });
    }
  }
}
