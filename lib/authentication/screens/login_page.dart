import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/home_page.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // username textfield
                        MyTextField(
                          prefixIcon: Icons.email,
                          controller: _emailController,
                          hintText: 'Digite seu email',
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "O e-mail deve ser preenchido";
                            }
                            if (!value.contains("@") ||
                                !value.contains(".") ||
                                value.length < 4) {
                              return "O e-mail precisa ser válido";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 08),
                        // password textfield
                        MyTextField(
                          prefixIcon: Icons.lock,
                          controller: _passwordController,
                          hintText: 'Digite sua senha',
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "A senha deve ser preenchida";
                            }
                            if (value.length < 6) {
                              return "A senha deve conter pelo menos 6 caracteres";
                            }
                            return null; // Retorna null se a validação for bem-sucedida
                          },
                        ),
                        // forgot password?
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35.0,
                            vertical: 5.0,
                          ),
                          child: TextButton(
                            onPressed: esqueciMinhaSenhaClicado,
                            child: const Text(
                              'Esqueceu a senha?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        // sign in button
                        MyButton(
                          onTap: signUserIn,
                          text_button: 'Entrar',
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
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
                        child: const SquareTite(
                            imagePath: 'lib/assets/google.png'),
                      ),

                      const SizedBox(width: 15),

                      // facebook button
                      GestureDetector(
                        onTap: signInWithFacebook,
                        child: const SquareTite(
                            imagePath: 'lib/assets/facebook.png'),
                      ),

                      const SizedBox(width: 15),

                      // yahoo button
                      const SquareTite(imagePath: 'lib/assets/yahoo.png'),
                    ],
                  )

                  // not a member? register now
                ],
              ),
            ),
          ),
        ),
      ),
      if (_isLoading)
        Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
    ]);
  }

// sign facebook user in method

  signInWithFacebook() async {
    try {
      // Iniciar o fluxo de login
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Criar uma credencial a partir do token de acesso
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Fazer login com a credencial
      await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((userCredential) {
        final User? user = userCredential.user;

        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(user: user),
            ),
          );
        }
      });
    } catch (error) {
      print("Erro durante o login com o Facebook: $error");
      showSnackBar(
        context: context,
        mensagem: "Erro durante o login com o Facebook.",
        isErro: true,
      );
    }
  }

// sign google user in method
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((userCredential) {
          final User? user = userCredential.user;

          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(user: user),
              ),
            );
          }
        });
      }
    } catch (error) {
      print("Erro durante o login com o Google: $error");
      showSnackBar(
        context: context,
        mensagem: "Erro durante o login com o Google.",
        isErro: true,
      );
    }
  }

// sign user in method
  void signUserIn() {
    String email = _emailController.text;
    String pass = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      authService.loginUser(email: email, password: pass).then((String? erro) {
        if (erro != null) {
          showSnackBar(context: context, mensagem: erro);
        } else {
          // Redirecionar para a tela principal após o login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  HomePage(user: FirebaseAuth.instance.currentUser!),
            ),
          );
        }
      });
    }
  }

  esqueciMinhaSenhaClicado() {
    String email = _emailController.text;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          TextEditingController redefinicaoSenhaController =
              TextEditingController(text: email);
          return AlertDialog(
            title: const Text("Confirme o e-mail para redefinição de senha."),
            content: TextFormField(
              controller: redefinicaoSenhaController,
              decoration: const InputDecoration(
                label: Text("Confirme o e-mail."),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  authService
                      .missPassword(email: redefinicaoSenhaController.text)
                      .then((String? erro) {
                    if (erro == null) {
                      showSnackBar(
                        context: context,
                        mensagem: "E-mail de redefinição enviado!",
                        isErro: false,
                      );
                    } else {
                      showSnackBar(context: context, mensagem: erro);
                    }
                    Navigator.pop(context);
                  });
                },
                child: const Text("Redefinir senha."),
              )
            ],
          );
        },
      );
    });
  }
}
