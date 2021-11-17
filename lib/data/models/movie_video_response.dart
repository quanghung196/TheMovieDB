import 'package:custom_listview_with_json_data/domain/entities/video_entity.dart';

class MovieVideoResponse {
  final int id;
  final List<VideoModel> videoList;

  MovieVideoResponse({required this.id, required this.videoList});

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) {
    var videos = List<VideoModel>.empty(growable: true);
    if (json['results'] != null) {
      json['results'].forEach((v) {
        videos.add(VideoModel.fromJson(v));
      });
    }

    return MovieVideoResponse(id: json['id'], videoList: videos);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['results'] = videoList.map((v) => v.toJson()).toList();
    return data;
  }
}

class VideoModel {
  final String? id;
  final String? iso6391;
  final String? iso31661;
  final String key;
  final String name;
  final String? site;
  final int? size;
  final String type;

  const VideoModel({
    this.id,
    this.iso6391,
    this.iso31661,
    required this.key,
    required this.name,
    this.site,
    this.size,
    required this.type,
  }) : super();

  VideoEntity toEntity() {
    return VideoEntity(name: name, key: key);
  }

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      iso6391: json['iso_639_1'],
      iso31661: json['iso_3166_1'],
      key: json['key'] ?? '',
      name: json['name'] ?? '',
      site: json['site'],
      size: json['size'],
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['iso_639_1'] = iso6391;
    data['iso_3166_1'] = iso31661;
    data['key'] = key;
    data['name'] = name;
    data['site'] = site;
    data['size'] = size;
    data['type'] = type;
    return data;
  }
}
