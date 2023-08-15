import 'package:flutter/material.dart';
import '../main.dart';


class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('關於我'),
        backgroundColor: Colors.green[900],
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/APmountain.jpg'),
            const Positioned(
              bottom: 0,
              right: 15,
              child: Text(
                "步道人數:79人",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                ),
              ),
            ),
            Positioned(
              bottom: 200,
              right: 36,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.yellow[800]),
                onPressed: () {
                  showAlertDialog(context,"70");
                },
              ),
            ),
            Positioned(
              bottom: 280,
              right: 290,
              child: IconButton(
                icon: Icon(Icons.delete,color: Colors.red[600]),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"90");
                },
              ),
            ),
            Positioned(
              bottom: 145,
              right: 230,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // ignore: avoid_print
                  showAlertDialog(context,"11");
                },
              ),
            ),
            Positioned(
              bottom: 210,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.wc,color: Colors.pinkAccent,size: 30),
                onPressed: () {
                },
              ),
            ),
            Positioned(
              bottom: 260,
              right: 320,
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