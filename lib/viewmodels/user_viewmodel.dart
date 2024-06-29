import 'package:flutter/material.dart';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  List<User> _users = [];
  Future<void>? _userFuture;

  List<User> get users => _users;
  Future<void>? get userFuture => _userFuture;

  UserViewModel() {
    _userFuture = fetchUsers();
  }
//Фэйковые данные пользователей
  Future<void> fetchUsers() async {
    _users = [
      User(id: '1', name: 'Дмитрий', photoUrl: 'assets/images/male_user.png'),
      User(id: '2', name: 'Жанна', photoUrl: 'assets/images/female_user.png'),
    ];
    notifyListeners();
  }
}
