abstract class AppSettingRepository {
  //language
  void saveSettingLanguageCode(String languageCode);
  String getSettingLanguageCode();
  //displaymode

  //session authentication
  void saveSessionID(String sessionID);
  String getSessionID();
  void deleteSessionID();
}