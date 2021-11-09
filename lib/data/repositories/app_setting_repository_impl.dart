import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/main.dart';

class AppSettingRepositoryImpl extends AppSettingRepository {

  static const String LANGUAGE = "language";
  static const String DISPLAY_MODE = "displayMode";
  static const String DEFAULT_LANGUAGE_VALUE = "vi";

  AppSettingRepositoryImpl();

  @override
  String getSettingLanguageCode() {
    return loadString(LANGUAGE, DEFAULT_LANGUAGE_VALUE);
  }

  @override
  void saveSettingLanguageCode(String languageCode) {
    saveString(LANGUAGE, languageCode);
  }

  void saveString(String key, String data) {
    globalSharedPrefs.setString(key, data);
  }


  String loadString(String key, String defaultValue) {
    String data = globalSharedPrefs.getString(key) ?? defaultValue;
    return data;
  }

}