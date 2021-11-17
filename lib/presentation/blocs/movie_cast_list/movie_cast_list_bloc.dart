import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/domain/entities/cast_entity.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_movie_cast_list_use_case.dart';
import 'package:equatable/equatable.dart';

part 'movie_cast_list_event.dart';
part 'movie_cast_list_state.dart';

class MovieCastListBloc extends Bloc<MovieCastListEvent, MovieCastListState> {
  final GetMovieCastListUseCase getMovieCastListUseCase;

  MovieCastListBloc({required this.getMovieCastListUseCase})
      : super(MovieCastListInitial());

  @override
  Stream<MovieCastListState> mapEventToState(MovieCastListEvent event) async* {
    if (event is CastListLoadEvent) {
      await Future.delayed(const Duration(milliseconds: 1000));
      final movieCastListEither = await getMovieCastListUseCase(
          GetMovieCastListParam(movieID: event.movieID));
      yield movieCastListEither
          .fold((error) => MovieCastLoadError(errorType: error.appErrorType),
              (response) {
        return MovieCastLoaded(castList: response);
      });
    }
  }
}
