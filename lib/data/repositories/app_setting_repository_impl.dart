import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/main.dart';

class AppSettingRepositoryImpl extends AppSettingRepository {
  static const String LANGUAGE = 'language';
  static const String DISPLAY_MODE = 'displayMode';
  static const String DEFAULT_LANGUAGE_VALUE = 'en';

  static const String SESSION_ID = 'sessionID';
  static const String SESSION_ID_GUEST = 'guestLogin';

  AppSettingRepositoryImpl();

  //common
  void saveString(String key, String value) {
    globalSharedPrefs.setString(key, value);
  }

  String loadString(String key, String defaultValue) {
    return globalSharedPrefs.getString(key) ?? defaultValue;
  }

  void deleteString(String key) {
    globalSharedPrefs.remove(key);
  }

  //language
  @override
  String getSettingLanguageCode() {
    return loadString(LANGUAGE, DEFAULT_LANGUAGE_VALUE);
  }

  @override
  void saveSettingLanguageCode(String languageCode) {
    saveString(LANGUAGE, languageCode);
  }

  //session authentication
  @override
  void saveSessionID(String sessionID) {
    saveString(SESSION_ID, sessionID);
  }

  @override
  String getSessionID() {
    return loadString(SESSION_ID, '');
  }

  @override
  void deleteSessionID() {
    deleteString(SESSION_ID);
  }
}
