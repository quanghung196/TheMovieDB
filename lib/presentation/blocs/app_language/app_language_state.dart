part of 'app_language_bloc.dart';

abstract class AppLanguageState extends Equatable {
  const AppLanguageState();
}

class AppLanguageInitial extends AppLanguageState {
  @override
  List<Object> get props => [];
}

class AppLanguageChanged extends AppLanguageState {
  final Locale locale;

  const AppLanguageChanged(this.locale);

  @override
  List<Object?> get props => [locale];
}
