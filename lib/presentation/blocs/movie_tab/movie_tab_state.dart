part of 'movie_tab_bloc.dart';

abstract class MovieTabState extends Equatable {
  final int currentTabIndex;

  const MovieTabState({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabInitial extends MovieTabState {}

class MovieTabLoading extends MovieTabState {
  const MovieTabLoading({int currentTabIndex = 0})
      : super(currentTabIndex: currentTabIndex);
}

class MovieTabChanged extends MovieTabState {
  final List<MovieEntity> movies;

  const MovieTabChanged({int currentTabIndex = 0, required this.movies})
      : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, movies];
}

class MovieTabLoadedError extends MovieTabState {
  final AppErrorType appErrorType;

  const MovieTabLoadedError(
      {int currentTabIndex = 0, required this.appErrorType})
      : super(currentTabIndex: currentTabIndex);
}
