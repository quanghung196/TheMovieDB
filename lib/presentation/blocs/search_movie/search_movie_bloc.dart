import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_query_movie_list_use_case.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/loading/loading_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final GetQueryMovieListUseCase getQueryMovieListUseCase;
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

  void refresh() {
    initializePage = 1;
    movieList.clear();
    hasMorePage = false;
  }

  SearchMovieBloc(
      {required this.loadingBloc, required this.getQueryMovieListUseCase})
      : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(SearchMovieEvent event) async* {
    if (event is MovieQuerySubmitedEvent) {
      loadingBloc.add(StartLoadingEvent());
      await Future.delayed(const Duration(milliseconds: 2000));
      final moviesQueryListEither = await getQueryMovieListUseCase(
          GetQueryMovieListParam(query: event.queryText, page: initializePage));
      yield moviesQueryListEither
          .fold((error) => SearchMovieError(appErrorType: error.appErrorType),
              (response) {
        movieList.addAll(response);
        executeLoadMore(response);
        return SearchMovieLoaded(
            movieList: response, movieSearched: event.queryText);
      });
      loadingBloc.add(FinishLoadingEvent());
    }
  }
}
