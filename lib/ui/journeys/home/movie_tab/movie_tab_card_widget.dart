import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_listview_with_json_data/common/constants/route_constant.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_detail_screen_agrument.dart';
import 'package:custom_listview_with_json_data/ui/journeys/movie_detail/movie_detail_screen.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieTabCardWidget extends StatelessWidget {
  final MovieEntity movieEntity;

  const MovieTabCardWidget({
    Key? key,
    required this.movieEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteList.MOVIE_DETAIL_SCREEN,
            arguments: MovieDetaiScreenAgrument(movieEntity: movieEntity));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
            child: CachedNetworkImage(
              width: Sizes.dimen_150.w,
              imageUrl: movieEntity.loadMoviePosterPath(),
              fit: BoxFit.cover,
              placeholder: (context, url) => _imageLoadingPlaceHolder(),
            ),
          )),
          Padding(
            padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Text(
              movieEntity.title.intelliTrim(),
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          )
        ],
      ),
    );
  }

  Widget _imageLoadingPlaceHolder() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: Container(
        width: Sizes.dimen_150.w,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.royalBlue, AppColor.violet])),
      ),
    );
  }
}
