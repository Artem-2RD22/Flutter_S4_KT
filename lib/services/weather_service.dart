import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  final String apiUrl = 'https://api.open-meteo.com/v1/forecast?latitude=55.75&longitude=37.62&current=temperature_2m,wind_speed_10m';

  Future<Weather> fetchWeather() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        return Weather.fromJson(json.decode(response.body));
      } catch (e) {
        print("Ошибка обработки данных: $e");
        throw e;
      }
    } else {
      throw Exception('Ошибка загрузки погоды');
    }
  }
}
