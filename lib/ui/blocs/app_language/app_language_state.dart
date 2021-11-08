part of 'app_language_bloc.dart';

abstract class AppLanguageState extends Equatable {
  const AppLanguageState();
}

class AppLanguageChanged extends AppLanguageState {
  final Locale locale;

  const AppLanguageChanged(this.locale);

  @override
  List<Object?> get props => [locale];

}