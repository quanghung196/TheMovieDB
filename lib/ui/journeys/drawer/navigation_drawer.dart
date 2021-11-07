import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/ui/journeys/drawer/navigation_expanded_list_item.dart';
import 'package:custom_listview_with_json_data/ui/journeys/drawer/navigation_list_item.dart';
import 'package:custom_listview_with_json_data/ui/widgets/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TMDBNavigationDrawer extends StatelessWidget {
  const TMDBNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.7),
          blurRadius: 4,
        )
      ]),
      width: Sizes.dimen_300.w,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: Sizes.dimen_8.h,
                  bottom: Sizes.dimen_18.h,
                  left: Sizes.dimen_8.w,
                  right: Sizes.dimen_8.w),
              child: Logo(
                height: Sizes.dimen_20.h,
              ),
            ),
            NavigationListItem(title: 'Favourite Movies', onPressed: () {}),
            NavigationExpandedListItem(
                title: 'Language',
                onPressed: () {},
                children: const ['English', 'Vietnamese']),
            NavigationExpandedListItem(
                title: 'Display Mode',
                onPressed: () {},
                children: const ['Dark Mode', 'Light Mode']),
            NavigationListItem(title: 'Feedback', onPressed: () {}),
            NavigationListItem(title: 'About us', onPressed: () {}),
            NavigationListItem(title: 'Log out', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
