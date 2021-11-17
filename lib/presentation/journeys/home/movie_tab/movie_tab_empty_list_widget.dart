import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/app_error.dart';
import 'package:custom_listview_with_json_data/presentation/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieTabEmptyListWidget extends StatelessWidget {
  final AppErrorType? appErrorType;
  final Function() onButtonPressed;

  const MovieTabEmptyListWidget(this.appErrorType,
      {Key? key, required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String message;
    late String buttonTitle;

    if (appErrorType == AppErrorType.API) {
      message = TranslationConstants.somethingWentWrong.translate(context);
      buttonTitle = TranslationConstants.retry.translate(context);
    } else if (appErrorType == AppErrorType.NETWORK) {
      message = TranslationConstants.noNetwork.translate(context);
      buttonTitle = TranslationConstants.retry.translate(context);
    } else {
      message = TranslationConstants.emptyList.translate(context);
      buttonTitle = TranslationConstants.refresh.translate(context);
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
            child: AppButton(
                buttonTitle: buttonTitle, onButtonPressed: onButtonPressed),
          ),
        ],
      ),
    );
  }
}
