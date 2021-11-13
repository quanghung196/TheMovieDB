part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();
}

class MovieQuerySubmitedEvent extends SearchMovieEvent {
  final String queryText;

  const MovieQuerySubmitedEvent({required this.queryText});

  @override
  List<Object?> get props => [queryText];
}
