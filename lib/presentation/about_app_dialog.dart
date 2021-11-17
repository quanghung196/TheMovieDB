import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/app_button.dart';

class AboutAppDialog extends StatelessWidget {
  const AboutAppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: Sizes.dimen_32,
      insetPadding: EdgeInsets.all(Sizes.dimen_32.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_8.w),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: Sizes.dimen_4.h,
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor,
              blurRadius: Sizes.dimen_16,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              TranslationConstants.about.translate(context),
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_8.w, vertical: Sizes.dimen_6.h),
              child: Text(
                TranslationConstants.aboutDescription.translate(context),
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/pngs/tmdb_logo.png',
              height: Sizes.dimen_32.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
              child: AppButton(
                buttonTitle: TranslationConstants.okay.translate(context),
                isButtonEnable: true,
                onButtonPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
