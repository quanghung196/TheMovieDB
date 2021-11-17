part of 'movie_trailer_bloc.dart';

abstract class MovieTrailerEvent extends Equatable {
  const MovieTrailerEvent();
}

class TrailerLoadEvent extends MovieTrailerEvent {
  final int movieID;

  const TrailerLoadEvent({required this.movieID});

  @override
  // TODO: implement props
  List<Object?> get props => [movieID];
}
