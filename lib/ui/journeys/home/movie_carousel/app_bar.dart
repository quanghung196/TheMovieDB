import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/ui/journeys/search_movie/search_movie_screen.dart';
import 'package:custom_listview_with_json_data/ui/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TMDBAppBar extends StatelessWidget {
  const TMDBAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.statusBarHeight + Sizes.dimen_4.h,
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: () => _openNavigationDrawer(context),
              icon: SvgPicture.asset(
                'assets/svgs/menu.svg',
                color: Colors.white,
                height: Sizes.dimen_12.h,
              )),
          const Expanded(
            child: Logo(
              height: Sizes.dimen_14,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchMovieScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: Sizes.dimen_12.h,
            ),
          ),
        ],
      ),
    );
  }

  void _openNavigationDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }
}
