part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();

  @override
  List<Object> get props => [];
}

class SearchMovieInitial extends SearchMovieState {}

class SearchMovieLoading extends SearchMovieState {}

class SearchMovieLoaded extends SearchMovieState {
  final List<MovieEntity> movieList;
  final String movieSearched;

  const SearchMovieLoaded({required this.movieList, required this.movieSearched});

  @override
  List<Object> get props => [movieList];
}

class SearchMovieError extends SearchMovieState {
  final AppErrorType appErrorType;

  const SearchMovieError({required this.appErrorType});
}
