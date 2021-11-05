import 'package:custom_listview_with_json_data/data/models/movie_detail.dart';

class MovieResponse {
  late final List<MovieDetail> movieDetail;
  final int? page;
  final int? totalPages;
  final int? totalResults;


  MovieResponse({required this.movieDetail, this.page, this.totalPages, this.totalResults});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    var movieDetails = List<MovieDetail>.empty(growable: true);
    if (json['results'] != null) {
      json['results'].forEach((v) {
        final movieDetail = MovieDetail.fromJson(v);
        if (_isValidMovie(movieDetail)) {
          movieDetails.add(movieDetail);
        }
      });
    }
    return MovieResponse(
        page: json['page'],
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
        movieDetail: movieDetails
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = movieDetail.map((v) => v.toJson()).toList();
    data['page'] = page;
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

bool _isValidMovie(MovieDetail movieDetail) {
  return movieDetail.id != -1 &&
      movieDetail.title.isNotEmpty &&
      movieDetail.backdropPath.isNotEmpty &&
      movieDetail.posterPath.isNotEmpty;
}
