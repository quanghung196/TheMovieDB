part of 'loading_bloc.dart';

@immutable
abstract class LoadingEvent {}

class StartLoadingEvent extends LoadingEvent {}

class FinishLoadingEvent extends LoadingEvent {}
