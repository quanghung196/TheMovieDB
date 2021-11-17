part of 'app_language_bloc.dart';

abstract class AppLanguageEvent extends Equatable {
  const AppLanguageEvent();

  @override
  List<Object?> get props => [];
}

class ToggleLanguageEvent extends AppLanguageEvent {
  final LanguageEntity languages;

  const ToggleLanguageEvent(this.languages);

  @override
  List<Object?> get props => [languages];
}
