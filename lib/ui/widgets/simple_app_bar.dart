import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
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
          bottom: Sizes.dimen_4.h,
          top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(left: Sizes.dimen_6.w),
              alignment: Alignment.center,
              width: Sizes.dimen_48.w,
              height: Sizes.dimen_48.w,
              decoration: BoxDecoration(
                  color: AppColor.lightVulcan,
                  borderRadius: BorderRadius.circular(Sizes.dimen_20.w)),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: Sizes.dimen_8.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: Sizes.dimen_20.w),
            child: Text(
              appBarTitle,
              style: Theme.of(context).textTheme.appBarTitleDarkHeadline5,
            ),
          )
        ],
      ),
    );
  }
}
