import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_i18n/flutter_i18n.dart';
import '../Components/mytextfield.dart';
import '../main.dart';

class VocabularyPage extends StatefulWidget {
  VocabularyPage({super.key});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();

  final user = FirebaseAuth.instance.currentUser!;
}

class _VocabularyPageState extends State<VocabularyPage> {
  final vocabularyEnglishController = TextEditingController();
  final vocabularyChineseController = TextEditingController();
  final translateController = TextEditingController();

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> showAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[600],
          content: SizedBox(
            width: 280, // 减小AlertDialog的宽度
            height: 200, // 减小AlertDialog的高度
            child: Column(
              children: [
                const Center(
                  child: Text(
                    '新增單字',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300, // 設置寬度
                  height: 50, // 設置高度
                  child: MyTextField(
                    controller: vocabularyEnglishController,
                    hintText: '英文',
                    obscureText: false,
                  ),
                ),
                const Icon(
                  Icons.autorenew,
                  size: 40,
                ),
                SizedBox(
                  width: 300, // 設置寬度
                  height: 50, // 設置高度
                  child: MyTextField(
                    controller: vocabularyChineseController,
                    hintText: '中文',
                    obscureText: false,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '取消',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '確定',
                style: TextStyle(fontSize: 20, color: Colors.white),
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
      appBar: AppBar(
        title: const Text("收藏單字",
            style: TextStyle(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.grey[800],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                showAlert(context);
              },
              icon: const Icon(
                Icons.add,
                size: 40,
              )),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
            color: Colors.white,
          )
        ],
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
      backgroundColor: Colors.grey[300],
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
