import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_viewmodel.dart';
import '../widgets/weather_display.dart';
import '../screens/user_profile_screen.dart';

// Экран главной страницы
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Погода'), // Заголовок AppBar
      ),
      body: Column(
        children: [
          Expanded(child: WeatherDisplay()), // Виджет для отображения погоды
          Expanded(
            child: Consumer<PostViewModel>(
              builder: (context, postViewModel, child) {
                return ListView.builder(
                  itemCount: postViewModel.posts.length, // Количество постов
                  itemBuilder: (context, index) {
                    final post = postViewModel.posts[index]; // Текущий пост
                    return ListTile(
                      title: Text(post.userName), // Имя пользователя
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.comment), // Комментарий
                          Text('Temperature: ${post.weather.temperature}°C'), // Температура
                          Text('Wind Speed: ${post.weather.windSpeed} km/h'), // Скорость ветра
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(userId: post.userId), // Переход к профилю пользователя
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
