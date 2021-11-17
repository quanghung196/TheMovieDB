import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBackDropWidget extends StatelessWidget {
  const MovieBackDropWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Sizes.dimen_40.w),
        child: Stack(children: <Widget>[
          FractionallySizedBox(
            heightFactor: 1,
            widthFactor: 1,
            child: BlocBuilder<MovieBackdropBloc, MovieBackdropState>(
                builder: (context, state) {
              if (state is MovieBackdropChanged) {
                return CachedNetworkImage(
                  imageUrl: state.movie.loadMovieBackDropPath(),
                  fit: BoxFit.fitHeight,
                );
              }
              return const SizedBox.shrink();
            }),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
            child: Container(
              width: ScreenUtil.screenWidth,
              height: 1,
              color: Colors.transparent,
            ),
          ),
        ]),
      ),
    );
  }
}
