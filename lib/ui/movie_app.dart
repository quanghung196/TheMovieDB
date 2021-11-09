import 'package:custom_listview_with_json_data/common/constants/language.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/ui/app_localizations.dart';
import 'package:custom_listview_with_json_data/ui/blocs/app_language/app_language_bloc.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_color.dart';
import 'package:custom_listview_with_json_data/ui/themes/theme_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'journeys/home/home_screen.dart';

class TheMovieDBApp extends StatefulWidget {
  const TheMovieDBApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TheMovieDBAppState();
}

class _TheMovieDBAppState extends State<TheMovieDBApp> {
  late AppLanguageBloc appLanguageBloc;

  @override
  void initState() {
    super.initState();
    appLanguageBloc = getItInstance<AppLanguageBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    appLanguageBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return BlocProvider(
      create: (context) => appLanguageBloc,
      child: BlocBuilder<AppLanguageBloc, AppLanguageState>(
        builder: (context, state) {
          late Locale locale;
          if (state is AppLanguageChanged) {
            locale = Locale(state.locale.languageCode);
          } else {
            locale = Locale(appLanguageBloc.loadPreferredLanguage());
          }
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
            supportedLocales: Languages.languagesList
                .map((e) => Locale(e.languageCode))
                .toList(),
            locale: locale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
