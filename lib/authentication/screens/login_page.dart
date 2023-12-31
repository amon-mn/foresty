import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foresty/authentication/screens/add_info_user.dart';
import 'package:foresty/home_page.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthService authService = AuthService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            reverse: true,
            child: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 46),
                    const Icon(
                      Icons.forest,
                      size: 128,
                      color: Color.fromARGB(255, 0, 90, 3),
                    ),
                    const SizedBox(height: 76),
                    const Text(
                      'Bem Vindo!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 90, 3),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
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
                            const SizedBox(height: 8),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35.0,
                                vertical: 5.0,
                              ),
                              child: TextButton(
                                onPressed: forgotMyPassword,
                                child: const Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                            MyButton(
                              onTap: signUserIn,
                              textButton: 'Entrar',
                            ),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => handleGoogleLogin(context),
                          child: SquareTite(imagePath: 'lib/assets/google.png'),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: signInWithFacebook,
                          child:
                              SquareTite(imagePath: 'lib/assets/facebook.png'),
                        ),
                        const SizedBox(width: 15),
                        SquareTite(imagePath: 'lib/assets/yahoo.png'),
                      ],
                    )
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
      ],
    );
  }

// sign google user in method
  void handleGoogleLogin(BuildContext context) {
    AuthService().signInWithGoogle().then((String? errorMessage) async {
      if (errorMessage == null) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await AuthService().hasAdditionalInfo(user.uid).then((value) {
            if (value) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(user: user),
                ),
              );
            } else {
              // Redirecionar para a página de adição de informações para usuários do Google
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddInfoGoogleUser(user: user),
                ),
              );
            }
          });
        }
      } else if (errorMessage != "Login Cancelado") {
        // Exibir mensagem de erro
        print(errorMessage);
      }
    });
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

  forgotMyPassword() {
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
