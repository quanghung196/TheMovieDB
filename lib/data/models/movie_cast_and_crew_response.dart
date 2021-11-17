import 'package:custom_listview_with_json_data/domain/entities/cast_entity.dart';

class MovieCastAndCrewResponse {
  final int id;
  final List<CastModel> castList;
  final List<CrewModel> crewList;

  MovieCastAndCrewResponse(
      {required this.id, required this.castList, required this.crewList});

  factory MovieCastAndCrewResponse.fromJson(Map<String, dynamic> json) {
    var castList = List<CastModel>.empty(growable: true);
    var crewList = List<CrewModel>.empty(growable: true);

    if (json['cast'] != null) {
      json['cast'].forEach((v) {
        castList.add(CastModel.fromJson(v));
      });
    }

    if (json['cast'] != null) {
      json['cast'].forEach((v) {
        crewList.add(CrewModel.fromJson(v));
      });
    }

    return MovieCastAndCrewResponse(
      id: json['id'],
      castList: castList,
      crewList: crewList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cast'] = castList.map((v) => v.toJson()).toList();
    data['crew'] = crewList.map((v) => v.toJson()).toList();
    return data;
  }
}

class CastModel {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  const CastModel(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.castId,
      required this.character,
      required this.creditId,
      required this.order})
      : super();

  CastEntity toEntity() {
    return CastEntity(
        id: id,
        name: name,
        profilePath: profilePath,
        castId: castId,
        character: character,
        creditId: creditId);
  }

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: json['popularity'],
      profilePath: json['profile_path'] ?? '',
      castId: json['cast_id'],
      character: json['character'],
      creditId: json['credit_id'] ?? '',
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['order'] = order;
    return data;
  }
}

class CrewModel {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final String creditId;
  final String department;
  final String job;

  CrewModel(
      {required this.adult,
      required this.gender,
      required this.id,
      required this.knownForDepartment,
      required this.name,
      required this.originalName,
      required this.popularity,
      required this.profilePath,
      required this.creditId,
      required this.department,
      required this.job});

  factory CrewModel.fromJson(Map<String, dynamic> json) {
    return CrewModel(
        adult: json['adult'],
        gender: json['gender'],
        id: json['id'],
        knownForDepartment: json['known_for_department'],
        name: json['name'] ?? '',
        originalName: json['original_name'],
        popularity: json['popularity'],
        profilePath: json['profile_path'] ?? '',
        creditId: json['credit_id'] ?? '',
        department: json['department'] ?? '',
        job: json['job']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['gender'] = gender;
    data['id'] = id;
    data['known_for_department'] = knownForDepartment;
    data['name'] = name;
    data['original_name'] = originalName;
    data['popularity'] = popularity;
    data['profile_path'] = profilePath;
    data['credit_id'] = creditId;
    data['department'] = department;
    data['job'] = job;
    return data;
  }
}
