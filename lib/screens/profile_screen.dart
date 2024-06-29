import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../viewmodels/user_viewmodel.dart';
import '../viewmodels/post_viewmodel.dart';
import '../viewmodels/weather_viewmodel.dart';
import '../models/post.dart';

// Экран профиля пользователя
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'), // Заголовок AppBar
      ),
      body: Column(
        children: [
          Expanded(child: UserProfile()), // Виджет профиля пользователя
          Expanded(child: UserPosts()), // Виджет постов пользователя
        ],
      ),
    );
  }
}

// Виджет профиля пользователя
class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  XFile? _image; // Выбранное изображение
  String? _imagePath; // Путь к изображению

  @override
  void initState() {
    super.initState();
    _loadImage(); // Загрузка изображения при инициализации
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('user_photo');
    if (imagePath != null) {
      setState(() {
        _imagePath = imagePath;
        _image = XFile(imagePath); // Устанавливаем изображение из сохраненного пути
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); // Выбор изображения из галереи
    if (image != null) {
      setState(() {
        _image = image;
        _imagePath = image.path;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_photo', image.path); // Сохранение пути изображения
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, userViewModel, child) {
        return FutureBuilder(
          future: userViewModel.userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Отображение загрузки
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}')); // Отображение ошибки
            } else if (userViewModel.users.isEmpty) {
              return Center(child: Text('Нет данных о пользователе'));
            } else {
              final user = userViewModel.users.first; // Предполагаем, что первый пользователь авторизован
              return Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _imagePath != null
                        ? FileImage(File(_imagePath!))
                        : AssetImage(user.photoUrl) as ImageProvider, //Отображение изображения
                  ),
                  SizedBox(height: 20),
                  Text(user.name), // Имя пользователя
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Выбрать фото'), // Кнопка выбора изображения
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}

// Виджет постов пользователя
class UserPosts extends StatelessWidget {
  final TextEditingController _commentController = TextEditingController(); // Контроллер для ввода комментариев

  UserPosts({Key? key}) : super(key: key);

  void _publishPost(BuildContext context) {
    final weatherViewModel = Provider.of<WeatherViewModel>(context, listen: false);
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if (weatherViewModel.currentWeather == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Нет данных о погоде')), // Показ уведомления, если данные о погоде отсутствуют
      );
      return;
    }

    final user = userViewModel.users.first;
    final comment = _commentController.text;
    final weather = weatherViewModel.currentWeather!;

    final newPost = Post(
      userId: user.id,
      userName: user.name,
      comment: comment,
      weather: weather,
    );

    postViewModel.addPost(newPost); // Добавление нового поста

    _commentController.clear(); // Очистка текстового поля
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserViewModel, PostViewModel>(
      builder: (context, userViewModel, postViewModel, child) {
        if (userViewModel.users.isEmpty) {
          return Center(child: CircularProgressIndicator()); // Отображение загрузки
        }

        final user = userViewModel.users.first;
        final userPosts = postViewModel.getPostsByUserId(user.id); // Получение постов пользователя

        return Column(
          children: [
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: 'Комментарий о погоде'), // Поле для ввода комментария
            ),
            ElevatedButton(
              onPressed: () => _publishPost(context),
              child: Text('Опубликовать'), // Кнопка для публикации поста
            ),
            Expanded(
              child: ListView.builder(
                itemCount: userPosts.length, // Количество постов пользователя
                itemBuilder: (context, index) {
                  final post = userPosts[index];
                  return ListTile(
                    title: Text(post.userName), // Имя пользователя
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.comment), // Комментарий
                        Text('Температура: ${post.weather.temperature}°C'), // Температура
                        Text('Скорость ветра: ${post.weather.windSpeed} км/ч'), // Скорость ветра
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
