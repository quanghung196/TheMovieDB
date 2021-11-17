import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';
import 'package:flutter/cupertino.dart';

import 'movie_card_wiget.dart';

class AnimatedMovieCardWidget extends StatelessWidget {
  final int index;
  final MovieEntity movieEntity;
  final PageController pageController;

  const AnimatedMovieCardWidget(
      {Key? key,
      required this.index,
      required this.movieEntity,
      required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: pageController,
        builder: (context, child) {
          double value = 1;
          if (pageController.position.haveDimensions) {
            value = (pageController.page ?? 0) - index;
            value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: Curves.easeIn.transform(value) *
                    ScreenUtil.screenHeight *
                    0.35,
                width: Sizes.dimen_230.w,
                child: child,
              ),
            );
          } else {
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                height:
                    Curves.easeIn.transform(index == 0 ? value : value * 0.9) *
                        ScreenUtil.screenHeight *
                        0.35,
                width: Sizes.dimen_230.w,
                child: child,
              ),
            );
          }
        },
        child: MovieCardWidget(
          movieEntity: movieEntity,
        ));
  }
}
