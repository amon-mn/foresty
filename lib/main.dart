import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foresty/authentication/screens/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'components/forms_provider.dart';
import 'firebase_options.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                FormularioProvider()), // Fornecendo o FormularioProvider
        // Adicione outros provedores, se necessário
      ],
      child: const MyApp(),
    ),
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
            // Usuário está logado, navegue para HomePage
            final user = snapshot.data!;
            Future.delayed(Duration.zero, () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage(user: user)),
                (route) => false, // Remove todas as rotas anteriores
              );
            });
            return Container(); // Você pode remover este Container
          } else {
            // Usuário não está logado, mostre a WelcomeScreen
            return const WelcomeScreen();
          }
        }
      },
    );
  }
}
