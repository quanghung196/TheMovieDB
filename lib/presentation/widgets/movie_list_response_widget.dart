import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_listview_with_json_data/common/constants/route_constant.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_detail_screen_agrument.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_favourite/movie_favourite_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_chip_view.dart';

class MovieListResponseWidget extends StatelessWidget {
  final List<MovieEntity> movieList;
  final String screenName;
  final ScrollController? scrollController;

  const MovieListResponseWidget(
      {Key? key,
      required this.movieList,
      this.screenName = '',
      this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: movieList.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: Sizes.dimen_8.h,
        );
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(RouteList.MOVIE_DETAIL_SCREEN,
                    arguments:
                        MovieDetaiScreenAgrument(movieID: movieList[index].id))
                .then((value) {
              if (screenName == RouteList.FAVOURITE_SCREEN) {
                BlocProvider.of<MovieFavouriteBloc>(context).refresh();
                BlocProvider.of<MovieFavouriteBloc>(context)
                    .add(LoadFavouriteMovieEvent());
              }
            });
          },
          child: Container(
            margin: EdgeInsets.only(
                left: Sizes.dimen_20.w,
                right: Sizes.dimen_10.w,
                bottom: index == movieList.length - 1 ? Sizes.dimen_4.h : 0),
            height: Sizes.dimen_70.h,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.dimen_20.w),
                  child: CachedNetworkImage(
                    width: Sizes.dimen_120.w,
                    height: Sizes.dimen_70.h,
                    imageUrl: movieList[index].loadMoviePosterPath(),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieList[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.whiteTitle,
                      ),
                      if (movieList[index].getMovieCategory().isNotEmpty)
                        Text(
                          movieList[index].getMovieCategory(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.miniGreySubtitle1,
                        ),
                      Expanded(
                        child: Text(
                          movieList[index].overview,
                          overflow: TextOverflow.fade,
                          style: Theme.of(context).textTheme.miniWhiteSubtitle1,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Sizes.dimen_2.h),
                        child: Row(
                          children: [
                            CustomChipView(
                                labelText: movieList[index].movieVoteAverage(),
                                isContainIcon: true),
                            SizedBox(
                              width: Sizes.dimen_10.w,
                            ),
                            if (movieList[index].getYearOfMovie().isNotEmpty)
                              CustomChipView(
                                labelText: movieList[index]
                                    .getYearOfMovie()
                                    .toString(),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
