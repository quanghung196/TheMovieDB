part of 'movie_favourite_bloc.dart';

abstract class MovieFavouriteState extends Equatable {
  const MovieFavouriteState();

  @override
  List<Object> get props => [];
}

class MovieFavouriteInitial extends MovieFavouriteState {}

class FavouriteMovieLoaded extends MovieFavouriteState {
  final List<MovieEntity> movieList;

  const FavouriteMovieLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class FavouriteMovieLoadError extends MovieFavouriteState {
  final AppErrorType appErrorType;

  const FavouriteMovieLoadError({required this.appErrorType});

  @override
  List<Object> get props => [appErrorType];
}

class IsFavouriteMovie extends MovieFavouriteState {
  final bool isFavouriteMovie;

  const IsFavouriteMovie(this.isFavouriteMovie);

  @override
  List<Object> get props => [isFavouriteMovie];
}
