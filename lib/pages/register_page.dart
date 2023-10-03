import 'package:flutter/material.dart';
import 'package:gt_test_app/Components/mybutton.dart';
import 'package:gt_test_app/Components/square_tile.dart';
import '../Components/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signup() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      }
      else{
        showErrorMessage("密碼不相同");
      }
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
          title: Text(message,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,),
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
              const SizedBox(height: 20),
              const Icon(
                Icons.menu_book,
                size: 80,
              ),
              const SizedBox(height: 10),
              Text(
                "讓我們為您創建帳號",
                style: TextStyle(color: Colors.grey[700], fontSize: 25),
              ),
              const SizedBox(height: 10),
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
              MyTextField(
                controller: confirmPasswordController,
                hintText: '確認密碼',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              MyButton(
                text: "註冊",
                onTap: signup,
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
                  SquareTile(imagePath: 'lib/images/google.png',onTap: () => AuthService().signInWithGoogle()),
                  const SizedBox(width: 40),
                  SquareTile(imagePath: 'lib/images/apple.png',onTap: (){},)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '已經有帳號?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      '現在登入',
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
