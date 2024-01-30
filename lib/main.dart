import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/authentication/screens/adm_page.dart';
import 'package:foresty/authentication/screens/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}

class ProfileImageProvider with ChangeNotifier {
  String _imageUrl = '';

  String get imageUrl => _imageUrl;

  void updateImageUrl(String newImageUrl) {
    _imageUrl = newImageUrl;
    notifyListeners();
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;

            // Verifica o tipo de usuário imediatamente após a autenticação
            getUserType(user.uid).then((String userType) {
              if (userType == "ADM") {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AdmPage(user: user)),
                  (route) => false,
                );
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(user: user)),
                  (route) => false,
                );
              }
            });

            return Container(); // Você pode remover este Container
          } else {
            return const WelcomeScreen();
          }
        }
      },
    );
  }

  Future<String> getUserType(String userId) async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> userData =
        userSnapshot.data() as Map<String, dynamic>;
    return userData['userType'];
  }
}
