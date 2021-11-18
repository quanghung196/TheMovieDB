part of 'movie_tab_bloc.dart';

abstract class MovieTabEvent extends Equatable {
  const MovieTabEvent();

  @override
  List<Object?> get props => [];
}

class MovieTabChangedEvent extends MovieTabEvent {
  final int currentTabIndex;
  final bool hasLoadMore;

  const MovieTabChangedEvent({required this.currentTabIndex, this.hasLoadMore = false});

  @override
  List<Object?> get props => [currentTabIndex];
}
