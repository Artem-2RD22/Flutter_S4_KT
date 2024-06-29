import 'package:json_annotation/json_annotation.dart';
import 'weather.dart';

part 'post.g.dart';

@JsonSerializable()

class Post {
  final String userId;
  final String userName;
  final String comment;
  final Weather weather;

  Post({
    required this.userId,
    required this.userName,
    required this.comment,
    required this.weather,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
