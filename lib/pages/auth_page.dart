import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:gt_test_app/pages/login_page.dart';
import 'package:gt_test_app/pages/vocabulary_page.dart';
import 'Login_Or_Register_Page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VocabularyPage(text: '',);
          }
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
