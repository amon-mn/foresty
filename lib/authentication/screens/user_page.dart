import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/components/my_row.dart';

class UserPage extends StatefulWidget {
  final String email;

  const UserPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
        title: Text('Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Voltar para a página anterior
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  MyRow(
                    title: 'Nome',
                    value: _userData['name'] ?? 'Não disponível',
                    icon: Icons.person,
                  ),
                  MyRow(
                    title: 'Email',
                    value: widget.email,
                    icon: Icons.email,
                  ),
                  MyRow(
                    title: 'CPF',
                    value: _userData['cpf'] ?? 'Não disponível',
                    icon: Icons.assignment_ind,
                  ),
                  MyRow(
                    title: 'Cidade',
                    value: _userData['city'] ?? 'Não disponível',
                    icon: Icons.location_city,
                  ),
                  MyRow(
                    title: 'Estado',
                    value: _userData['state'] ?? 'Não disponível',
                    icon: Icons.location_on,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
