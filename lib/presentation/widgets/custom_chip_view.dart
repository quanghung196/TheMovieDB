import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_color.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChipView extends StatelessWidget {
  final String labelText;
  final bool isContainIcon;

  const CustomChipView(
      {Key? key, required this.labelText, this.isContainIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Sizes.dimen_18.h,
        decoration: BoxDecoration(
            color: AppColor.lightVulcan,
            borderRadius: BorderRadius.circular(Sizes.dimen_32.w)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_18.w),
          child: Center(
              child: Row(
            children: [
              if (isContainIcon)
                const Icon(
                  Icons.star,
                  size: 16,
                  color: AppColor.yellowStar,
                ),
              Padding(
                padding:
                    EdgeInsets.only(left: isContainIcon ? Sizes.dimen_10.w : 0),
                child: Text(
                  labelText,
                  style: Theme.of(context).textTheme.whiteChipLabel,
                ),
              )
            ],
          )),
        ));
  }
}
