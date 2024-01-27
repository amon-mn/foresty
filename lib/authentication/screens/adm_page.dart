import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/authentication/screens/adm_info_page.dart';

class AdmPage extends StatefulWidget {
  final User user;

  const AdmPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AdmPage> createState() => _AdmPageState();
}

class _AdmPageState extends State<AdmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela de ADM'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // ou outro indicador de carregamento
        }

        if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        }

        // Aqui você pode processar os dados e construir a lista de usuários
        List<Widget> userListWidgets = [];
        snapshot.data!.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> userData = document.data() as Map<String, dynamic>;
          String name = userData['name'];
          String cpf = userData['cpf'];
          String userId = document.id; // ID do documento

          userListWidgets.add(
            InkWell(
              onTap: () {
                _navigateToAdmInfoPage(userId);
              },
              child: ListTile(
                title: Text('Nome: $name'),
                subtitle: Text('CPF: $cpf'),
              ),
            ),
          );
        });

        return ListView(
          children: userListWidgets,
        );
      },
    );
  }

  void _navigateToAdmInfoPage(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdmInfoPage(userId: userId),
      ),
    );
  }
}