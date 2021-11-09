import 'package:custom_listview_with_json_data/data/core/tmdb_api_client.dart';
import 'package:custom_listview_with_json_data/data/data_sources/tmdb_remote_data_source.dart';
import 'package:custom_listview_with_json_data/data/repositories/app_setting_repository_impl.dart';
import 'package:custom_listview_with_json_data/data/repositories/movie_repository_impl.dart';
import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_playing_now_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_popular_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_trending_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_upcoming_movie_use_case.dart';
import 'package:custom_listview_with_json_data/ui/blocs/app_language/app_language_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<TheMovieDBApi>(
      () => TheMovieDBApiImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));

  getItInstance.registerLazySingleton<AppSettingRepository>(
          () => AppSettingRepositoryImpl());

  getItInstance.registerLazySingleton<GetTrendingMovieUseCase>(
      () => GetTrendingMovieUseCase(getItInstance()));

  getItInstance.registerLazySingleton<GetPopularMovieUseCase>(
      () => GetPopularMovieUseCase(getItInstance()));

  getItInstance.registerLazySingleton<GetUpcomingMovieUseCase>(
      () => GetUpcomingMovieUseCase(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNowMovieUseCase>(
      () => GetPlayingNowMovieUseCase(getItInstance()));

  getItInstance.registerFactory(
    () => MovieCarouselBloc(
        getTrendingMovieUseCase: getItInstance(),
        movieBackdropBloc: getItInstance()),
  );

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(() => MovieTabBloc(
      getPlayingNowMovieUseCase: getItInstance(),
      getPopularMovieUseCase: getItInstance(),
      getUpcomingMovieUseCase: getItInstance()));

  getItInstance.registerLazySingleton<AppLanguageBloc>(() => AppLanguageBloc(getItInstance()));
}
