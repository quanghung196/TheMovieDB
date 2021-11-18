import 'package:custom_listview_with_json_data/common/constants/route_constant.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/view_all_movie_screen_agrument.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/empty_list_back_ground_widget.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/movie_list_response_widget.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/simple_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewAllMovieScreen extends StatefulWidget {
  final ViewAllMovieScreenAgrument agrument;

  const ViewAllMovieScreen({Key? key, required this.agrument})
      : super(key: key);

  @override
  _ViewAllMovieScreenState createState() => _ViewAllMovieScreenState();
}

class _ViewAllMovieScreenState extends State<ViewAllMovieScreen> {
  late MovieTabBloc _movieTabBloc;

  String _appBarTitle(BuildContext context) {
    switch (widget.agrument.currentTab) {
      case 0:
        return TranslationConstants.popularMovie.translate(context);
      case 1:
        return TranslationConstants.nowMovie.translate(context);
      case 2:
        return TranslationConstants.soonMovie.translate(context);
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    _movieTabBloc = getItInstance<MovieTabBloc>();
    _movieTabBloc.add(MovieTabChangedEvent(
        currentTabIndex: widget.agrument.currentTab, hasLoadMore: true));
  }

  @override
  void dispose() {
    super.dispose();
    _movieTabBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleAppBar(
            appBarTitle: _appBarTitle(context),
          ),
          Expanded(
              child: BlocProvider(
                  create: (context) => _movieTabBloc,
                  child: BlocBuilder<MovieTabBloc, MovieTabState>(
                      builder: (context, state) {
                    if (state is MovieTabChanged) {
                      return NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification sn) {
                            if (sn is ScrollUpdateNotification &&
                                sn.metrics.pixels ==
                                    sn.metrics.maxScrollExtent) {
                              if (_movieTabBloc.hasMorePage) {
                                _movieTabBloc.add(MovieTabChangedEvent(
                                    currentTabIndex: widget.agrument.currentTab,
                                    hasLoadMore: true));
                              }
                            }
                            return true;
                          },
                          child: MovieListResponseWidget(
                              screenName: RouteList.ALL_MOVIE_SCREEN,
                              movieList: _movieTabBloc.movieList));
                    } else if (state is MovieTabLoadedError) {
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
