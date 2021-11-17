part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoadError extends MovieDetailState {
  final AppErrorType appErrorType;

  const MovieDetailLoadError({required this.appErrorType});

  @override
  List<Object> get props => [appErrorType];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailLoaded(this.movieDetailEntity);

  @override
  List<Object> get props => [movieDetailEntity];
}
