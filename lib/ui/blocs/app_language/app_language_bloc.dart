import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/domain/entities/language_entity.dart';
import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {

  final AppSettingRepository appSettingRepository;

  AppLanguageBloc(this.appSettingRepository) : super(AppLanguageInitial());

  @override
  Stream<AppLanguageState> mapEventToState(AppLanguageEvent event) async* {
    if(event is ToggleLanguageEvent) {
      appSettingRepository.saveSettingLanguageCode(event.languages.languageCode);
      yield AppLanguageChanged(Locale(event.languages.languageCode));
    }
  }

  String loadPreferredLanguage() {
    return appSettingRepository.getSettingLanguageCode();
  }
}
