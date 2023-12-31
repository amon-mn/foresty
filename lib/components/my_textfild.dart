import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final MaskTextInputFormatter? inputFormatter;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.validator,
    this.inputFormatter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        style: TextStyle(
            fontSize: 16 *
                textScaleFactor), // Ajuste o tamanho da fonte responsivamente
        inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: Color.fromARGB(255, 0, 90, 3),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 0, 103, 3)),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: hintText,
        ),
        validator:
            validator, // Usa o validator fornecido diretamente no TextFormField
      ),
    );
  }
}
