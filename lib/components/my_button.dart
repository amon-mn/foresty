import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final VoidCallback onTap;
  final String textButton;
  final bool isRed; // Novo parâmetro

  const MyButton({
    Key? key,
    required this.onTap,
    required this.textButton,
    this.isRed = false, // Valor padrão para isRed
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  Color? getButtonColor() {
    if (_isPressed) {
      return widget.isRed ? Colors.red[700] : Colors.green[700];
    } else {
      return widget.isRed ? Colors.red[800] : Colors.green[800];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    // Ajustando o tamanho do texto com base na largura e altura da tela
    double textSize = screenWidth * 0.05; // Por exemplo, 5% da largura da tela
    
    return SizedBox(
      width: screenWidth,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: getButtonColor(),
          borderRadius: BorderRadius.circular(15),
          boxShadow: _isPressed
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ]
              : [],
        ),
        child: InkWell(
          onTap: widget.onTap,
          onTapDown: (_) {
            setState(() {
              _isPressed = true;
            });
          },
          onTapCancel: () {
            setState(() {
              _isPressed = false;
            });
          },
          onTapUp: (_) {
            setState(() {
              _isPressed = false;
            });
          },
          child: Center(
            child: Text(
              widget.textButton,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: textSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
