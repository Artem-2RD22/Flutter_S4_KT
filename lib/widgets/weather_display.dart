import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/weather_viewmodel.dart';

class WeatherDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
      builder: (context, weatherViewModel, child) {
        if (!weatherViewModel.isConnected) {
          return Center(child: Text('Отсутствует соединение'));
        }

        return FutureBuilder(
          future: weatherViewModel.weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            } else if (weatherViewModel.currentWeather != null) {
              final weather = weatherViewModel.currentWeather!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Температура: ${weather.temperature}°C'),
                  Text('Долгота: ${weather.latitude}'),
                  Text('Широта: ${weather.longitude}'),
                  Text('Скорость ветра: ${weather.windSpeed} км/ч'),
                ],
              );
            } else {
              return Center(child: Text('Нет даных'));
            }
          },
        );
      },
    );
  }
}
