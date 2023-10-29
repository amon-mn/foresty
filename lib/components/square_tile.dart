import 'package:flutter/material.dart';

class SquareTite extends StatelessWidget {
  final dynamic
      content; // Pode ser um IconData, um String (path da imagem) ou um Icon
  final bool isIcon; // Indica se o conteúdo é um ícone
  const SquareTite({
    super.key,
    required this.content,
    this.isIcon = false, // Por padrão, não é um ícone
  });

  @override
  Widget build(BuildContext context) {
    Widget childWidget;

    if (content is IconData) {
      childWidget = Icon(
        content,
        size: 30,
      );
    } else if (content is String) {
      childWidget = Image.asset(
        content,
        height: 30,
      );
    } else if (isIcon && content is Icon) {
      childWidget = content;
    } else {
      // Lida com outros tipos ou valores
      childWidget =
          const SizedBox(); // Ou qualquer outro widget padrão desejado
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 195, 195, 195)),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: childWidget,
    );
  }
}
