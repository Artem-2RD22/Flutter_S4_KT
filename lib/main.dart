import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/weather_viewmodel.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/post_viewmodel.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

// Основной виджет приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Добавляем модели в провайдер
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => PostViewModel()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(), // Главный экран приложения
      ),
    );
  }
}

// Виджет главного экрана приложения
class MainScreen extends StatefulWidget {
  static final GlobalKey<_MainScreenState> globalKey = GlobalKey<_MainScreenState>();

  MainScreen({Key? key}) : super(key: globalKey);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Индекс выбранной вкладки
  bool _isLoggedIn = false; // Флаг авторизации

  // Список виджетов для отображения в зависимости от выбранной вкладки
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  // Обработчик нажатий на элементы нижней навигации
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Метод для авторизации
  void _login() {
    setState(() {
      _isLoggedIn = true;
      _selectedIndex = 0;  // Переходим на главный экран после авторизации
    });
  }

  // Метод для выхода из системы
  void logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn
        ? Scaffold(
      body: Center(
        // Отображаем выбранный экран
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Нижняя навигация
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Погода',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
        currentIndex: _selectedIndex, // Текущий выбранный элемент
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped, // Обработчик нажатий
      ),
    )
        : LoginScreen(onLogin: _login); // Экран авторизации, если пользователь не авторизован
  }
}
