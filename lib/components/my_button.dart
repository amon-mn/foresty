import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text_button;

  const MyButton({Key? key, required this.onTap, required this.text_button})
      : super(key: key);

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: _isPressed ? Colors.green[700] : Colors.green[800], // Mudamos a cor quando o botão estiver pressionado
        borderRadius: BorderRadius.circular(15),
        boxShadow: _isPressed // Adicionamos uma sombra quando o botão estiver pressionado
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: Offset(0, 4),
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
            widget.text_button,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
