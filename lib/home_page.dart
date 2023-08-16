import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foresty/authentication/screens/welcome_page.dart';
import 'authentication/services/auth_service.dart';
import 'components/show_password_confirmation_dialog.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // sign user out method
  void signUserOut() async {
    await AuthService().logout();
  }

  // Novo código para fazer logout com redirecionamento
  void handleLogout(BuildContext context) {
    AuthService().logout().then((String? erro) {
      if (erro == null) {
        // Logout bem-sucedido, redirecionar para a tela de boas-vindas
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      } else {
        // Lida com qualquer erro que possa ocorrer durante o logout
        print("Erro durante o logout: $erro");
        // Adicione aqui uma lógica para exibir uma mensagem de erro ao usuário, se necessário.
      }
    });
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
        title: Text('Teste'),
      ),
    );
  }
/*
          IconButton(
            onPressed: () => handleLogout(context), // Use o callback aqui
            icon: Icon(Icons.logout),
            color: Color.fromARGB(255, 0, 90, 3),
          )
        ],
*/

/*    
      body: Column(children: [
        // custom app bar

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 50,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // menu icon

              IconButton(
                onPressed: () => handleLogout(context), // Use o callback aqui
                color: Color.fromARGB(255, 0, 90, 3),
                icon: Image.asset(
                  'lib/assets/menu.png',
                  height: 45,
                ),
              ),

              // account icon
              IconButton(
                onPressed: () {},
                color: Colors.grey[800],
                icon: Icon(
                  Icons.person,
                  size: 45,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // welcome home foresty
        Text(
          "Bem Vindo",
          style: TextStyle(fontSize: 20),
        ),
        Text(
          widget.user.displayName!,
          style: TextStyle(fontSize: 20),
        )

        // my forms
      ]),
    );
  }
*/

/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person),
            color: Color.fromARGB(255, 0, 90, 3),
          ),
          IconButton(
            onPressed: () => handleLogout(context), // Use o callback aqui
            icon: Icon(Icons.logout),
            color: Color.fromARGB(255, 0, 90, 3),
          )
        ],
      ),
      body: Center(
        child: Text(
          "Login realizado por " + widget.user.email!,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
*/
}
