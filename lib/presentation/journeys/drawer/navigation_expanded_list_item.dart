import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/domain/entities/language_entity.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/app_language/app_language_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_list_item.dart';

class NavigationExpandedListItem extends StatelessWidget {
  final String title;
  final List<LanguageEntity> languages;

  const NavigationExpandedListItem({
    Key? key,
    required this.title,
    required this.languages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 2,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        iconColor: AppColor.royalBlue,
        childrenPadding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
        children: [
          for (int i = 0; i < languages.length; i++)
            NavigationListItem(
              title: languages[i].languageValue.translate(context),
              onPressed: () {
                BlocProvider.of<AppLanguageBloc>(context)
                    .add(ToggleLanguageEvent(languages[i]));
              },
            ),
        ],
      ),
    );
  }
}
