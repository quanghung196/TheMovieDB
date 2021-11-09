import 'package:custom_listview_with_json_data/common/constants/language.dart';
import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
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
            NavigationListItem(
                title: TranslationConstants.favoriteMovies.translate(context),
                onPressed: () {}),
            NavigationExpandedListItem(
                title: TranslationConstants.language.translate(context),
                languages: Languages.languagesList),
            // NavigationExpandedListItem(
            //     title: TranslationConstants.displayMode.translate(context),
            //     onPressed: () {},
            //     children: const ['Dark Mode', 'Light Mode']),
            NavigationListItem(
                title: TranslationConstants.feedback.translate(context),
                onPressed: () {}),
            NavigationListItem(
                title: TranslationConstants.about.translate(context),
                onPressed: () {}),
            NavigationListItem(
                title: TranslationConstants.logout.translate(context),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
