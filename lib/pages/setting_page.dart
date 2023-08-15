import 'package:flutter/material.dart';

import '../main.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        backgroundColor: Colors.green[900],
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/SPmountain.jpg'),
            const Positioned(
              bottom: 0,
              right: 20,
              child: Text(
                "步道人數:36人",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
              bottom: 180,
              right: 292,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  showAlertDialog(context,"56");
                },
              ),
            ),
            Positioned(
              bottom: 325,
              right: 310,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"9");
                },
              ),
            ),
            Positioned(
              bottom: 180,
              right: 150,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}