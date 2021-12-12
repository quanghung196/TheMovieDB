import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_color.dart';
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
          gradient: LinearGradient(
            colors: isButtonEnable
                ? [AppColor.royalBlue, AppColor.violet]
                : [Colors.grey, Colors.grey],
          ),
          borderRadius: BorderRadius.circular(Sizes.dimen_20.w)),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
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
