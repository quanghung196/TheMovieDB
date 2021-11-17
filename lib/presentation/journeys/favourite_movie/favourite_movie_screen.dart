import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_favourite/movie_favourite_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/empty_list_back_ground_widget.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/simple_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_favourite_list_response_widget.dart';

class FavouriteMovieScreen extends StatefulWidget {
  const FavouriteMovieScreen({Key? key}) : super(key: key);

  @override
  _FavouriteMovieScreenState createState() => _FavouriteMovieScreenState();
}

class _FavouriteMovieScreenState extends State<FavouriteMovieScreen> {
  late MovieFavouriteBloc _movieFavouriteBloc;

  @override
  void initState() {
    super.initState();
    _movieFavouriteBloc = getItInstance<MovieFavouriteBloc>();
    _movieFavouriteBloc.add(const LoadFavouriteMovieEvent(page: 1));
  }

  @override
  void dispose() {
    super.dispose();
    _movieFavouriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar(
            appBarTitle: TranslationConstants.favoriteMovies.translate(context),
          ),
          Expanded(
              child: BlocProvider(
                  create: (context) => _movieFavouriteBloc,
                  child: BlocBuilder<MovieFavouriteBloc, MovieFavouriteState>(
                      builder: (context, state) {
                    if (state is FavouriteMovieLoaded) {
                      if (state.movieList.isEmpty) {
                        return EmptyListBackGroundWidget(
                          imagePath: 'assets/svgs/no_favourite_movie.svg',
                          message: TranslationConstants.favouriteNoData
                              .translate(context),
                        );
                      } else {
                        return FavouriteListResponseWidget(
                            movieList: state.movieList);
                      }
                    } else if (state is FavouriteMovieLoadError) {
                      return EmptyListBackGroundWidget(
                        imagePath: 'assets/svgs/search_error.svg',
                        message: TranslationConstants.somethingWentWrong
                            .translate(context),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  })))
        ],
      ),
    );
  }
}
