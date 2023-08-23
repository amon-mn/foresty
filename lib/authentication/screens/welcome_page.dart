import 'package:flutter/material.dart';
import 'package:foresty/authentication/screens/register_page.dart';
import 'package:foresty/components/my_textBytton.dart';
import '../../components/my_button.dart';
import 'login_page.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                  onTap: () {
                    goToUserLogin(context);
                  },
                  text_button: 'Login',
                ),
                MyTextButton(
                  onTap: () {
                    goToUserRegister(context);
                  },
                  textButton: 'Cadastro',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToUserLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  void goToUserRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(),
      ),
    );
  }
}
