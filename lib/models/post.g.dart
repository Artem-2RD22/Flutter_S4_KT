// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      comment: json['comment'] as String,
      weather: Weather.fromJson(json['weather'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'comment': instance.comment,
      'weather': instance.weather,
    };
