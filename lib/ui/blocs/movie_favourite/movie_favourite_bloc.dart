import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/no_params.dart';
import 'package:custom_listview_with_json_data/domain/usecases/check_if_movie_in_favourite_list_in_db_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/delete_movie_from_db_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_favourite_movie_from_db.dart';
import 'package:custom_listview_with_json_data/domain/usecases/save_movie_to_db_use_case.dart';
import 'package:equatable/equatable.dart';

part 'movie_favourite_event.dart';

part 'movie_favourite_state.dart';

class MovieFavouriteBloc
    extends Bloc<MovieFavouriteEvent, MovieFavouriteState> {
  final CheckIfMovieInFavouriteListInDBUseCase
      checkIfMovieInFavouriteListInDBUseCase;
  final GetFavouriteMovieFromDBUseCase getFavouriteMovieFromDBUseCase;
  final SaveMovieToDBUseCase saveMovieToDBUseCase;
  final DeleteMovieFromDBUseCase deleteMovieFromDBUseCase;

  MovieFavouriteBloc(
      {required this.checkIfMovieInFavouriteListInDBUseCase,
      required this.getFavouriteMovieFromDBUseCase,
      required this.saveMovieToDBUseCase,
      required this.deleteMovieFromDBUseCase})
      : super(MovieFavouriteInitial());

  @override
  Stream<MovieFavouriteState> mapEventToState(
      MovieFavouriteEvent event) async* {
    if (event is CheckIfMovieInFavouriteListEvent) {
      yield* _checkIfMovieIsFavourited(event.movieID);
    } else if (event is ToggleFavouriteMovieEvent) {
      if (event.isFavourite) {
        await deleteMovieFromDBUseCase(
            DeleteMovieFromDBParam(movieID: event.movieEntity.id));
      } else {
        await saveMovieToDBUseCase(
            SaveMovieToDBParam(movieEntity: event.movieEntity));
      }
      yield* _checkIfMovieIsFavourited(event.movieEntity.id);
    } else if (event is LoadFavouriteMovieEvent) {
      yield MovieFavouriteLoading();
      await Future.delayed(const Duration(milliseconds: 2000));
      yield* _fetchFavouriteMovie();
    }
  }

  Stream<MovieFavouriteState> _fetchFavouriteMovie() async* {
    final movieList = await getFavouriteMovieFromDBUseCase(NoParams());
    yield movieList.fold(
        (error) => FavouriteMovieLoadError(appErrorType: error.appErrorType),
        (response) {
      return FavouriteMovieLoaded(response);
    });
  }

  Stream<MovieFavouriteState> _checkIfMovieIsFavourited(int movieID) async* {
    final isMovieFavourited = await checkIfMovieInFavouriteListInDBUseCase(
        CheckIfMovieInFavouriteListInDBParam(movieID: movieID));
    yield isMovieFavourited.fold(
        (error) => FavouriteMovieLoadError(appErrorType: error.appErrorType),
        (response) {
      return IsFavouriteMovie(response);
    });
  }
}
