import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;

  ImageCard({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 120, // Define a largura da imagem conforme necessário
            height: 120, // Define a altura da imagem conforme necessário
            child: Center(
              child: Image.asset(
                imagePath,
                width: 200, // Define a largura da imagem conforme necessário
                height: 200, // Define a altura da imagem conforme necessário
              ),
            ),
          ),
        ],
      ),
    );
  }
}
