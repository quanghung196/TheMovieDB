import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_query_movie_list_use_case.dart';
import 'package:equatable/equatable.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final GetQueryMovieListUseCase getQueryMovieListUseCase;

  SearchMovieBloc({required this.getQueryMovieListUseCase})
      : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(SearchMovieEvent event) async* {
    if (event is MovieQuerySubmitedEvent) {
      yield SearchMovieLoading();
      await Future.delayed(const Duration(milliseconds: 500));
      final moviesQueryListEither = await getQueryMovieListUseCase(
          GetQueryMovieListParam(query: event.queryText));
      yield moviesQueryListEither
          .fold((error) => SearchMovieError(appErrorType: error.appErrorType),
              (response) {
                //log(response.toString());
        return SearchMovieLoaded(movieList: response, movieSearched: event.queryText);
      });
    }
  }
}
