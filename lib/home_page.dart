import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foresty/authentication/screens/welcome_page.dart';

import 'authentication/services/auth_service.dart';

class HomePage extends StatelessWidget {
  final User user;
  HomePage({super.key, required this.user});

  // sign user out method
  void signUserOut() async {
    await AuthService().logout();
  }

  // Novo código para fazer logout com redirecionamento
  void handleLogout(BuildContext context) async {
    String? error = await AuthService().logout();
    if (error == null) {
      // Logout bem-sucedido, redirecionar para a tela de boas-vindas
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (route) => false,
      );
    } else {
      // Lida com qualquer erro que possa ocorrer durante o logout
      print("Erro durante o logout: $error");
      // Adicione aqui uma lógica para exibir uma mensagem de erro ao usuário, se necessário.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => handleLogout(context), // Use o callback aqui
            icon: Icon(Icons.logout),
            color: Color.fromARGB(255, 0, 90, 3),
          )
        ],
      ),
      body: Center(
        child: Text(
          "Login realizado por " + user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
