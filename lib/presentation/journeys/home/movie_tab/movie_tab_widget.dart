import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/journeys/loading/loading_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_tab_empty_list_widget.dart';
import 'movie_tab_item_list_widget.dart';
import 'movie_tab_model.dart';
import 'movie_tab_title_widget.dart';

class MovieTabWidget extends StatefulWidget {
  const MovieTabWidget({Key? key}) : super(key: key);

  @override
  _MovieTabWidgetState createState() => _MovieTabWidgetState();
}

class _MovieTabWidgetState extends State<MovieTabWidget>
    with SingleTickerProviderStateMixin {
  int _currentTabIndex = 0;

  MovieTabBloc get movieTabBloc => BlocProvider.of<MovieTabBloc>(context);

  @override
  void initState() {
    super.initState();
    movieTabBloc.add(MovieTabChangedEvent(currentTabIndex: _currentTabIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabBloc, MovieTabState>(builder: (context, state) {
      return Padding(
        padding: EdgeInsets.only(top: Sizes.dimen_4.h),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0;
                    i < GenerateMovieTabList.movietabModels.length;
                    i++)
                  MovieTabTitleWidget(
                    tabTitle: GenerateMovieTabList.movietabModels[i].tabTitle,
                    onTabTapped: () => _onTabTapped(i),
                    isTabSelected:
                        GenerateMovieTabList.movietabModels[i].tabIndex ==
                            state.currentTabIndex,
                  )
              ],
            ),
            if (state is MovieTabLoading)
              const Expanded(
                  child: Center(
                child: LoadingCircle(),
              )),
            if (state is MovieTabChanged)
              Expanded(
                child: state.movies.isEmpty
                    ? MovieTabEmptyListWidget(
                        null,
                        onButtonPressed: () => _onTabTapped(_currentTabIndex),
                      )
                    : MovieTabItemListWidget(
                        movies: state.movies,
                        currentTabIndex: _currentTabIndex,
                      ),
              ),
            if (state is MovieTabLoadedError)
              Expanded(
                child: MovieTabEmptyListWidget(
                  state.appErrorType,
                  onButtonPressed: () => _onTabTapped(_currentTabIndex),
                ),
              )
          ],
        ),
      );
    });
  }

  void _onTabTapped(int tabIndex) {
    movieTabBloc.add(MovieTabChangedEvent(currentTabIndex: tabIndex));
    _currentTabIndex = tabIndex;
  }
}
