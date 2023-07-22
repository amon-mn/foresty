import 'package:flutter/material.dart';
import '../../components/my_textfild.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  // text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 46),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // logo
                    Icon(
                      Icons.forest,
                      size: 80,
                      color: Color.fromARGB(255, 0, 90, 3),
                    ),
                    // welcome
                    Text(
                      'Cadastro',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 90, 3),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                //
                const Text(
                  'Dados pessoais',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 90, 3),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                MyTextField(
                  controller: nameController,
                  hintText: 'Nome completo',
                  obscureText: false,
                ),
                const SizedBox(height: 08),
                MyTextField(
                  controller: emailController,
                  hintText: 'Digite seu e-mail',
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O valor de e-mail deve ser preenchido";
                    }
                    if (!value.contains("@") ||
                        !value.contains(".") ||
                        value.length < 4) {
                      return "O valor do e-mail deve ser válido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 08),
                MyTextField(
                  controller: cpfController,
                  hintText: 'Digite seu CPF',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "O valor do CPF deve ser preenchido";
                    }
                    // Remove quaisquer caracteres não numéricos do valor do CPF
                    final cleanCPF = value.replaceAll(RegExp(r'\D'), '');
                    // Verifica se o CPF possui 11 dígitos
                    if (cleanCPF.length != 11) {
                      return "O CPF deve conter exatamente 11 dígitos";
                    }
                    // Verifica se todos os dígitos são iguais (CPF inválido)
                    if (RegExp(r'^(\d)\1*$').hasMatch(cleanCPF)) {
                      return "CPF inválido";
                    }
                    // Algoritmo de validação do CPF
                    var sum = 0;
                    for (var i = 0; i < 9; i++) {
                      sum += int.parse(cleanCPF[i]) * (10 - i);
                    }
                    var remainder = (sum * 10) % 11;
                    if (remainder == 10 ||
                        remainder == int.parse(cleanCPF[9])) {
                      sum = 0;
                      for (var i = 0; i < 10; i++) {
                        sum += int.parse(cleanCPF[i]) * (11 - i);
                      }
                      remainder = (sum * 10) % 11;
                      if (remainder == 10 ||
                          remainder == int.parse(cleanCPF[10])) {
                        return null; // CPF válido
                      }
                    }
                    return "CPF inválido";
                  },
                ),
                const SizedBox(height: 08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
