import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

import '../../../widgets/app_button.dart';

class MovieCarouselLoadErrorWidget extends StatelessWidget {
  final MovieCarouselBloc movieCarouselBloc;
  final AppErrorType appErrorType;

  const MovieCarouselLoadErrorWidget(
      {Key? key, required this.movieCarouselBloc, required this.appErrorType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String dialogMessage;

    if (appErrorType == AppErrorType.API) {
      dialogMessage =
          TranslationConstants.somethingWentWrong.translate(context);
    } else {
      dialogMessage = TranslationConstants.checkNetwork.translate(context);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          dialogMessage,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.center,
        ),
        ButtonBar(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
              child: AppButton(
                buttonTitle: TranslationConstants.retry.translate(context),
                onButtonPressed: () {
                  movieCarouselBloc.add(const CarouselLoadEvent());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_4.h),
              child: AppButton(
                  buttonTitle: TranslationConstants.feedback.translate(context),
                  onButtonPressed: () => Wiredash.of(context)?.show()),
            ),
          ],
        )
      ]),
    );
  }
}
