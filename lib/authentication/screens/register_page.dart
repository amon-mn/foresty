import 'package:flutter/material.dart';
import '../../components/my_textfild.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                const SizedBox(height: 8),
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
                const SizedBox(height: 8),
                MyTextField(
                  controller: cpfController,
                  hintText: 'Digite seu CPF',
                  obscureText: true,
                  validator: (value) {
                    // ... (código de validação do CPF aqui)
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
