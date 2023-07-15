import 'package:flutter/material.dart';
import '../Components/mytextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(height: 10),
              Text(
                "歡迎回來!",
                style: TextStyle(color: Colors.grey[700], fontSize: 25),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: usernameController,
                hintText: '帳號',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: '密碼',
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
