import 'package:flutter/material.dart';

import '../main.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('測驗'),
        backgroundColor: Colors.green[900],
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/mountain.jpg'),
            const Positioned(
              bottom: 545,
              right: 255,
              child: Text(
                "步道人數:312人",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 85,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  showAlertDialog(context,"73");
                },
              ),
            ),
            Positioned(
              bottom: 398,
              right: 60,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.red[600]),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"94");
                },
              ),
            ),
            Positioned(
              bottom: 140,
              right: 200,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"12");
                },
              ),
            ),
            Positioned(
              bottom: 435,
              right: 215,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"66");
                },
              ),
            ),
            Positioned(
              bottom: 35,
              right: 65,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
            Positioned(
              bottom: 190,
              right: 200,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
            Positioned(
              bottom: 395,
              right: 40,
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