part of 'movie_favourite_bloc.dart';

abstract class MovieFavouriteEvent extends Equatable {
  const MovieFavouriteEvent();

  List<Object?> get props => [];
}

class LoadFavouriteMovieEvent extends MovieFavouriteEvent {}

class ToggleFavouriteMovieEvent extends MovieFavouriteEvent {
  final MovieEntity movieEntity;
  final bool isFavourite;

  const ToggleFavouriteMovieEvent(
      {required this.movieEntity, required this.isFavourite});

  @override
  List<Object?> get props => [movieEntity, isFavourite];
}

class CheckIfMovieInFavouriteListEvent extends MovieFavouriteEvent {
  final int movieID;

  const CheckIfMovieInFavouriteListEvent({required this.movieID});

  @override
  List<Object?> get props => [movieID];
}
