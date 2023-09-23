import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final VoidCallback onTap;
  final String textButton;

  const MyButton({
    Key? key,
    required this.onTap,
    required this.textButton,
  }) : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textSize = screenWidth * 0.04; // Ajuste o fator conforme necessário

    return SizedBox(
      width: screenWidth,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _isPressed ? Colors.green[700] : Colors.green[800],
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
