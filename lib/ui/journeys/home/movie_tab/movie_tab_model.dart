class MovieTabModel {
  final int tabIndex;
  final String tabTitle;

  const MovieTabModel({required this.tabIndex, required this.tabTitle})
      : assert(tabIndex >= 0, 'index cannot be negative');
}

class GenerateMovieTabList {
  static const List<MovieTabModel> movietabModels = [
    MovieTabModel(tabIndex: 0, tabTitle: 'Popular'),
    MovieTabModel(tabIndex: 1, tabTitle: 'Now'),
    MovieTabModel(tabIndex: 2, tabTitle: 'Soon'),
  ];
}