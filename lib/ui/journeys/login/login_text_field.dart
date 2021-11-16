import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  const LoginTextField(
      {Key? key,
      required this.hintText,
      this.isPassword = false,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(color: Colors.white);
    const styleHint = TextStyle(color: AppColor.hint);

    return Container(
      height: Sizes.dimen_26.h,
      margin: EdgeInsets.symmetric(horizontal: Sizes.dimen_20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_20.w),
        color: AppColor.lightVulcan,
        border: Border.all(color: Colors.black26),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_24.w),
      child: Center(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: styleHint,
            border: InputBorder.none,
          ),
          style: styleActive,
          obscureText: isPassword,
          obscuringCharacter: '*',
        ),
      ),
    );
  }
}
