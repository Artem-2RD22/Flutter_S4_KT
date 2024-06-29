import 'package:flutter/material.dart';
import '../main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  // Метод для отображения диалога подтверждения выхода
  void _showLogoutConfirmation(BuildContext context, VoidCallback onLogout) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выход'),
          content: Text('Вы уверены что хотите выйти'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onLogout(); // Вызов функции выхода
              },
              child: Text('Выйти'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Настройки'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final mainScreenState = MainScreen.globalKey.currentState;
            if (mainScreenState != null) {
              _showLogoutConfirmation(context, mainScreenState.logout); // Показ диалога подтверждения выхода
            }
          },
          child: Text('Выйти'), // Текст кнопки выхода
        ),
      ),
    );
  }
}
