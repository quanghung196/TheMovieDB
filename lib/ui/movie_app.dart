import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'journeys/home/home_screen.dart';

class TheMovieDBApp extends StatelessWidget {
  const TheMovieDBApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TheMovieDB',
      theme: ThemeData(
        unselectedWidgetColor: AppColor.royalBlue,
        primaryColor: AppColor.vulcan,
        scaffoldBackgroundColor: AppColor.vulcan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: const HomeScreen(),
    );
  }
}