import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Importe o pacote font_awesome_flutter
import 'package:foresty/authentication/screens/add_info_user.dart';
import 'package:foresty/authentication/screens/adm_page.dart';
import 'package:foresty/authentication/screens/components/card_image.dart';

import 'package:foresty/home_page.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../components/my_button.dart';
import '../../components/my_textfield.dart';
import '../../components/show_snackbar.dart';
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
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();

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
  void signUserIn() async {
    String email = _emailController.text;
    String pass = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        String? erro =
            await authService.loginUser(email: email, password: pass);

        if (erro != null) {
          showSnackBar(context: context, mensagem: erro);
        } else {
          // Obtenha o ID do usuário atualmente autenticado
          String userId = FirebaseAuth.instance.currentUser!.uid;

          // Verifique o userType do usuário atual
          String userType = await getUserType(userId);

          if (userType == "ADM") {
            // Redirecione para a tela de super usuário (AdmPage).
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AdmPage(user: FirebaseAuth.instance.currentUser!),
              ),
            );
          } else {
            // Redirecione para a tela regular do usuário (HomePage).
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    HomePage(user: FirebaseAuth.instance.currentUser!),
              ),
            );
          }
        }
      } catch (e) {
        // Trate exceções, se necessário
        print("Erro durante o login: $e");
        showSnackBar(context: context, mensagem: "Erro durante o login");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<String> getUserType(String userId) async {
    // Use o Firebase para buscar os dados do usuário no banco de dados.
    // Retorne o valor do campo userType.
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    return userData['userType'];
  }

  forgotMyPassword() {
    String email = _emailController.text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
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

                  ImageCard(
                    imagePath: 'lib/assets/rastech_logo_with_name.png',
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

                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // username textfield
                          MyTextFieldWrapper(
                            prefixIcon: Icons.email,
                            controller: _emailController,
                            hintText: 'Email',
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
                          MyTextFieldWrapper(
                            prefixIcon: Icons.lock,
                            suffixIcon: _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            onSuffixIconPressed: togglePasswordVisibility,
                            controller: _passwordController,
                            hintText: 'Senha',
                            obscureText: _obscurePassword,
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
                              onPressed: forgotMyPassword,
                              child: const Text(
                                'Esqueceu a senha?',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          // sign in button
                          MyButton(
                            onTap: signUserIn,
                            textButton: 'Entrar',
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
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

                  const SizedBox(height: 12),

                  // google / facebook / yahoo sign in buttons
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton.icon(
                            onPressed: () => handleGoogleLogin(context),
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Entrar com Google',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red, // Cor primária
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
    ]);
  }

  // Função para alternar a visibilidade da senha
  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }
}
