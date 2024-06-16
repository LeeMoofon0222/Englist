import 'package:firebase_database/firebase_database.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;


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
      //_set("EmailAndPassword", emailController.text);
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
          backgroundColor: Colors.white,
          title: const Text(
            "Login with Anonymous ?\nRecords will not be saved",
            style: TextStyle(color: Colors.black, fontSize: 21, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'cancel',
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AuthService().signInWithAnon();
                //AuthPage("Anonymous", "Anonymous");
              },
              child: const Text(
                'yes',
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
                "Welcome Back",
                style: TextStyle(color: Colors.grey[700], fontSize: 25),
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: emailController,
                hintText: 'email',
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextField(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'forgot password?',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MyButton(
                text: "Login",
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
                        'login with another account',
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
                      onTap: () => anoMessage()),
                  const SizedBox(width: 40),
                  SquareTile(
                      imagePath: 'lib/images/facebook.png',
                      onTap: () => AuthService().signInWithFacebook())
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have no account? ',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'register now',
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
