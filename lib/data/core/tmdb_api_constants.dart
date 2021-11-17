class ApiConstants {
  ApiConstants._();

  static const String BASE_URL = 'https://api.themoviedb.org/3/';
  static const String API_KEY = 'f64c520a006b21aa8ea0f224091f1bfc';
  static const String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';

  static const String GET_POPULAR_MOVIE_PATH = 'movie/popular';
  static const String GET_TRENDING_MOVIE_PATH = 'trending/movie/day';
  static const String GET_UPCOMING_MOVIE_PATH = 'movie/upcoming';
  static const String GET_PLAYING_NOW_MOVIE_PATH = 'movie/now_playing';
  static const String GET_MOVIE_DETAIL_PATH = 'movie/%s';
  static const String GET_MOVIE_CAST_PATH = 'movie/%s/credits';
  static const String GET_MOVIE_VIDEO_PATH = 'movie/%s/videos';
  static const String GET_MOVIE_SEARCH_PATH = 'search/movie';
  static const String GET_FAVOURITE_MOVIE_PATH = 'account/%s/favorite/movies';
  static const String GET_MOVIE_ACCOUNT_STATE_PATH = 'movie/%s/account_states';
  static const String POST_MOVIE_FAVOURITE_STATUS = 'account/%s/favorite';

  static const String GET_REQUEST_TOKEN_PATH = 'authentication/token/new';
  static const String POST_CREATE_LOGIN_SESSION_PATH =
      'authentication/token/validate_with_login';
  static const String POST_CREATE_SESSION_PATH = 'authentication/session/new';
  static const String DELETE_SESSION_PATH = 'authentication/session';

  static const String GET_ACCOUNT_PATH = 'account';
}
