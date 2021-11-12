import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_watch_trailer_screen_agrument.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_trailer/movie_trailer_bloc.dart';
import 'package:custom_listview_with_json_data/ui/journeys/watch_trailer/watch_trailer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app_button.dart';

class MovieTrailerWidget extends StatelessWidget {
  final MovieTrailerBloc movieTrailerBloc;

  const MovieTrailerWidget({Key? key, required this.movieTrailerBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTrailerBloc, MovieTrailerState>(
      bloc: movieTrailerBloc,
      builder: (context, state) {
        if (state is MovieTrailerLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_64.w),
            child: AppButton(
              buttonTitle:
                  TranslationConstants.watchTrailers.translate(context),
              onButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieWatchTrailerScreen(
                        agrument:
                        MovieWatchTrailerScreenAgrument(videoList: state.videoList),
                      )),
                );
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
