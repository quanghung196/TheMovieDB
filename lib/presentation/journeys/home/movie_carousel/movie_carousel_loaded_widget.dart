import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/separator.dart';
import 'package:flutter/cupertino.dart';

import 'app_bar.dart';
import 'movie_backdrop_widget.dart';
import 'movie_data_widget.dart';
import 'movie_page_view.dart';

class MovieCarouselLoadedWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouselLoadedWidget(
      {Key? key, required this.movies, required this.defaultIndex})
      : assert(defaultIndex >= 0, ' default index can\'t be less than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const MovieBackDropWidget(),
        Column(
          children: [
            const TMDBAppBar(),
            MoviePageView(
              movies: movies,
              initialPage: defaultIndex,
            ),
            const MovieDataWidget(),
            Separator(),
          ],
        ),
      ],
    );
  }
}
