import 'package:flutter/material.dart';

class MyDropdownFormField extends StatelessWidget {
  final String selectedValue;
  final List<String>? itemsList;
  final String labelText;
  final IconData? prefixIcon;
  final Function(String?)? onChanged;

  MyDropdownFormField({
    required this.selectedValue,
    this.itemsList,
    required this.onChanged,
    required this.labelText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items: itemsList?.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        icon: const Icon(
          Icons.arrow_drop_down_circle,
          color: Color.fromARGB(255, 0, 90, 3),
        ),
        dropdownColor: Colors.grey[100],
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
          fillColor: Colors.grey.shade100,
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors
                .black, // Cor do texto do rótulo quando não estiver selecionado
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
