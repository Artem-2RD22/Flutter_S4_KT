import 'package:flutter/material.dart';
import '../models/post.dart';
import '../models/weather.dart';

class PostViewModel extends ChangeNotifier {
  List<Post> _posts = []; // Список постов

  List<Post> get posts => _posts; // Получение списка постов

  // Получение постов
  PostViewModel() {
    fetchPosts();
  }

  // Добавление поста
  void addPost(Post post) {
    _posts.add(post);
    notifyListeners();
  }

  // Метод для получения постов (фейковые данные)
  Future<void> fetchPosts() async {
    _posts = [
      Post(
        userId: '1',
        userName: 'Дмитрий',
        comment: 'Отличная погода!',
        weather: Weather(
          latitude: 55.75,
          longitude: 37.62,
          temperature: 26.4,
          windSpeed: 15.6,
        ),
      ),
      Post(
        userId: '2',
        userName: 'Жанна',
        comment: 'Сегодня ветренно',
        weather: Weather(
          latitude: 55.75,
          longitude: 37.62,
          temperature: 24.1,
          windSpeed: 12.3,
        ),
      ),
    ];
    notifyListeners();
  }

  // Получение постов
  Future<List<Post>> fetchPostsFuture() async {
    await fetchPosts();
    return _posts;
  }

  // Получение постов по ID
  List<Post> getPostsByUserId(String userId) {
    return _posts.where((post) => post.userId == userId).toList(); // Фильтр постов по ID
  }
}
