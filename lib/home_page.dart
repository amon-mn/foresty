import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication/services/auth_service.dart';
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

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (snapshot.exists) {
      return snapshot.data()!;
    } else {
      return {}; // Retorna um mapa vazio se não houver dados no Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('lib/assets/perfil.png'),
                backgroundColor: Color.fromARGB(255, 33, 87, 25),
              ),
              accountName: Text(
                (widget.user.displayName != null)
                    ? widget.user.displayName!
                    : "",
              ),
              accountEmail: Text(widget.user.email!),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 33, 87, 25),
                    Color.fromARGB(255, 13, 95, 0)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: const Text("Remover conta"),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PasswordConfirmationDialog(
                        email: widget.user.email!);
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Sair"),
              onTap: () => handleLogout(context),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Foresty'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async {
              Map<String, dynamic> userData =
                  await fetchUserData(widget.user.uid);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPage(
                    displayName: widget.user.displayName!,
                    email: widget.user.email!,
                    userData: userData,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
