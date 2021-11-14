import 'package:custom_listview_with_json_data/data/core/tmdb_api_client.dart';
import 'package:custom_listview_with_json_data/data/data_sources/movie_local_data_source.dart';
import 'package:custom_listview_with_json_data/data/data_sources/movie_remote_data_source.dart';
import 'package:custom_listview_with_json_data/data/repositories/app_setting_repository_impl.dart';
import 'package:custom_listview_with_json_data/data/repositories/movie_repository_impl.dart';
import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:custom_listview_with_json_data/domain/repositories/movie_repository.dart';
import 'package:custom_listview_with_json_data/domain/usecases/check_if_movie_in_favourite_list_in_db_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/delete_movie_from_db_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_favourite_movie_from_db.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_movie_cast_list_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_movie_trailer_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_playing_now_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_popular_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_query_movie_list_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_trending_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/get_upcoming_movie_use_case.dart';
import 'package:custom_listview_with_json_data/domain/usecases/save_movie_to_db_use_case.dart';
import 'package:custom_listview_with_json_data/ui/blocs/app_language/app_language_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_cast_list/movie_cast_list_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_favourite/movie_favourite_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_tab/movie_tab_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/movie_trailer/movie_trailer_bloc.dart';
import 'package:custom_listview_with_json_data/ui/blocs/search_movie/search_movie_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());

  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AppSettingRepository>(
      () => AppSettingRepositoryImpl());

  //use case
  getItInstance.registerLazySingleton<GetTrendingMovieUseCase>(
      () => GetTrendingMovieUseCase(getItInstance()));

  getItInstance.registerLazySingleton<GetPopularMovieUseCase>(
      () => GetPopularMovieUseCase(getItInstance()));

  getItInstance.registerLazySingleton<GetUpcomingMovieUseCase>(
      () => GetUpcomingMovieUseCase(getItInstance()));

  getItInstance.registerLazySingleton<GetPlayingNowMovieUseCase>(
      () => GetPlayingNowMovieUseCase(getItInstance()));

  getItInstance.registerFactory<GetMovieCastListUseCase>(
      () => GetMovieCastListUseCase(getItInstance()));

  getItInstance.registerFactory<GetMovieTrailerUseCase>(
      () => GetMovieTrailerUseCase(getItInstance()));

  getItInstance.registerFactory<GetQueryMovieListUseCase>(
      () => GetQueryMovieListUseCase(getItInstance()));

  getItInstance.registerFactory<GetFavouriteMovieFromDBUseCase>(
      () => GetFavouriteMovieFromDBUseCase(getItInstance()));

  getItInstance.registerFactory<SaveMovieToDBUseCase>(
      () => SaveMovieToDBUseCase(getItInstance()));

  getItInstance.registerFactory<DeleteMovieFromDBUseCase>(
      () => DeleteMovieFromDBUseCase(getItInstance()));

  getItInstance.registerFactory<CheckIfMovieInFavouriteListInDBUseCase>(
      () => CheckIfMovieInFavouriteListInDBUseCase(getItInstance()));

  //bloc
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

  getItInstance.registerFactory(() => MovieCastListBloc(
      getMovieCastListUseCase: getItInstance(),
      movieTrailerBloc: getItInstance(),
      movieFavouriteBloc: getItInstance()));

  getItInstance.registerFactory(
      () => MovieTrailerBloc(getMovieTrailerUseCase: getItInstance()));

  getItInstance.registerFactory(
      () => SearchMovieBloc(getQueryMovieListUseCase: getItInstance()));

  getItInstance.registerLazySingleton<AppLanguageBloc>(
      () => AppLanguageBloc(getItInstance()));

  getItInstance.registerFactory(() => MovieFavouriteBloc(
      getFavouriteMovieFromDBUseCase: getItInstance(),
      checkIfMovieInFavouriteListInDBUseCase: getItInstance(),
      deleteMovieFromDBUseCase: getItInstance(),
      saveMovieToDBUseCase: getItInstance()));
}
