import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserPage extends StatefulWidget {
  final String email;

  const UserPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UserPage> {
  Map<String, dynamic> _userData = {}; // Inicializa com um mapa vazio

  @override
  void initState() {
    super.initState();
    fetchUserDataFromFirebase();
  }

  Future<void> fetchUserDataFromFirebase() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      setState(() {
        _userData = snapshot.data()!;
      });
    }
  }

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
              'Nome: ${_userData['name']}',
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
              'CPF: ${_userData['cpf']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Cidade: ${_userData['city']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Estado: ${_userData['state']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
