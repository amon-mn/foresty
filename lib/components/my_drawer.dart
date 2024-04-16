import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foresty/authentication/services/auth_service.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_tags/screens/tags_page.dart';
import 'package:image_picker/image_picker.dart';

class MyDrawer extends StatelessWidget {
  final User user;
  final VoidCallback onLogout;
  final Function(String) onRemoveAccount;
  final String? profileImageUrl;
  final Function(String)? onUpdateProfileImage;
  final List<ProductBatch> listBatchs;

  MyDrawer({
    required this.user,
    required this.onLogout,
    required this.onRemoveAccount,
    this.profileImageUrl,
    this.onUpdateProfileImage,
    required this.listBatchs, // Certifique-se de que esta linha está presente
  });

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      String userId = user.uid;
      String imageName = 'profile_image_$userId.jpg';
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(imageName);

      try {
        await storageRef.putFile(imageFile);
        String imageUrl = await storageRef.getDownloadURL();

        // Atualize a URL da imagem de perfil chamando a função de retorno de chamada
        if (onUpdateProfileImage != null) {
          onUpdateProfileImage!(
              imageUrl); // Chame a função de retorno de chamada
        }

        Navigator.of(context).pop(); // Feche o Drawer
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Foto de perfil atualizada com sucesso.'),
          ),
        );
      } catch (error) {
        print('Erro ao fazer upload da imagem: $error');
      }
    }
  }

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: (profileImageUrl != null)
                ? GestureDetector(
                    onTap: () {
                      _pickImage(context);
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: (profileImageUrl!.isNotEmpty)
                          ? NetworkImage(profileImageUrl!)
                          : null,
                      child: profileImageUrl!.isEmpty
                          ? Icon(
                              Icons.add_a_photo,
                              size: 40,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  )
                : null,
            accountName: Text(
              (user.displayName != null) ? user.displayName! : "",
            ),
            accountEmail: Text(user.email!),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 33, 87, 25),
                  Color.fromARGB(255, 13, 95, 0),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text("Remover conta"),
            onTap: () async {
              String? result =
                  await _authService.removeAccountWithEmail(context: context);
              if (result != null) {
                // Trate o resultado, se necessário
                print("Erro ao remover a conta: $result");
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('Etiquetas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TagScreen(
                    listBatchs: listBatchs,
                    user: user,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sair"),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
