import 'package:custom_listview_with_json_data/common/constants/size_constants.dart';
import 'package:custom_listview_with_json_data/common/constants/translation_constants.dart';
import 'package:custom_listview_with_json_data/common/extensions/size_extensions.dart';
import 'package:custom_listview_with_json_data/common/extensions/string_extensions.dart';
import 'package:custom_listview_with_json_data/ui/blocs/search_movie/search_movie_bloc.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarWidget extends StatefulWidget {

  const SearchBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();
  String _inputText = '';

  static const styleActive = TextStyle(color: Colors.white);
  static const styleHint = TextStyle(color: Color(0xFF5D5F65));


  @override
  Widget build(BuildContext context) {
    final style = _inputText.isEmpty ? styleHint : styleActive;

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: Sizes.dimen_4.h, horizontal: Sizes.dimen_20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.dimen_12.w),
        color: AppColor.darkVulcan,
        border: Border.all(color: Colors.black26),
      ),
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: _inputText.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    _controller.clear();
                    setState(() {
                      _inputText = _controller.text;
                    });
                  },
                )
              : null,
          hintText: TranslationConstants.search.translate(context),
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          if(value.isNotEmpty){
            FocusScope.of(context).unfocus();
            BlocProvider.of<SearchMovieBloc>(context)
                .add(MovieQuerySubmitedEvent(queryText: value));
          }
        },
        onChanged: (content) {
          setState(() {
            _inputText = content;
          });
        },
      ),
    );
  }
}
