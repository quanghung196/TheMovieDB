import 'package:custom_listview_with_json_data/domain/entities/movie_entity.dart';

class MovieResponse {
  late final List<MovieModel> movieList;
  final int? page;
  final int? totalPages;
  final int? totalResults;

  MovieResponse(
      {required this.movieList, this.page, this.totalPages, this.totalResults});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    var movieModels = List<MovieModel>.empty(growable: true);
    if (json['results'] != null) {
      json['results'].forEach((v) {
        final movieModel = MovieModel.fromJson(v);
        if (_isValidMovie(movieModel)) {
          movieModels.add(movieModel);
        }
      });
    }
    return MovieResponse(
        page: json['page'],
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
        movieList: movieModels);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = movieList.map((v) => v.toJson()).toList();
    data['page'] = page;
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

bool _isValidMovie(MovieModel movieModel) {
  return movieModel.id != -1 &&
      movieModel.title.isNotEmpty &&
      movieModel.backdropPath.isNotEmpty &&
      movieModel.posterPath.isNotEmpty;
}

class MovieModel extends MovieEntity {
  final int id;
  final bool? video;
  final int? voteCount;
  final double voteAverage;
  final String title;
  final String releaseDate;
  final String? originalLanguage;
  final String? originalTitle;
  final List<int> genreIds;
  final String backdropPath;
  final bool? adult;
  final String overview;
  final String posterPath;
  final double? popularity;
  final String? mediaType;

  const MovieModel({
    required this.id,
    this.video,
    this.voteCount,
    required this.voteAverage,
    required this.title,
    required this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    required this.genreIds,
    required this.backdropPath,
    this.adult,
    required this.overview,
    required this.posterPath,
    this.popularity,
    this.mediaType,
  }) : super(
      id: id,
      title: title,
      backdropPath: backdropPath,
      posterPath: posterPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
      overview: overview,
      genreIds: genreIds);

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      popularity: json['popularity']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'],
      video: json['video'],
      posterPath: json['poster_path'] ?? '',
      id: json['id'] ?? -1,
      adult: json['adult'],
      backdropPath: json['backdrop_path'] ?? '',
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      genreIds: json['genre_ids'].cast<int>(),
      title: json['title'] ?? '',
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      overview: json['overview'],
      releaseDate: json['release_date'],
      mediaType: json['media_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['video'] = video;
    data['vote_count'] = voteCount;
    data['vote_average'] = voteAverage;
    data['title'] = title;
    data['release_date'] = releaseDate;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['genre_ids'] = genreIds;
    data['backdrop_path'] = backdropPath;
    data['adult'] = adult;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['popularity'] = popularity;
    data['media_type'] = mediaType;
    return data;
  }

  @override
  String toString() {
    return 'MovieDetail{id: $id, video: $video, voteCount: $voteCount, voteAverage: $voteAverage, title: $title, releaseDate: $releaseDate, originalLanguage: $originalLanguage, originalTitle: $originalTitle, genreIds: $genreIds, backdropPath: $backdropPath, adult: $adult, overview: $overview, posterPath: $posterPath, popularity: $popularity, mediaType: $mediaType}';
  }
}
