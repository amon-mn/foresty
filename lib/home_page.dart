import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foresty/firestore_batch/models/batch.dart';
import 'package:foresty/firestore_batch/screens/batch_form_page.dart';
import 'package:foresty/firestore_batch/screens/components/batch_widget.dart';
import 'package:foresty/firestore_batch/services/batch_service.dart';

import 'authentication/services/auth_service.dart';
import 'components/my_drawer.dart';
import 'authentication/screens/components/show_password_confirmation_dialog.dart';
import 'authentication/screens/user_page.dart';
import 'authentication/screens/welcome_page.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String profileImageUrl = '';
  List<ProductBatch> listBatchs = [
    /*
    ProductBatch(
        largura: 2,
        comprimento: 3,
        latitude: -40.7473,
        longitude: 147.2552,
        finalidade: "Plantio de Hortaliças",
        ambiente: "Praia",
        tipoCultivo: "Convencional"),
    ProductBatch(
        largura: 4,
        comprimento: 5,
        latitude: -40.7473,
        longitude: 147.2552,
        finalidade: "Plantio de Frutas",
        ambiente: "AgroFloresta",
        tipoCultivo: "Floresta"),
        */
  ];
  BatchService batchService = BatchService();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    refresh();
    fetchUserData(widget.user.uid);
    fetchProfileImage(); // Obtém a URL da imagem de perfil no início
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
        title: const Text('Meus Produtos'),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(169, 127, 232, 129),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BatchFormPage(),
              ));

          /*Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contextNew) => FormScreen(
                        taskContext: context,
                      ))).then((value) => setState(() {
                print('Recarregando a Tela Inicial');
              }));
              */
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: (listBatchs.isEmpty)
          ? const Center(
              child: Text(
                "Nenhum lote ainda.\nVamos criar o primeiro?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                return refresh();
              },
              child: ListView(
                children: List.generate(listBatchs.length, (index) {
                  ProductBatch model = listBatchs[index];
                  return BatchWidget(title: (model.tipoCultivo));
                }),
              ),
            ),
    );
  }

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

  // Função de atualização da imagem de perfil
  void updateProfileImage(String imageUrl) {
    setState(() {
      profileImageUrl = imageUrl;
    });
  }

  refresh() async {
    List<ProductBatch> temp = await batchService.readBatchs();

    setState(() {
      listBatchs = temp;
    });
  }
}
