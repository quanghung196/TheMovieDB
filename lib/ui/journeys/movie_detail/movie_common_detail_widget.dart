import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/num_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_favourite/movie_favourite_bloc.dart';
import 'package:custom_listview_with_json_data/ui/journeys/movie_detail/movie_detail_app_bar_widget.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieCommonDetailWidget extends StatelessWidget {
  final MovieEntity movieEntity;
  final MovieFavouriteBloc movieFavouriteBloc;

  const MovieCommonDetailWidget(
      {Key? key, required this.movieEntity, required this.movieFavouriteBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.3),
                  Theme.of(context).primaryColor,
                ],
              )),
              child: CachedNetworkImage(
                imageUrl: movieEntity.loadMoviePosterPath(),
                width: ScreenUtil.screenWidth,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ListTile(
                title: Text(
                  movieEntity.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                subtitle: Text(
                  movieEntity.releaseDate,
                  style: Theme.of(context).textTheme.greySubtitle1,
                ),
                trailing: Text(
                  movieEntity.voteAverage.convertToPercentageString(),
                  style: Theme.of(context).textTheme.violetHeadline6,
                ),
              ),
            ),
            Positioned(
                top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
                left: 0,
                right: 0,
                child: MovieDetailAppBarWidget(
                  movieFavouriteBloc: movieFavouriteBloc,
                  movieEntity: movieEntity,
                ))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_8.h, horizontal: Sizes.dimen_16.w),
          child: Text(
            movieEntity.overview,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        )
      ],
    );
  }
}
