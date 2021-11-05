import 'package:custom_listview_with_json_data/data/core/tmdb_api_client.dart';
import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:custom_listview_with_json_data/data/models/movie_detail.dart';
import 'package:custom_listview_with_json_data/data/models/movie_result.dart';

abstract class TheMovieDBApi {
  //Future<List<MovieDetail>> getPopularMovieByPage(int page);
  Future<List<MovieDetail>> getPopularMovie();
  Future<List<MovieDetail>> getTrendingMovie();
  Future<List<MovieDetail>> getPlayingNowMovie();
  Future<List<MovieDetail>> getUpcomingMovieMovie();
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
  Future<List<MovieDetail>> getPopularMovie() async {
    final response = await _client.get(ApiConstants.POPULAR_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieDetail;
  }

  @override
  Future<List<MovieDetail>> getTrendingMovie() async {
    final response = await _client.get(ApiConstants.TRENDING_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieDetail;
  }

  @override
  Future<List<MovieDetail>> getPlayingNowMovie() async {
    final response = await _client.get(ApiConstants.PLAYING_NOW_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieDetail;
  }

  @override
  Future<List<MovieDetail>> getUpcomingMovieMovie() async {
    final response = await _client.get(ApiConstants.UPCOMING_MOVIE_PATH);
    return MovieResponse.fromJson(response).movieDetail;
  }
}