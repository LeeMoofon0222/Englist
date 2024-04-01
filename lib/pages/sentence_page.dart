import 'package:flutter/material.dart';

class SentencePage extends StatefulWidget {
  final String word;
  final String associateWord;
  final Function()? onTap;

  const SentencePage({super.key, required this.word, required this.associateWord, this.onTap});

  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Word and Sentence Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Word',
              style: TextStyle(color: Colors.indigo, fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              widget.word,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(height: 10),
            Text(
              widget.associateWord,
              style: const TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(height: 75),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 按鈕點擊事件
                },
                child: const Text(
                  'Generate New Sentence',
                  style: TextStyle(color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 75),
            const Text(
              'Sentence',
               style: TextStyle(color: Colors.indigo, fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Please don't do that shit.",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
            const SizedBox(height: 10),
            const Text(
              "拜託別做那種事",
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}