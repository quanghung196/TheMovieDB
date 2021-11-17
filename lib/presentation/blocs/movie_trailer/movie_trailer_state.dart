part of 'movie_trailer_bloc.dart';

abstract class MovieTrailerState extends Equatable {
  const MovieTrailerState();

  @override
  List<Object> get props => [];
}

class MovieTrailerInitial extends MovieTrailerState {}

class MovieTrailerLoaded extends MovieTrailerState {
  final List<VideoEntity> videoList;

  const MovieTrailerLoaded({required this.videoList});

  @override
  List<Object> get props => [videoList];
}

class NoMovieTrailerLoaded extends MovieTrailerState {}
