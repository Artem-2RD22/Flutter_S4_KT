import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {
  Weather? _currentWeather; // Текущая погода
  bool _isConnected = true; // Флаг состояния соединения
  Future<void>? _weatherFuture; // Результат для получения погоды

  // Геттеры для доступа к текущей погоде, состоянию соединения и результату получения
  Weather? get currentWeather => _currentWeather;
  bool get isConnected => _isConnected;
  Future<void>? get weatherFuture => _weatherFuture;

  // Конструктор, загружающий погоду
  WeatherViewModel() {
    _checkConnectivityAndFetchWeather();
  }

  // Загрузка погоды
  Future<void> _checkConnectivityAndFetchWeather() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      _isConnected = false;
      notifyListeners();
      return;
    }

    _isConnected = true;
    _weatherFuture = _fetchWeather(); // Получение погоды
    notifyListeners();
  }

  // Метод для получения погоды
  Future<void> _fetchWeather() async {
    try {
      final weather = await WeatherService().fetchWeather();
      _currentWeather = weather; // Устанавливаем текущую погоду
      notifyListeners();
    } catch (e) {
      print("Ошибка при получении погоды: $e");
      _isConnected = false;
      notifyListeners();
    }
  }
}
