// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      temperature: (json['temperature'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'temperature': instance.temperature,
      'windSpeed': instance.windSpeed,
    };
