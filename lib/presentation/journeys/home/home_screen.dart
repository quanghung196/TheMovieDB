import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/journeys/drawer/navigation_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_carousel/movie_carousel_load_error_widget.dart';
import 'movie_carousel/movie_carousel_loaded_widget.dart';
import 'movie_tab/movie_tab_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselBloc _movieCarouselBloc;
  late MovieBackdropBloc _movieBackdropBloc;
  late MovieTabBloc _movieTabBloc;

  @override
  void initState() {
    super.initState();
    _movieCarouselBloc = getItInstance<MovieCarouselBloc>();
    _movieCarouselBloc.add(const CarouselLoadEvent());

    _movieBackdropBloc = _movieCarouselBloc.movieBackdropBloc;
    _movieTabBloc = getItInstance<MovieTabBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _movieCarouselBloc.close();
    _movieBackdropBloc.close();
    _movieTabBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _movieCarouselBloc,
        ),
        BlocProvider(
          create: (context) => _movieBackdropBloc,
        ),
        BlocProvider(
          create: (context) => _movieTabBloc,
        ),
      ],
      child: Scaffold(
        drawer: const TMDBNavigationDrawer(),
        body: BlocBuilder<MovieCarouselBloc, MovieCarouselState>(
          bloc: _movieCarouselBloc,
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.6,
                    child: MovieCarouselLoadedWidget(
                      movies: state.movies,
                      defaultIndex: state.defaultIndex,
                    ),
                  ),
                  const FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.4,
                    child: MovieTabWidget(),
                  )
                ],
              );
            } else if (state is MovieCarouselError) {
              return MovieCarouselLoadErrorWidget(
                movieCarouselBloc: _movieCarouselBloc,
                appErrorType: state.errorType,
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
