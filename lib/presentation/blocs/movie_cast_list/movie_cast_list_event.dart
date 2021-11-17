part of 'movie_cast_list_bloc.dart';

abstract class MovieCastListEvent extends Equatable {
  const MovieCastListEvent();
}

class CastListLoadEvent extends MovieCastListEvent {
  final int movieID;

  const CastListLoadEvent({required this.movieID});

  @override
  // TODO: implement props
  List<Object?> get props => [movieID];
}
