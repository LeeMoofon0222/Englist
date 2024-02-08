import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gt_test_app/pages/Page_Or_Register_Page.dart';
import 'Login_Or_Register_Page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();



  void _set(uid) {
    firebaseDB
        .child("user")
        .child(uid)
        .once()  // 檢查節點是否存在
        .then((DatabaseEvent databaseEvent) {
      if (!databaseEvent.snapshot.exists) {
        // 只有在節點不存在時才進行設置
        firebaseDB
            .child("user")
            .child(uid)
            .set(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            final user = FirebaseAuth.instance.currentUser;

            if (user != null) {
                _set(user.uid);
            }
            return const PageOrRegisterPage();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
