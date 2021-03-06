import 'package:custom_listview_with_json_data/common/constants/language_constant.dart';
import 'package:custom_listview_with_json_data/common/constants/route_constant.dart';
import 'package:custom_listview_with_json_data/common/screenutil/screenutil.dart';
import 'package:custom_listview_with_json_data/di/get_it.dart';
import 'package:custom_listview_with_json_data/presentation/route.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_color.dart';
import 'package:custom_listview_with_json_data/presentation/themes/theme_text.dart';
import 'package:custom_listview_with_json_data/presentation/wiredash_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';
import 'blocs/app_language/app_language_bloc.dart';
import 'blocs/loading/loading_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'fade_page_route_builder.dart';
import 'journeys/loading/loading_screen.dart';

class TheMovieDBApp extends StatefulWidget {
  const TheMovieDBApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TheMovieDBAppState();
}

class _TheMovieDBAppState extends State<TheMovieDBApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLanguageBloc _appLanguageBloc;
  late LoginBloc _loginBloc;
  late LoadingBloc _loadingBloc;

  @override
  void initState() {
    super.initState();
    _appLanguageBloc = getItInstance<AppLanguageBloc>();
    _loginBloc = getItInstance<LoginBloc>();
    _loadingBloc = getItInstance<LoadingBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _appLanguageBloc.close();
    _loginBloc.close();
    _loadingBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => _appLanguageBloc,
        ),
        BlocProvider(
          create: (context) => _loginBloc,
        ),
        BlocProvider(
          create: (context) => _loadingBloc,
        )
      ],
      child: BlocBuilder<AppLanguageBloc, AppLanguageState>(
        builder: (context, state) {
          late Locale locale;
          if (state is AppLanguageChanged) {
            locale = Locale(state.locale.languageCode);
          } else {
            locale = Locale(_appLanguageBloc.loadPreferredLanguage());
          }
          return WiredashApp(
              navigatorKey: _navigatorKey,
              languageCode: locale.languageCode,
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'TheMovieDB',
                theme: ThemeData(
                  unselectedWidgetColor: AppColor.royalBlue,
                  primaryColor: AppColor.vulcan,
                  scaffoldBackgroundColor: AppColor.vulcan,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  textTheme: ThemeText.getDarkTextTheme(),
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
                builder: (context, child) {
                  return LoadingScreen(screen: child!);
                },
                initialRoute: _loginBloc.getSessionID().isNotEmpty
                    ? RouteList.HOME_SCREEN
                    : RouteList.LOGIN_SCREEN,
                onGenerateRoute: (RouteSettings routeSettings) {
                  final routes = Routes.getRoutes(routeSettings);
                  final WidgetBuilder? builder = routes[routeSettings.name];
                  return FadePageRouteBuilder(
                    builder: builder!,
                    settings: routeSettings,
                  );
                },
              ));
        },
      ),
    );
  }
}
