import 'package:flutter/material.dart';

class BigSquareTile extends StatelessWidget {
  final String imagePath;


  const BigSquareTile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(9),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200]),
        child: Image.asset(
          imagePath,
          height: 120,
          width: 120,
        ),
      ),
    );
  }
}
