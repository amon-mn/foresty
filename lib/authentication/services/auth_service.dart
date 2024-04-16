import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:foresty/authentication/screens/components/ask_for_password.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "Usuário não cadastrado";
        case "wrong-password":
          return "Email ou senha incorretos";
      }
      return e.code;
    }
    return null;
  }

  // Função de login via google
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          // Navegar para a página desejada após o login
          return null; // Retornar null significa que o login foi bem-sucedido.
        }
      }

      if (googleUser == null) {
        return "Login Cancelado";
      }
    } catch (error) {
      print("Erro durante o login com o Google: $error");
      return "Erro durante o login com o Google.";
    }
    return "Erro durante o login com o Google.";
  }

  Future<String?> registerUser({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String state,
    required String city,
    required String propertyName,
    String? cnpj,
    required String cep,
    required String street,
    required String neighborhood,
    required String locality,
    required bool isProducer,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userType = isProducer ? 'Producer' : 'Merchant';

      Map<String, dynamic> userData = {
        'name': name,
        'state': state,
        'city': city,
        'cpf': cpf,
      };

      if (isProducer) {
        userData.addAll({
          'propertyName': propertyName,
          'cep': cep,
          'street': street,
          'neighborhood': neighborhood,
          'locality': locality,
        });
      } else {
        userData.addAll({
          'propertyName': propertyName,
          'cnpj': cnpj,
          'cep': cep,
          'street': street,
          'neighborhood': neighborhood,
          'locality': locality,
        });
      }

      // Salvar informações personalizadas no Firebase Firestore com base no tipo de usuário
      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'userType': userType,
        ...userData,
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "O e-mail já está em uso.";
      }
      return e.code;
    }

    return null;
  }

  // Função de logout
  Future<String?> logout() async {
    try {
      print("Tentando fazer logout...");

      // Faz o logout do Google
      await GoogleSignIn().signOut();

      // Faz o logout do Firebase
      await _firebaseAuth.signOut();
      await GoogleSignIn().signOut();
      await FacebookAuth.instance.logOut();
      print("Logout realizado com sucesso!");
      return null; // Retornar null significa que o logout foi bem-sucedido.
    } catch (error) {
      print("Erro durante o logout: $error");
      return "Erro durante o logout: $error";
    }
  }

// Função para verificar se o usuario preencheu as informações de cadastro
  Future<bool> hasAdditionalInfo(String userId) async {
    try {
      DocumentSnapshot userSnapshot =
          await _firebaseFirestore.collection('users').doc(userId).get();

      return userSnapshot.exists;
    } catch (error) {
      print("Erro ao verificar informações adicionais: $error");
      return false;
    }
  }

  Future<String?> missPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return "E-mail não cadastrado.";
      }
      return e.code;
    }
    return null;
  }

  Future<String?> removeAccount({required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: _firebaseAuth.currentUser!.email!, password: senha);
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  Future<String?> removeAccountWithEmail(
      {required BuildContext context}) async {
    try {
      // Verifique se o usuário está autenticado com o provedor de e-mail/senha
      if (_firebaseAuth.currentUser != null &&
          _firebaseAuth.currentUser!.providerData
              .any((provider) => provider.providerId == 'password')) {
        // Se o usuário foi autenticado com e-mail/senha, solicite a senha
        String? senha;
        await showDialog(
          context: context,
          builder: (context) => AskForPassword(
            onPasswordEntered: (password) {
              senha = password;
            },
          ),
        );

        if (senha != null) {
          await _firebaseAuth.signInWithEmailAndPassword(
            email: _firebaseAuth.currentUser!.email!,
            password: senha!,
          );
          await _firebaseAuth.currentUser!.delete();
        } else {
          return "Operação de exclusão de conta cancelada.";
        }
      } else {
        // Se o usuário não foi autenticado com e-mail/senha,
        // envie um e-mail de confirmação para confirmar a exclusão da conta.
        String? email = _firebaseAuth.currentUser?.email;
        if (email != null) {
          await _sendDeleteAccountConfirmationEmail(email);
        }
        return "Um e-mail de confirmação foi enviado para a exclusão da conta.";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }

  Future<void> _sendDeleteAccountConfirmationEmail(String userEmail) async {
    final smtpServer = gmail('your.email@gmail.com', 'yourpassword');

    final message = Message()
      ..from = Address('seu.email@gmail.com', 'Seu Nome')
      ..recipients.add(userEmail)
      ..subject = 'Confirme a exclusão da sua conta'
      ..html =
          '<p>Clique no link abaixo para confirmar a exclusão da sua conta:</p>'
              '<p><a href="https://yourwebsite.com/delete-account?email=$userEmail">Confirmar exclusão da conta</a></p>';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error sending email: $e');
    }
  }
}
