import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_detail_entity.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_favourite/movie_favourite_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailAppBarWidget extends StatelessWidget {
  final MovieFavouriteBloc movieFavouriteBloc;
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailAppBarWidget(
      {Key? key,
      required this.movieFavouriteBloc,
      required this.movieDetailEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: Sizes.dimen_12.h,
            ),
          ),
          BlocBuilder<MovieFavouriteBloc, MovieFavouriteState>(
              bloc: movieFavouriteBloc,
              builder: (context, state) {
                if (state is IsFavouriteMovie) {
                  return IconButton(
                    onPressed: () {
                      BlocProvider.of<MovieFavouriteBloc>(context).add(
                          ToggleFavouriteMovieEvent(
                              movieEntity: movieDetailEntity.toMovieEntity(),
                              isFavourite: state.isFavouriteMovie));
                    },
                    icon: Icon(
                      state.isFavouriteMovie
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.white,
                      size: Sizes.dimen_12.h,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: Sizes.dimen_12.h,
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
