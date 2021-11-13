import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/ui/blocs/search_movie/search_movie_bloc.dart';
import 'package:custom_listview_with_json_data/ui/journeys/loading/loading_circle.dart';
import 'package:custom_listview_with_json_data/ui/journeys/search_movie/search_back_ground_widget.dart';
import 'package:custom_listview_with_json_data/ui/journeys/search_movie/search_bar_widget.dart';
import 'package:custom_listview_with_json_data/ui/journeys/search_movie/search_movie_result_list_widget.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:custom_listview_with_json_data/ui/widgets/simple_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sprintf/sprintf.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({Key? key}) : super(key: key);

  @override
  _SearchMovieScreenState createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  late SearchMovieBloc _searchMovieBloc;

  @override
  void initState() {
    super.initState();
    _searchMovieBloc = getItInstance<SearchMovieBloc>();
  }

  @override
  void dispose() {
    super.dispose();
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
            const SearchBarWidget(),
            Expanded(child: BlocBuilder<SearchMovieBloc, SearchMovieState>(
                builder: (context, state) {
              if (state is SearchMovieInitial) {
                return SearchBackGroundWidget(
                  imagePath: 'assets/svgs/search_back_ground.svg',
                  message: TranslationConstants.searchWelcome.translate(context),
                );
              } else if (state is SearchMovieLoading) {
                return const Center(child: LoadingCircle());
              } else if (state is SearchMovieLoaded) {
                if (state.movieList.isEmpty) {
                  return SearchBackGroundWidget(
                    imagePath: 'assets/svgs/no_data_found.svg',
                    message: sprintf(TranslationConstants.searchNoData.translate(context), [state.movieSearched]) ,
                  );
                } else {
                  return MovieListResponseWidget(movieList: state.movieList,);
                }
              } else {
                return SearchBackGroundWidget(
                  imagePath: 'assets/svgs/search_error.svg',
                  message: TranslationConstants.somethingWentWrong.translate(context),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
