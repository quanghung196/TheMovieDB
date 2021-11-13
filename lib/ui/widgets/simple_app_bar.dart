import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SimpleAppBar extends StatelessWidget {

  final String appBarTitle;

  const SimpleAppBar({Key? key, required this.appBarTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: Sizes.dimen_12.h,
            ),
          ),
          Text(
            appBarTitle,
            style: Theme.of(context).textTheme.appBarTitleDarkHeadline5,
          )
        ],
      ),
    );
  }
}
