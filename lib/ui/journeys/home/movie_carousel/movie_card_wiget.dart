import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_detail_screen_agrument.dart';
import 'package:custom_listview_with_json_data/ui/journeys/movie_detail/movie_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieEntity movieEntity;

  const MovieCardWidget({Key? key, required this.movieEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetaiScreen(
                  agrument:
                  MovieDetaiScreenAgrument(movieEntity: movieEntity),
                )),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child: CachedNetworkImage(
            imageUrl: movieEntity.loadMoviePosterPath(),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
