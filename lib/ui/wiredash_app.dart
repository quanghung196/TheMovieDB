import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiredash/wiredash.dart';

import 'themes/theme_color.dart';

class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final Widget child;
  final String languageCode;

  const WiredashApp({
    Key? key,
    required this.navigatorKey,
    required this.child,
    required this.languageCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'themoviedb-dp1r1ce',
      secret: '5WCX2uxY-crdg1N1S-jVp6OtItu1Tunb',
      navigatorKey: navigatorKey,
      child: child,
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(
          languageCode: languageCode,
        ),
      ),
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor:AppColor.vulcan,
        dividerColor:AppColor.vulcan,
        primaryTextColor:Colors.white,
        secondaryTextColor:Colors.white,
        tertiaryTextColor:Colors.white,
      ),
    );
  }
}
