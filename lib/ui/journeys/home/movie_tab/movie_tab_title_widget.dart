import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieTabTitleWidget extends StatelessWidget {
  final String tabTitle;
  final bool isTabSelected;
  final Function() onTabTapped;

  const MovieTabTitleWidget(
      {Key? key,
      required this.tabTitle,
      this.isTabSelected = false,
      required this.onTabTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTabTapped,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border(
                bottom: BorderSide(
                    color:
                        isTabSelected ? AppColor.royalBlue : Colors.transparent,
                    width: Sizes.dimen_1.h))),
        child: Text(tabTitle.translate(context).toUpperCase(),
            style: isTabSelected
                ? Theme.of(context).textTheme.royalBlueSubtitle1
                : Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}
