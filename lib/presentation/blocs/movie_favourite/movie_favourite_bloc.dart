import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/no_params.dart';
import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/check_if_movie_in_favourite_list_in_db_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/delete_movie_from_db_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_favourite_movie_from_db_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_favourite_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_movie_account_state_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/post_movie_favourite_status_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/save_movie_to_db_use_case.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/loading/loading_bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_favourite_event.dart';
part 'movie_favourite_state.dart';

class MovieFavouriteBloc
    extends Bloc<MovieFavouriteEvent, MovieFavouriteState> {
  final CheckIfMovieInFavouriteListInDBUseCase
      checkIfMovieInFavouriteListInDBUseCase;
  final GetFavouriteMovieUseCase getFavouriteMovieUseCase;
  final PostFavouriteMovieStatusUseCase postFavouriteMovieStatusUseCase;
  final GetMovieAccountStateUseCase getMovieAccountStateUseCase;
  final GetFavouriteMovieFromDBUseCase getFavouriteMovieFromDBUseCase;
  final SaveMovieToDBUseCase saveMovieToDBUseCase;
  final DeleteMovieFromDBUseCase deleteMovieFromDBUseCase;
  final AppSettingRepository appSettingRepository;
  final LoadingBloc loadingBloc;

  MovieFavouriteBloc(
      {required this.postFavouriteMovieStatusUseCase,
      required this.getMovieAccountStateUseCase,
      required this.loadingBloc,
      required this.appSettingRepository,
      required this.getFavouriteMovieUseCase,
      required this.checkIfMovieInFavouriteListInDBUseCase,
      required this.getFavouriteMovieFromDBUseCase,
      required this.saveMovieToDBUseCase,
      required this.deleteMovieFromDBUseCase})
      : super(MovieFavouriteInitial());

  @override
  Stream<MovieFavouriteState> mapEventToState(
      MovieFavouriteEvent event) async* {
    if (event is CheckIfMovieInFavouriteListEvent) {
      if (appSettingRepository.getAccountID() != 0) {
        yield* _checkIfMovieIsFavouritedFromApi(event.movieID);
      } else {
        yield* _checkIfMovieIsFavouritedFromDB(event.movieID);
      }
    } else if (event is ToggleFavouriteMovieEvent) {
      if (appSettingRepository.getAccountID() != 0) {
        yield* _toggleFavouriteMovieFromApi(
            event.isFavourite, event.movieEntity);
      } else {
        yield* _toggleFavouriteMovieFromDB(
            event.isFavourite, event.movieEntity);
      }
    } else if (event is LoadFavouriteMovieEvent) {
      loadingBloc.add(StartLoadingEvent());
      await Future.delayed(const Duration(milliseconds: 2000));
      if (appSettingRepository.getAccountID() != 0) {
        yield* _fetchFavouriteMovieFromApi(event.page);
      } else {
        yield* _fetchFavouriteMovieFromDB();
      }
      loadingBloc.add(FinishLoadingEvent());
    }
  }

  Stream<MovieFavouriteState> _toggleFavouriteMovieFromDB(
      bool isMovieFavourited, MovieEntity movieEntity) async* {
    if (isMovieFavourited) {
      await deleteMovieFromDBUseCase(
          DeleteMovieFromDBParam(movieID: movieEntity.id));
    } else {
      await saveMovieToDBUseCase(SaveMovieToDBParam(movieEntity: movieEntity));
    }
    yield* _checkIfMovieIsFavouritedFromDB(movieEntity.id);
  }

  Stream<MovieFavouriteState> _toggleFavouriteMovieFromApi(
      bool isMovieFavourited, MovieEntity movieEntity) async* {
    if (isMovieFavourited) {
      await postFavouriteMovieStatusUseCase(PostFavouriteMovieStatusParam(
          movieID: movieEntity.id, isFavourite: false));
    } else {
      print('false');
      await postFavouriteMovieStatusUseCase(PostFavouriteMovieStatusParam(
          movieID: movieEntity.id, isFavourite: true));
    }
    yield* _checkIfMovieIsFavouritedFromApi(movieEntity.id);
  }

  Stream<MovieFavouriteState> _fetchFavouriteMovieFromDB() async* {
    final movieList = await getFavouriteMovieFromDBUseCase(NoParams());
    yield movieList.fold(
        (error) => FavouriteMovieLoadError(appErrorType: error.appErrorType),
        (response) {
      return FavouriteMovieLoaded(response);
    });
  }

  Stream<MovieFavouriteState> _fetchFavouriteMovieFromApi(int page) async* {
    final movieList =
        await getFavouriteMovieUseCase(GetFavouriteMovieParam(page: page));
    yield movieList.fold(
        (error) => FavouriteMovieLoadError(appErrorType: error.appErrorType),
        (response) {
      return FavouriteMovieLoaded(response);
    });
  }

  Stream<MovieFavouriteState> _checkIfMovieIsFavouritedFromDB(
      int movieID) async* {
    final isMovieFavourited = await checkIfMovieInFavouriteListInDBUseCase(
        CheckIfMovieInFavouriteListInDBParam(movieID: movieID));
    yield isMovieFavourited.fold(
        (error) => FavouriteMovieLoadError(appErrorType: error.appErrorType),
        (response) {
      return IsFavouriteMovie(response);
    });
  }

  Stream<MovieFavouriteState> _checkIfMovieIsFavouritedFromApi(
      int movieID) async* {
    final isMovieFavourited = await getMovieAccountStateUseCase(
        GetMovieAccountStateParam(movieID: movieID));
    yield isMovieFavourited.fold(
        (error) => FavouriteMovieLoadError(appErrorType: error.appErrorType),
        (response) {
      return IsFavouriteMovie(response.favorite);
    });
  }
}
