import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/authentication/screens/create_form_page.dart';
import 'authentication/services/auth_service.dart';
import 'components/my_drawer.dart';
import 'components/show_password_confirmation_dialog.dart';
import 'authentication/screens/user_page.dart';
import 'authentication/screens/welcome_page.dart';
import 'package:foresty/authentication/screens/view_forms_page.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profileImageUrl = '';

  void handleLogout(BuildContext context) {
    AuthService().logout().then((String? erro) {
      if (erro == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          (route) => false,
        );
      } else {
        print("Erro durante o logout: $erro");
      }
    });
  }

  Future<void> fetchUserData(String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).get();
  }

  Future<String> getProfileImageURL(String userId) async {
    try {
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('profile_image_$userId.jpg');
      String imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (error) {
      print('Erro ao obter a URL da imagem de perfil: $error');
      return ''; // Retorna uma string vazia em caso de erro
    }
  }

  Future<void> fetchProfileImage() async {
    String imageUrl = await getProfileImageURL(widget.user.uid);
    setState(() {
      profileImageUrl = imageUrl;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(widget.user.uid);
    fetchProfileImage(); // Obtém a URL da imagem de perfil no início
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      drawer: MyDrawer(
        user: widget.user,
        onLogout: () => handleLogout(context),
        onRemoveAccount: (email) {
          showDialog(
            context: context,
            builder: (context) {
              return PasswordConfirmationDialog(email: widget.user.email!);
            },
          );
        },
        profileImageUrl: profileImageUrl,
        onUpdateProfileImage: updateProfileImage,
      ),
      appBar: AppBar(
        title: Text('Foresty'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () async {
              fetchUserData(widget.user.uid).then((userData) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPage(
                      email: widget.user.email!,
                    ),
                  ),
                );
              }).catchError((error) {
                // Lidar com erros aqui, se necessário.
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateFormPage()),
                );
              },
              child: Text('Novo Plantio'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewFormsPage()),
                );
              },
              child: Text('Vizualizar Plantios'),
            ),
          ],
        ),
      ),
    );
  }

  // Função de atualização da imagem de perfil
  void updateProfileImage(String imageUrl) {
    setState(() {
      profileImageUrl = imageUrl;
    });
  }
}
