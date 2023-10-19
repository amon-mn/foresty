import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/components/product.dart';
import 'authentication/services/auth_service.dart';
import 'components/my_drawer.dart';
import 'components/show_password_confirmation_dialog.dart';
import 'authentication/screens/user_page.dart';
import 'authentication/screens/welcome_page.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future<void> fetchUserData(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    // Simula uma lista de produtos (substitua por seus próprios dados)
    final List<Map<String, String>> products = [
      {
        'title': 'Produto 1',
        'description': 'Descrição do Produto 1',
      },
      {
        'title': 'Produto 2',
        'description': 'Descrição do Produto 2',
      },
      // Adicione mais produtos conforme necessário
    ];

    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: MyDrawer(
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
      appBar: AppBar(
        title: const Text('Meus Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async {
              fetchUserData(widget.user.uid).then((userData) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPage(
                      email: widget.user.email!,
                    ),
                  ),
                );
              }).catchError((error) {
                // Lidar com erros aqui, se necessário.
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductWidget(
              title: product['title']!,
              description: product['description']!,
            );
          },
        ),
        /*Center(
          child: Column(
            children: [
              Icon(Icons.error_outline, size: 128),
              Text(
                'Você ainda não possui produtos',
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
        */
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contextNew) => FormScreen(
                        taskContext: context,
                      ))).then((value) => setState(() {
                print('Recarregando a Tela Inicial');
              }));
              */
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
