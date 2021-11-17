import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/main.dart';

class AppSettingRepositoryImpl extends AppSettingRepository {
  static const String LANGUAGE = 'language';
  static const String DISPLAY_MODE = 'displayMode';
  static const String DEFAULT_LANGUAGE_VALUE = 'en';

  static const String SESSION_ID = 'sessionID';
  static const String SESSION_ID_GUEST = 'guestLogin';

  static const String ACCOUNT_ID = 'accountID';

  AppSettingRepositoryImpl();

  //common
  void saveString(String key, String value) {
    globalSharedPrefs.setString(key, value);
  }

  String loadString(String key, String defaultValue) {
    return globalSharedPrefs.getString(key) ?? defaultValue;
  }

  void saveInt(String key, int value) {
    globalSharedPrefs.setInt(key, value);
  }

  int loadInt(String key) {
    return globalSharedPrefs.getInt(key) ?? 0;
  }

  void deleteKey(String key) {
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
    deleteKey(SESSION_ID);
  }

  @override
  void deleteAccountID() {
    deleteKey(ACCOUNT_ID);
  }

  @override
  int getAccountID() {
    return loadInt(ACCOUNT_ID);
  }

  @override
  void saveAccountID(int accountID) {
    saveInt(ACCOUNT_ID, accountID);
  }
}
