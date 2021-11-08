import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:custom_listview_with_json_data/common/constants/language.dart';
import 'package:custom_listview_with_json_data/domain/entities/language_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'app_language_event.dart';
part 'app_language_state.dart';

class AppLanguageBloc extends Bloc<AppLanguageEvent, AppLanguageState> {
  AppLanguageBloc() : super(AppLanguageChanged(Locale(Languages.languagesList[0].languageCode)));

  @override
  Stream<AppLanguageState> mapEventToState(AppLanguageEvent event) async* {
    if(event is ToggleLanguageEvent) {
      yield AppLanguageChanged(Locale(event.languages.languageCode));
    }
  }
}
