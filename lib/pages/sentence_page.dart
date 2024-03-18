import 'package:flutter/material.dart';

class SentencePage extends StatefulWidget {
  final String word;
  final Function()? onTap;
  const SentencePage({super.key, required this.word, this.onTap});

  @override
  State<SentencePage> createState() => _SentencePageState();
}

class _SentencePageState extends State<SentencePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

