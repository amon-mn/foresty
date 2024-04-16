import 'package:flutter/material.dart';

class AskForPassword extends StatelessWidget {
  final Function(String) onPasswordEntered;

  AskForPassword({required this.onPasswordEntered});

  TextEditingController senhaConfirmacaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Digite sua senha"),
      content: TextFormField(
        obscureText: true,
        controller: senhaConfirmacaoController,
        decoration: const InputDecoration(
          labelText: "Senha",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            String senha = senhaConfirmacaoController.text;
            if (senha.isNotEmpty) {
              onPasswordEntered(senha);
              Navigator.pop(context);
            }
          },
          child: const Text("Confirmar"),
        ),
      ],
    );
  }
}
