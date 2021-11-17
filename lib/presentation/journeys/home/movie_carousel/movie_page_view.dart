import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'animated_movie_card_widget.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity> movies;
  final int initialPage;

  const MoviePageView(
      {Key? key, required this.movies, required this.initialPage})
      : assert(initialPage >= 0, ' default index can\'t be less than 0'),
        super(key: key);

  @override
  _MoviePageViewState createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  late PageController _pageController;
  late List<MovieEntity> _movies;

  @override
  void initState() {
    super.initState();
    _movies = widget.movies;
    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: ScreenUtil.screenHeight * 0.35,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          final MovieEntity movie = _movies[index];
          return AnimatedMovieCardWidget(
            index: index,
            pageController: _pageController,
            movieEntity: movie,
          );
        },
        pageSnapping: true,
        itemCount: _movies.isNotEmpty ? _movies.length : 0,
        onPageChanged: (index) {
          BlocProvider.of<MovieBackdropBloc>(context)
              .add(MovieBackdropChangedEvent(_movies[index]));
        },
      ),
    );
  }
}
