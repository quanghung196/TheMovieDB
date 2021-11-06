import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:equatable/equatable.dart';

part 'movie_backdrop_event.dart';
part 'movie_backdrop_state.dart';

class MovieBackdropBloc extends Bloc<MovieBackdropEvent, MovieBackdropState> {
  MovieBackdropBloc() : super(MovieBackdropInitial());

  @override
  Stream<MovieBackdropState> mapEventToState(MovieBackdropEvent event) async* {
    if(event is MovieBackdropChangedEvent){
      yield MovieBackdropChanged(event.movie);
    }
  }
}
