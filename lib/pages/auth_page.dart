import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gt_test_app/pages/Page_Or_Register_Page.dart';
import 'Login_Or_Register_Page.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  final DatabaseReference firebaseDB = FirebaseDatabase.instance.ref();



  void _set(email,uid) {
    Map<String, String> data = {"Email": email};
    firebaseDB
        .child("user")
        .child(uid)
        .set(data)
        .catchError((error) {
      print(error);
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
              if(user.email!=null){
                _set(user.email,user.uid);
              }
              else{
                _set("Anonymous",user.uid);
              }
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
