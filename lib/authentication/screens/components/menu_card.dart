import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String imagePath;
  final String title;

  MenuCard({
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Image.asset(
            imagePath,
            width: 300, // Define a largura da imagem conforme necessário
            height: 300, // Define a altura da imagem conforme necessário
          ),
        ),
        SizedBox(height: 35), // Adiciona um espaço entre a imagem e o texto
        Container(
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21, // Ajusta o tamanho da fonte conforme necessário
              fontWeight: FontWeight.bold,
              color: Colors.black, // Cor do texto
              fontStyle: FontStyle.normal, // Estilo do texto
              letterSpacing: 1.2, // Espaçamento entre letras
            ),
          ),
        ),
      ],
    );
  }
}
