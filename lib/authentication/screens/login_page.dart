import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../components/my_button.dart';
import '../../components/my_textfild.dart';
import '../../components/show_snackbar.dart';
import '../../components/square_tile.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  AuthService authService = AuthService();

// sign google user in method

  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }

// sign facebook user in method

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

// sign user in method
  void signUserIn() {
    _enterUser({required String email, required String senha}) {
      authService.loginUser(email: email, senha: senha).then((String? erro) {
        if (erro != null) {
          showSnackBar(context: context, mensagem: erro);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 46),

                // logo
                const Icon(
                  Icons.forest,
                  size: 128,
                  color: Color.fromARGB(255, 0, 90, 3),
                ),

                const SizedBox(height: 76),

                // welcome
                const Text(
                  'Bem Vindo!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 90, 3),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // username textfield
                MyTextField(
                  prefixIcon: Icons.email,
                  controller: usernameController,
                  hintText: 'Digite seu email',
                  obscureText: false,
                ),

                const SizedBox(height: 08),

                // password textfield
                MyTextField(
                  prefixIcon: Icons.lock,
                  controller: passwordController,
                  hintText: 'Digite sua senha',
                  obscureText: true,
                ),

                // forgot password?
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 5.0,
                  ),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: Colors.black),
                      )),

                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ), */
                ),

                // sign in button
                MyButton(
                  onTap: signUserIn,
                  text_button: 'Entrar',
                ),

                const SizedBox(height: 50),

                // or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Ou continue com',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // google / facebook / yahoo sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    GestureDetector(
                      onTap: signInWithGoogle,
                      child: SquareTite(imagePath: 'lib/assets/google.png'),
                    ),

                    const SizedBox(width: 15),

                    // facebook button
                    GestureDetector(
                      onTap: signInWithFacebook,
                      child: SquareTite(imagePath: 'lib/assets/facebook.png'),
                    ),

                    const SizedBox(width: 15),

                    // yahoo button
                    SquareTite(imagePath: 'lib/assets/yahoo.png'),
                  ],
                )

                // not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
