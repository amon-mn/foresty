import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Função de login via email e senha
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

  // Função de registar um usuário
  Future<String?> registerUser({
    required String email,
    required String password,
    required String name,
    required String cpf,
    required String state,
    required String city,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Atualizar o perfil do usuário com o nome
      await userCredential.user!.updateDisplayName(name);

      // Armazenar as informações personalizadas no Firebase Firestore
      await _firebaseFirestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'state': state,
        'city': city,
        'cpf': cpf,
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

  // Função de logout
  Future<String?> logout() async {
    try {
      print("Tentando fazer logout...");

      // Faz o logout do Google
      await GoogleSignIn().signOut();

      // Faz o logout do Firebase
      await _firebaseAuth.signOut();

      print("Logout realizado com sucesso!");
      return null; // Retornar null significa que o logout foi bem-sucedido.
    } catch (error) {
      print("Erro durante o logout: $error");
      return "Erro durante o logout: $error";
    }
  }

  // Função de recuperar a senha
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

  // Função de deletar a conta
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
}
