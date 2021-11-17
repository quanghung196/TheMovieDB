part of 'loading_bloc.dart';

@immutable
abstract class LoadingState {}

class LoadingInitial extends LoadingState {}

class LoadingStared extends LoadingState {}

class LoadingFinished extends LoadingState {}
