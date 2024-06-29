import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()

class Weather {
  final double latitude; // Широта
  final double longitude; // Долгота
  final double temperature; // Температура
  final double windSpeed; // Скорость ветра


  Weather({
    required this.latitude,
    required this.longitude,
    required this.temperature,
    required this.windSpeed,
  });

  // Cоздание объекта Weather из JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    // Проверка на null
    final latitude = (json['latitude'] as num?)?.toDouble();
    final longitude = (json['longitude'] as num?)?.toDouble();
    final temperature = (json['current']['temperature_2m'] as num?)?.toDouble();
    final windSpeed = (json['current']['wind_speed_10m'] as num?)?.toDouble();
    // Генерация ошибки, если значение null
    if (latitude == null) {throw TypeError();}
    if (longitude == null) {throw TypeError();}
    if (temperature == null) {throw TypeError();}
    if (windSpeed == null) {throw TypeError();}

    return Weather(
      latitude: latitude,
      longitude: longitude,
      temperature: temperature,
      windSpeed: windSpeed,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}