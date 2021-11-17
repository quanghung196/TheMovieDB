part of 'movie_backdrop_bloc.dart';

abstract class MovieBackdropEvent extends Equatable {
  const MovieBackdropEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class MovieBackdropChangedEvent extends MovieBackdropEvent {
  final MovieEntity movie;

  const MovieBackdropChangedEvent(this.movie);

  @override
  // TODO: implement props
  List<Object?> get props => [movie];
}
