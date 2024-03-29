import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/authentication/screens/adm_info_page.dart';
import 'package:foresty/authentication/screens/components/show_password_confirmation_dialog.dart';
import 'package:foresty/authentication/screens/welcome_page.dart';
import 'package:foresty/authentication/services/auth_service.dart';
import 'package:foresty/components/my_drawer.dart';
import 'package:foresty/firestore_batch/models/batch.dart';

class AdmPage extends StatefulWidget {
  final User user;
  final List<ProductBatch> listBatchs; // Adicione este parâmetro

  const AdmPage({Key? key, required this.user, required this.listBatchs})
      : super(key: key);

  @override
  State<AdmPage> createState() => _AdmPageState();
}

class _AdmPageState extends State<AdmPage> {
  // Chave global para o RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de ADM', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 90, 3),
      ),
      drawer: MyDrawer(
        listBatchs: [],
        user: widget.user,
        onLogout: () => handleLogout(context),
        onRemoveAccount: (email) {
          showDialog(
            context: context,
            builder: (context) {
              return PasswordConfirmationDialog(email: widget.user.email!);
            },
          );
        },
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: _buildUserList(),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    // Adicione aqui a lógica para recarregar os dados
    // Por exemplo, você pode chamar uma função que busca novamente os dados do Firebase
    // Aguarde a conclusão e, em seguida, chame o setState para reconstruir a UI
    await Future.delayed(
        Duration(seconds: 1)); // Simulando uma operação assíncrona
    setState(() {});
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Erro: ${snapshot.error}'),
          );
        }

        List<Widget> userListWidgets = [];
        snapshot.data!.docs.forEach((DocumentSnapshot document) {
          Map<String, dynamic> userData =
              document.data() as Map<String, dynamic>;
          String name = userData['name'];
          String cpf = userData['cpf'];
          String userId = document.id;

          userListWidgets.add(
            InkWell(
              onTap: () {
                _navigateToAdmInfoPage(userId);
              },
              child: Card(
                color: Colors.grey[200],
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nome: $name',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'CPF: $cpf',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
                ),
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AdmInfoPage(userId: userId),
      ),
    );
  }

  void handleLogout(BuildContext context) {
    AuthService().logout().then((String? erro) {
      if (erro == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      } else {
        print("Erro durante o logout: $erro");
      }
    });
  }
}
