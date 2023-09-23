import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String maskedText = _applyCpfMask(newValue.text);
    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: maskedText.length),
    );
  }

  String _applyCpfMask(String value) {
    // Remove qualquer caractere que não seja número
    value = value.replaceAll(RegExp(r'[^\d]'), '');

    if (value.length <= 3) {
      return value;
    } else if (value.length <= 6) {
      return '${value.substring(0, 3)}.${value.substring(3)}';
    } else if (value.length <= 9) {
      return '${value.substring(0, 3)}.${value.substring(3, 6)}.${value.substring(6)}';
    } else {
      return '${value.substring(0, 3)}.${value.substring(3, 6)}.${value.substring(6, 9)}-${value.substring(9)}';
    }
  }
}
