import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/post_viewmodel.dart';
import '../viewmodels/user_viewmodel.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  UserProfileScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    final user = userViewModel.users.firstWhere((user) => user.id == userId);
    final userPosts = postViewModel.getPostsByUserId(userId);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          SizedBox(height: 20),
          Text(user.name),
          Expanded(
            child: ListView.builder(
              itemCount: userPosts.length,
              itemBuilder: (context, index) {
                final post = userPosts[index];
                return ListTile(
                  title: Text(post.userName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.comment),
                      Text('Температура: ${post.weather.temperature}°C'),
                      Text('Скорость ветра: ${post.weather.windSpeed} км/ч'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
