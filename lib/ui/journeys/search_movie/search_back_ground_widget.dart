import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBackGroundWidget extends StatelessWidget {
  final String message;
  final String imagePath;

  const SearchBackGroundWidget(
      {Key? key, required this.message, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_24.w),
          child: Text(
            message,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Center(
          child: SvgPicture.asset(imagePath),
        )
      ],
    );
  }
}
