import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String name, key;
  final String? type;

  const VideoEntity({
    required this.name,
    required this.key,
    this.type,
  });

  @override
  List<Object> get props => [name];

  @override
  bool get stringify => true;
}
