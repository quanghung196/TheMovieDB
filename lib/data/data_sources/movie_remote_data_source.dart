import 'package:custom_listview_with_json_data/data/core/tmdb_api_client.dart';
import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:custom_listview_with_json_data/data/models/movie_account_state_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_cast_and_crew_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_detail_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_video_response.dart';
import 'package:custom_listview_with_json_data/domain/repositories/app_setting_repository.dart';
import 'package:sprintf/sprintf.dart';

abstract class MovieRemoteDataSource {
  //Future<List<MovieDetail>> getPopularMovieByPage(int page);
  Future<List<MovieModel>> getPopularMovie();

  Future<List<MovieModel>> getTrendingMovie();

  Future<List<MovieModel>> getPlayingNowMovie();

  Future<List<MovieModel>> getUpcomingMovieMovie();

  Future<MovieDetailModel> getMovieDetail(int movieID);

  Future<List<CastModel>> getMovieCastList(int movieID);

  Future<List<VideoModel>> getMovieVideoList(int movieID);

  Future<List<MovieModel>> getQueryMovieList(String query);

  Future<List<MovieModel>> getFavouriteMovie(int page);

  Future<MovieAccountStateModel> getMovieAccountState(int movieID);

  Future<void> postMovieFavouriteStatus(bool isFavourite, int movieID);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;
  final AppSettingRepository _appSettingRepository;

  MovieRemoteDataSourceImpl(this._client, this._appSettingRepository);

  // @override
  // Future<List<MovieDetail>> getPopularMovieByPage(int page) {
  //   // TODO: implement getPopularMovieByPage
  //   throw UnimplementedError();
  // }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final response = await _client.get(ApiConstants.GET_POPULAR_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<MovieModel>> getTrendingMovie() async {
    final response = await _client.get(ApiConstants.GET_TRENDING_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<MovieModel>> getPlayingNowMovie() async {
    final response = await _client.get(ApiConstants.GET_PLAYING_NOW_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<MovieModel>> getUpcomingMovieMovie() async {
    final response = await _client.get(ApiConstants.GET_UPCOMING_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int movieID) async {
    final response = await _client
        .get(sprintf(ApiConstants.GET_MOVIE_DETAIL_PATH, [movieID.toString()]));
    return MovieDetailModel.fromJson(response);
  }

  @override
  Future<List<CastModel>> getMovieCastList(int movieID) async {
    final response = await _client
        .get(sprintf(ApiConstants.GET_MOVIE_CAST_PATH, [movieID.toString()]));
    return MovieCastAndCrewResponse.fromJson(response).castList;
  }

  @override
  Future<List<VideoModel>> getMovieVideoList(int movieID) async {
    final response = await _client
        .get(sprintf(ApiConstants.GET_MOVIE_VIDEO_PATH, [movieID.toString()]));
    return MovieVideoResponse.fromJson(response).videoList;
  }

  @override
  Future<List<MovieModel>> getQueryMovieList(String query) async {
    final response =
        await _client.get(ApiConstants.GET_MOVIE_SEARCH_PATH, params: {
      'query': query /*, 'language': 'vi'*/
    });
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<MovieModel>> getFavouriteMovie(int page) async {
    final accountID = _appSettingRepository.getAccountID();
    final response = await _client.get(
        sprintf(ApiConstants.GET_FAVOURITE_MOVIE_PATH, [accountID.toString()]),
        params: {
          'session_id': _appSettingRepository.getSessionID(),
          'page': page
        });
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<MovieAccountStateModel> getMovieAccountState(int movieID) async {
    final response = await _client.get(
        sprintf(
            ApiConstants.GET_MOVIE_ACCOUNT_STATE_PATH, [movieID.toString()]),
        params: {
          'session_id': _appSettingRepository.getSessionID(),
        });
    return MovieAccountStateModel.fromJson(response);
  }

  @override
  Future<void> postMovieFavouriteStatus(bool isFavourite, int movieID) async {
    final accountID = _appSettingRepository.getAccountID();
    final sessionID = _appSettingRepository.getSessionID();
    await _client.postWithParam(
        sprintf(
            ApiConstants.POST_MOVIE_FAVOURITE_STATUS, [accountID.toString()]),
        requestBody: {
          'media_type': 'movie',
          'media_id': movieID,
          'favorite': isFavourite,
        },
        params: {
          'session_id': sessionID
        });
  }
}
