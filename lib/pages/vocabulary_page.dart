import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class VocabularyPage extends StatelessWidget {
  VocabularyPage({super.key});
  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("收藏單字"),
        backgroundColor: Colors.grey[800],
        actions: [IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Colors.grey[300],
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
