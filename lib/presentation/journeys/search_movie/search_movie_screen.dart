import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/journeys/search_movie/search_bar_widget.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/empty_list_back_ground_widget.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/movie_list_response_widget.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/simple_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({Key? key}) : super(key: key);

  @override
  _SearchMovieScreenState createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  late SearchMovieBloc _searchMovieBloc;
  late TextEditingController _searchBarController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchBarController = TextEditingController();
    _searchMovieBloc = getItInstance<SearchMovieBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchBarController.clear();
    _searchMovieBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchMovieBloc,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SimpleAppBar(
                appBarTitle:
                    TranslationConstants.findYourMovie.translate(context)),
            SearchBarWidget(searchBarController: _searchBarController),
            Expanded(child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
                builder: (context, state) {
              if (state is SearchMovieInitial) {
                return EmptyListBackGroundWidget(
                  imagePath: 'assets/svgs/search_back_ground.svg',
                  message:
                      TranslationConstants.searchWelcome.translate(context),
                );
              } else if (state is SearchMovieLoaded) {
                if (_searchMovieBloc.movieList.isEmpty) {
                  return EmptyListBackGroundWidget(
                    imagePath: 'assets/svgs/no_data_found.svg',
                    message: sprintf(
                        TranslationConstants.searchNoData.translate(context),
                        [state.movieSearched]),
                  );
                } else {
                  if (_searchMovieBloc.movieList.length <= 20 &&
                      _scrollController.hasClients) {
                    _scrollController.jumpTo(0);
                  }
                  return NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification sn) {
                        if (sn is ScrollUpdateNotification &&
                            sn.metrics.pixels == sn.metrics.maxScrollExtent) {
                          if (_searchMovieBloc.hasMorePage) {
                            _searchMovieBloc.add(MovieQuerySubmitedEvent(
                                queryText: _searchBarController.text));
                          }
                        }
                        return true;
                      },
                      child: MovieListResponseWidget(
                        movieList: _searchMovieBloc.movieList,
                        scrollController: _scrollController,
                      ));
                }
              } else {
                return EmptyListBackGroundWidget(
                  imagePath: 'assets/svgs/search_error.svg',
                  message: TranslationConstants.somethingWentWrong
                      .translate(context),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
