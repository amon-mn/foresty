import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyTextFieldForm extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;
  final MaskTextInputFormatter? inputFormatter;
  final VoidCallback? onSuffixIconPressed;

  MyTextFieldForm({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.inputFormatter,
    this.onSuffixIconPressed,
  }) : super(key: key);

  @override
  _MyTextFieldFormState createState() => _MyTextFieldFormState();
}

class _MyTextFieldFormState extends State<MyTextFieldForm> {
  bool isFilled = false;
  bool isInvalid = false;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        style: TextStyle(fontSize: 16 * textScaleFactor),
        inputFormatters:
            widget.inputFormatter != null ? [widget.inputFormatter!] : [],
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          alignLabelWithHint: false, // Alinha o texto do hintText à esquerda
          contentPadding: EdgeInsets.only(
              left: 8, right: 8, bottom: 8), // Ajusta o espaçamento
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Colors.transparent), // Borda transparente nos lados
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(
                    255, 0, 103, 3)), // Borda inferior quando em foco
          ),
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Color.fromARGB(255, 0, 90, 3),
          ),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: Icon(widget.suffixIcon),
                  color: Color.fromARGB(255, 0, 90, 3),
                  onPressed: widget.onSuffixIconPressed,
                )
              : null,
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: isFilled ? null : widget.hintText,
          labelText: isFilled || isInvalid ? widget.hintText : null,
          labelStyle: TextStyle(
            color: isInvalid ? Colors.red : Colors.green[800],
          ),
        ),
        validator: (value) {
          final validationError = widget.validator?.call(value);
          setState(() {
            isInvalid = validationError != null;
          });
          return validationError;
        },
        onChanged: (value) {
          setState(() {
            isFilled = value.isNotEmpty;
          });
        },
      ),
    );
  }
}
