import 'package:custom_listview_with_json_data/data/core/tmdb_api_constants.dart';
import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final int id;
  final String name;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;

  const CastEntity(
      {required this.id,
      required this.name,
      required this.profilePath,
      required this.castId,
      required this.character,
      required this.creditId});

  String loadCastImageProfile() {
    return ApiConstants.BASE_IMAGE_URL + profilePath;
  }

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}
