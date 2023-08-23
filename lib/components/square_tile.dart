import 'package:flutter/material.dart';

class SquareTite extends StatelessWidget {
  final String imagePath;
  const SquareTite({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 195, 195, 195)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 30,
      ),
    );
  }
}
