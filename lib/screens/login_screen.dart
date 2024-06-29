import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLogin;

  const LoginScreen({Key? key, required this.onLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: onLogin,
          child: Text('Войти'),
        ),
      ),
    );
  }
}