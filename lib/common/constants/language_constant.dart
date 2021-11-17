import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/domain/entities/language_entity.dart';

class Languages {
  const Languages._();

  static const languagesList = [
    LanguageEntity(
        languageCode: 'en', languageValue: TranslationConstants.english),
    LanguageEntity(
        languageCode: 'vi', languageValue: TranslationConstants.vietnamese),
  ];
}
