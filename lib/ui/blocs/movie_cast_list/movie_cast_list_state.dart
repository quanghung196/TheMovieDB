part of 'movie_cast_list_bloc.dart';

abstract class MovieCastListState extends Equatable {
  const MovieCastListState();

  @override
  List<Object> get props => [];
}

class MovieCastListInitial extends MovieCastListState {}

class MovieCastListLoading extends MovieCastListState {}

class MovieCastLoadError extends MovieCastListState {
  final AppErrorType errorType;

  const MovieCastLoadError({required this.errorType});
}

class MovieCastLoaded extends MovieCastListState {
  final List<CastEntity> castList;

  const MovieCastLoaded({required this.castList});

  @override
  List<Object> get props => [castList];
}
