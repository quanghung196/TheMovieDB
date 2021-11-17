import 'package:custom_listview_with_json_data/common/constants/route_constant.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_detail_screen_agrument.dart';
import 'package:custom_listview_with_json_data/domain/entities/screen_agruments/movie_watch_trailer_screen_agrument.dart';
import 'package:flutter/cupertino.dart';

import 'journeys/favourite_movie/favourite_movie_screen.dart';
import 'journeys/home/home_screen.dart';
import 'journeys/login/login_screen.dart';
import 'journeys/movie_detail/movie_detail_screen.dart';
import 'journeys/search_movie/search_movie_screen.dart';
import 'journeys/watch_trailer/watch_trailer_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings routeSettings) => {
        RouteList.LOGIN_SCREEN: (context) => const LoginScreen(),
        RouteList.HOME_SCREEN: (context) => const HomeScreen(),
        RouteList.MOVIE_DETAIL_SCREEN: (context) => MovieDetaiScreen(
            agrument: routeSettings.arguments as MovieDetaiScreenAgrument),
        RouteList.WATCH_TRAILER_SCREEN: (context) => MovieWatchTrailerScreen(
            agrument:
                routeSettings.arguments as MovieWatchTrailerScreenAgrument),
        RouteList.FAVOURITE_SCREEN: (context) => const FavouriteMovieScreen(),
        RouteList.SEARCH_SCREEN: (context) => const SearchMovieScreen(),
      };
}
