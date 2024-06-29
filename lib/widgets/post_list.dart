import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../viewmodels/post_viewmodel.dart';

class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(
      builder: (context, postViewModel, child) {
        return FutureBuilder<List<Post>>(
          future: postViewModel.fetchPostsFuture(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Показ индикатора загрузки
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length, // Количество элементов в списке
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return ListTile(
                    title: Text(post.userName), // Имя пользователя
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.comment), // Комментарий пользователя
                        Text('Температура: ${post.weather.temperature}°C'),
                        Text('Скорость ветра: ${post.weather.windSpeed} км/ч'),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Нет данных'));
            }
          },
        );
      },
    );
  }
}
