import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/ui/journeys/home/movie_carousel/movie_page_view.dart';
import 'package:custom_listview_with_json_data/ui/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouselWidget(
      {Key? key, required this.movies, required this.defaultIndex})
      : assert(defaultIndex >= 0, ' default index can\'t be less than 0'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TMDBAppBar(),
        MoviePageView(
          movies: movies,
          initialPage: defaultIndex,
        )
      ],
    );
  }
}
