import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String buttonTitle;
  final bool isButtonEnable;
  final Function() onButtonPressed;

  const AppButton(
      {Key? key,
      required this.buttonTitle,
      this.isButtonEnable = true,
      required this.onButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppColor.royalBlue, AppColor.violet]),
          borderRadius: BorderRadius.circular(Sizes.dimen_20.w)),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      height: Sizes.dimen_16.h,
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      child: TextButton(
        onPressed: onButtonPressed,
        child: Text(
          buttonTitle,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
