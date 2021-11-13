import 'package:custom_listview_with_json_data/data/core/tmdb_api_client.dart';
import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:custom_listview_with_json_data/data/models/movie_cast_and_crew_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_response.dart';
import 'package:custom_listview_with_json_data/data/models/movie_video_response.dart';
import 'package:sprintf/sprintf.dart';

abstract class TheMovieDBApi {
  //Future<List<MovieDetail>> getPopularMovieByPage(int page);
  Future<List<MovieModel>> getPopularMovie();

  Future<List<MovieModel>> getTrendingMovie();

  Future<List<MovieModel>> getPlayingNowMovie();

  Future<List<MovieModel>> getUpcomingMovieMovie();

  Future<List<CastModel>> getMovieCastList(int movieID);

  Future<List<VideoModel>> getMovieVideoList(int movieID);

  Future<List<MovieModel>> getQueryMovieList(String query);
}

class TheMovieDBApiImpl extends TheMovieDBApi {
  final ApiClient _client;

  TheMovieDBApiImpl(this._client);

  // @override
  // Future<List<MovieDetail>> getPopularMovieByPage(int page) {
  //   // TODO: implement getPopularMovieByPage
  //   throw UnimplementedError();
  // }

  @override
  Future<List<MovieModel>> getPopularMovie() async {
    final response = await _client.get(ApiConstants.POPULAR_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<MovieModel>> getTrendingMovie() async {
    final response = await _client.get(ApiConstants.TRENDING_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<MovieModel>> getPlayingNowMovie() async {
    final response = await _client.get(ApiConstants.PLAYING_NOW_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<MovieModel>> getUpcomingMovieMovie() async {
    final response = await _client.get(ApiConstants.UPCOMING_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieList;
  }

  @override
  Future<List<CastModel>> getMovieCastList(int movieID) async {
    final response = await _client
        .get(sprintf(ApiConstants.MOVIE_CAST_PATH, [movieID.toString()]));
    return MovieCastAndCrewResponse.fromJson(response).castList;
  }

  @override
  Future<List<VideoModel>> getMovieVideoList(int movieID) async {
    final response = await _client
        .get(sprintf(ApiConstants.MOVIE_VIDEO_PATH, [movieID.toString()]));
    return MovieVideoResponse.fromJson(response).videoList;
  }

  @override
  Future<List<MovieModel>> getQueryMovieList(String query) async {
    final response = await _client
        .get(ApiConstants.MOVIE_SEARCH_PATH, params: {'query': query});
    return MovieResponse.fromJson(response).movieList;
  }
}
