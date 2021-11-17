import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_detail_screen_agrument.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_cast_list/movie_cast_list_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_favourite/movie_favourite_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_trailer/movie_trailer_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_cast_widget.dart';
import 'movie_common_detail_widget.dart';
import 'movie_trailer_widget.dart';

class MovieDetaiScreen extends StatefulWidget {
  final MovieDetaiScreenAgrument agrument;

  const MovieDetaiScreen({Key? key, required this.agrument}) : super(key: key);

  @override
  _MovieDetaiScreenState createState() => _MovieDetaiScreenState();
}

class _MovieDetaiScreenState extends State<MovieDetaiScreen> {
  late int _movieID;

  late MovieDetailBloc _movieDetailBloc;
  late MovieCastListBloc _movieCastListBloc;
  late MovieTrailerBloc _movieTrailerBloc;
  late MovieFavouriteBloc _movieFavouriteBloc;

  @override
  void initState() {
    super.initState();
    _movieID = widget.agrument.movieID;
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _movieCastListBloc = _movieDetailBloc.movieCastListBloc;
    _movieTrailerBloc = _movieDetailBloc.movieTrailerBloc;
    _movieFavouriteBloc = _movieDetailBloc.movieFavouriteBloc;
    _movieDetailBloc.add(MovieDetailLoadEvent(movieID: _movieID));
  }

  @override
  void dispose() {
    super.dispose();
    _movieDetailBloc.close();
    _movieCastListBloc.close();
    _movieTrailerBloc.close();
    _movieFavouriteBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _movieDetailBloc,
        ),
        BlocProvider(
          create: (context) => _movieCastListBloc,
        ),
        BlocProvider(
          create: (context) => _movieTrailerBloc,
        ),
        BlocProvider(
          create: (context) => _movieFavouriteBloc,
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          bloc: _movieDetailBloc,
          builder: (context, state) {
            if (state is MovieDetailLoaded) {
              return Scaffold(
                body: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MovieCommonDetailWidget(
                      movieDetailEntity: state.movieDetailEntity,
                      movieFavouriteBloc: _movieFavouriteBloc,
                    ),
                    BlocBuilder<MovieCastListBloc, MovieCastListState>(
                        builder: (context, state) {
                      if (state is MovieCastLoaded) {
                        return MovieCastWidget(
                          castList: state.castList,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    MovieTrailerWidget(movieTrailerBloc: _movieTrailerBloc),
                  ],
                )),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
