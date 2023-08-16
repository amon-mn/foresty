import 'package:flutter/material.dart';
import '../authentication/screens/welcome_page.dart';
import '../authentication/services/auth_service.dart';

class PasswordConfirmationDialog extends StatefulWidget {
  final String email;

  PasswordConfirmationDialog({required this.email});

  @override
  _PasswordConfirmationDialogState createState() =>
      _PasswordConfirmationDialogState();
}

class _PasswordConfirmationDialogState
    extends State<PasswordConfirmationDialog> {
  TextEditingController senhaConfirmacaoController = TextEditingController();
  bool isSenhaValida = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Deseja remover a conta com o e-mail ${widget.email}?"),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            const Text(
              "Para confirmar a remoção da conta, insira sua senha:",
            ),
            TextFormField(
              obscureText: true,
              controller: senhaConfirmacaoController,
              onChanged: (value) {
                setState(() {
                  isSenhaValida = value.isNotEmpty;
                });
              },
              decoration: const InputDecoration(
                labelText: "Senha",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("CANCELAR"),
        ),
        TextButton(
          onPressed: isSenhaValida
              ? () {
                  AuthService()
                      .removeAccount(senha: senhaConfirmacaoController.text)
                      .then(
                    (String? erro) {
                      if (erro == null) {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WelcomeScreen()), // Redirecionar para a tela de boas-vindas
                          (route) => false,
                        );
                      }
                    },
                  );
                }
              : null,
          child: const Text("EXCLUIR CONTA"),
        ),
      ],
    );
  }
}
