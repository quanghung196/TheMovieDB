import 'package:custom_listview_with_json_data/domain/entities/movie_account_state_entity.dart';

class MovieAccountStateModel {
  final int id;
  final bool favorite;
  final bool rated;
  final bool watchlist;

  MovieAccountStateModel(
      {required this.id,
      required this.favorite,
      required this.rated,
      required this.watchlist});

  MovieAccountStateEntity toEntity() {
    return MovieAccountStateEntity(id: id, favorite: favorite);
  }

  factory MovieAccountStateModel.fromJson(Map<String, dynamic> json) {
    return MovieAccountStateModel(
        id: json['id'],
        favorite: json['favorite'],
        rated: json['rated'],
        watchlist: json['watchlist']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['favorite'] = favorite;
    data['rated'] = rated;
    data['watchlist'] = watchlist;
    return data;
  }
}
