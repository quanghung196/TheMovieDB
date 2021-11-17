import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_detail_entity.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_movie_detail_use_case.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/loading/loading_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_cast_list/movie_cast_list_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_favourite/movie_favourite_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_trailer/movie_trailer_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetailUseCase getMovieDetailUseCase;
  final MovieCastListBloc movieCastListBloc;
  final MovieTrailerBloc movieTrailerBloc;
  final MovieFavouriteBloc movieFavouriteBloc;
  final LoadingBloc loadingBloc;

  MovieDetailBloc(
      {required this.loadingBloc,
      required this.getMovieDetailUseCase,
      required this.movieCastListBloc,
      required this.movieTrailerBloc,
      required this.movieFavouriteBloc})
      : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailLoadEvent) {
      loadingBloc.add(StartLoadingEvent());
      await Future.delayed(const Duration(milliseconds: 1000));
      final movieDetailResponseEither = await getMovieDetailUseCase(
          GetMovieDetailParams(movieID: event.movieID));
      yield movieDetailResponseEither.fold(
          (error) => MovieDetailLoadError(appErrorType: error.appErrorType),
          (response) {
        movieCastListBloc.add(CastListLoadEvent(movieID: event.movieID));
        movieFavouriteBloc
            .add(CheckIfMovieInFavouriteListEvent(movieID: event.movieID));
        movieTrailerBloc.add(TrailerLoadEvent(movieID: event.movieID));
        return MovieDetailLoaded(response);
      });
      loadingBloc.add(FinishLoadingEvent());
    }
  }
}
