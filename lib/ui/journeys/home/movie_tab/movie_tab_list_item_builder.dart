import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/ui/journeys/home/movie_tab/movie_tab_card_widget.dart';
import 'package:flutter/cupertino.dart';

class MovieTabListItemBuilder extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieTabListItemBuilder({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: Sizes.dimen_14.w,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final MovieEntity movie = movies[index];
          return MovieTabCardWidget(
              movieID: movie.id,
              movieTitle: movie.title,
              moviePosterPath: movie.posterPath);
        },
      ),
    );
  }
}
