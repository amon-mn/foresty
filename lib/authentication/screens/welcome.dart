import 'package:flutter/material.dart';
import '../../components/my_button.dart';
import 'login_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // Modifique a função para utilizar o Navigator e navegar para a página de login
  void signUserIn(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Icon(
                  Icons.forest,
                  color: Color.fromARGB(255, 0, 90, 3),
                  size: 150,
                ),

                const SizedBox(height: 84),

               MyButton(
                onTap: () {signUserIn(context);},
                text_button: 'Login',
                ),

                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cadastro",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
