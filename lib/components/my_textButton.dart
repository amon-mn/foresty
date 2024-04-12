import 'package:flutter/material.dart';

class MyTextButton extends StatefulWidget {
  final VoidCallback onTap;
  final String textButton;

  const MyTextButton({Key? key, required this.onTap, required this.textButton})
      : super(key: key);

  @override
  _MyTextButtonState createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.transparent, // Set the background color as transparent
        borderRadius: BorderRadius.circular(15),
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
              color: _isPressed ? Colors.blue[800] : Colors.blue[600],
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
