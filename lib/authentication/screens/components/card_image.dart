import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;

  ImageCard({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        imagePath,
        width: 250, // Ajuste a largura da imagem conforme necessário
        height: 250, // Ajuste a altura da imagem conforme necessário
      ),
    );
  }
}
