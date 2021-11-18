import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/presentation/blocs/search_movie/search_movie_bloc.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatefulWidget {

  final TextEditingController searchBarController;

  const SearchBarWidget({
    Key? key, required this.searchBarController
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  static const styleActive = TextStyle(color: Colors.white);
  static const styleHint = TextStyle(color: AppColor.hint);

  @override
  Widget build(BuildContext context) {
    final style = widget.searchBarController.text.isEmpty ? styleHint : styleActive;

    return Container(
      alignment: Alignment.center,
      height: Sizes.dimen_24.h,
      margin: EdgeInsets.symmetric(
          vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_12.w),
        color: AppColor.lightVulcan,
        border: Border.all(color: Colors.black26),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      child: TextField(
        controller: widget.searchBarController,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.searchBarController.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(
                    Icons.close,
                    color: style.color,
                    size: Sizes.dimen_24.w,
                  ),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    widget.searchBarController.clear();
                  },
                )
              : null,
          hintText: TranslationConstants.search.translate(context),
          hintStyle: styleHint,
          border: InputBorder.none,
        ),
        style: styleActive,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).unfocus();
            BlocProvider.of<SearchMovieBloc>(context).refresh();
            BlocProvider.of<SearchMovieBloc>(context)
                .add(MovieQuerySubmitedEvent(queryText: value));
          }
        },
        onChanged: (content) {
          setState(() {});
        },
      ),
    );
  }
}
