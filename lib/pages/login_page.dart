import 'package:flutter/material.dart';
import 'package:gt_test_app/Components/mybutton.dart';
import 'package:gt_test_app/Components/square_tile.dart';
import 'package:gt_test_app/services/auth_service.dart';
import '../Components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void sign() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: Text(
            message,
            style: const TextStyle(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  void anoMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[300],
          title: const Text(
            "確定要以匿名帳號登入嗎",
            style: TextStyle(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '取消',
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AuthService().signInWithAnon();
              },
              child: const Text(
                '確定',
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
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
                Icons.menu_book,
                size: 100,
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
                text: "登入",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(
                      imagePath: 'lib/images/google.png',
                      onTap: () => AuthService().signInWithGoogle()),
                  const SizedBox(width: 40),
                  SquareTile(
                      imagePath: 'lib/images/Anonymous.png',
                      onTap: () => anoMessage())
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
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      '現在註冊',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
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
