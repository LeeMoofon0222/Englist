import 'package:flutter/material.dart';
import 'package:gt_test_app/Components/mybutton.dart';
import 'package:gt_test_app/Components/square_tile.dart';
import '../Components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void sign() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Icon(
                Icons.lock,
                size: 80,
              ),
              const SizedBox(height: 10),
              Text(
                "歡迎回來!",
                style: TextStyle(color: Colors.grey[700], fontSize: 25),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: emailController,
                hintText: '電子郵件',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: '密碼',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '忘記密碼?',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                onTap: sign,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.8,
                      color: Colors.grey[800],
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        '使用其他帳號登入',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.8,
                      color: Colors.grey[800],
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: 'lib/images/google.png'),
                  SizedBox(width: 40),
                  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '還沒有帳號?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '現在註冊',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
