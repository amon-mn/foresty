import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/components/show_password_confirmation_dialog.dart';

class CustomDrawer extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;
  final Function(String) onRemoveAccount;

  const CustomDrawer({
    required this.user,
    required this.onLogout,
    required this.onRemoveAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: 280,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('lib/assets/perfil.png'),
              backgroundColor: Color.fromARGB(255, 33, 87, 25),
            ),
            accountName: Text(
              (user.displayName != null) ? user.displayName! : "",
            ),
            accountEmail: Text(user.email!),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 33, 87, 25),
                  Color.fromARGB(255, 13, 95, 0),
                ],
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
                  return PasswordConfirmationDialog(email: user.email!);
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: onLogout,
          )
        ],
      ),
    );
  }
}
