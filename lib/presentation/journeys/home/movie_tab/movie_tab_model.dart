import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';

class MovieTabModel {
  final int tabIndex;
  final String tabTitle;

  const MovieTabModel({required this.tabIndex, required this.tabTitle})
      : assert(tabIndex >= 0, 'index cannot be negative');
}

class GenerateMovieTabList {
  static const List<MovieTabModel> movietabModels = [
    MovieTabModel(tabIndex: 0, tabTitle: TranslationConstants.popular),
    MovieTabModel(tabIndex: 1, tabTitle: TranslationConstants.now),
    MovieTabModel(tabIndex: 2, tabTitle: TranslationConstants.soon),
  ];
}
