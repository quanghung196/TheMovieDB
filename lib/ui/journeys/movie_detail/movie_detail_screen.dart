import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_detail_screen_agrument.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_cast_list/movie_cast_list_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_trailer/movie_trailer_bloc.dart';
import 'package:custom_listview_with_json_data/ui/journeys/loading/loading_circle.dart';
import 'package:custom_listview_with_json_data/ui/journeys/movie_detail/movie_cast_widget.dart';
import 'package:custom_listview_with_json_data/ui/journeys/movie_detail/movie_trailer_widget.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_common_detail_widget.dart';

class MovieDetaiScreen extends StatefulWidget {
  final MovieDetaiScreenAgrument agrument;

  const MovieDetaiScreen({Key? key, required this.agrument}) : super(key: key);

  @override
  _MovieDetaiScreenState createState() => _MovieDetaiScreenState();
}

class _MovieDetaiScreenState extends State<MovieDetaiScreen> {
  late MovieEntity _movieEntity;
  late MovieCastListBloc _movieCastListBloc;
  late MovieTrailerBloc _movieTrailerBloc;

  @override
  void initState() {
    super.initState();
    _movieEntity = widget.agrument.movieEntity;
    _movieCastListBloc = getItInstance<MovieCastListBloc>();
    _movieTrailerBloc = _movieCastListBloc.movieTrailerBloc;
    _movieCastListBloc
        .add(CastListLoadEvent(movieID: _movieEntity.id));
  }

  @override
  void dispose() {
    super.dispose();
    _movieCastListBloc.close();
    _movieTrailerBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => _movieCastListBloc,
          ),
          BlocProvider(
            create: (context) => _movieTrailerBloc,
          ),
        ],
        child: BlocBuilder<MovieCastListBloc, MovieCastListState>(
            bloc: _movieCastListBloc,
            builder: (context, state) {
              if (state is MovieCastListLoading) {
                return Container(
                    color: AppColor.vulcan,
                    child: Center(
                      child: LoadingCircle(
                        size: ScreenUtil.screenHeight,
                      ),
                    ));
              } else if (state is MovieCastLoaded) {
                return Scaffold(
                  body: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MovieCommonDetailWidget(
                        movieEntity: _movieEntity,
                      ),
                      MovieCastWidget(
                        castList: state.castList,
                      ),
                      MovieTrailerWidget(movieTrailerBloc: _movieTrailerBloc),
                    ],
                  )),
                );
              } else {
                return const SizedBox.shrink();
              }
            }));
  }
}
