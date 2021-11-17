import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'movie_tab_card_widget.dart';

class MovieTabItemListWidget extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieTabItemListWidget({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Sizes.dimen_6.h, horizontal: Sizes.dimen_8.w),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movies.length + 1,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: Sizes.dimen_14.w,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          if (index == movies.length) {
            return Padding(
              padding: EdgeInsets.only(right: Sizes.dimen_14.w),
              child: Center(
                child: InkWell(
                    onTap: () {},
                    child: Text(
                      TranslationConstants.viewMore.translate(context),
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
              ),
            );
          }
          final MovieEntity movie = movies[index];
          return MovieTabCardWidget(
            movieEntity: movie,
          );
        },
      ),
    );
  }
}
