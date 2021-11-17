part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailLoadEvent extends MovieDetailEvent {
  final int movieID;

  const MovieDetailLoadEvent({required this.movieID});

  @override
  // TODO: implement props
  List<Object?> get props => [movieID];
}
