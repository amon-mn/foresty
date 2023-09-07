import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final String displayName;
  final String email;
  final Map<String, dynamic> userData;

  const UserPage({
    Key? key,
    required this.displayName,
    required this.email,
    required this.userData,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Voltar para a página anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: ${widget.displayName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${widget.email}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Informações adicionais:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'CPF: ${widget.userData['cpf']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Cidade: ${widget.userData['city']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Estado: ${widget.userData['state']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
