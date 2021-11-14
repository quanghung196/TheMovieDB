part of 'movie_favourite_bloc.dart';

abstract class MovieFavouriteEvent extends Equatable {
  const MovieFavouriteEvent();
}

class LoadFavouriteMovieEvent extends MovieFavouriteEvent {
  @override
  List<Object?> get props => [];
}

// class SaveFavouriteMovieEvent extends MovieFavouriteEvent {
//   final MovieEntity movieEntity;
//
//   const SaveFavouriteMovieEvent(this.movieEntity);
//
//   @override
//   List<Object?> get props => [movieEntity];
// }
//
// class DeleteFavouriteMovieEvent extends MovieFavouriteEvent {
//   final int movieID;
//
//   const DeleteFavouriteMovieEvent(this.movieID);
//
//   @override
//   List<Object?> get props => [movieID];
// }

class ToggleFavouriteMovieEvent extends MovieFavouriteEvent {
  final MovieEntity movieEntity;
  final bool isFavourite;

  const ToggleFavouriteMovieEvent({required this.movieEntity, required this.isFavourite});

  @override
  List<Object?> get props => [movieEntity, isFavourite];
}

class CheckIfMovieInFavouriteListEvent extends MovieFavouriteEvent {
  final int movieID;

  const CheckIfMovieInFavouriteListEvent({required this.movieID});

  @override
  List<Object?> get props => [movieID];
}
