import 'package:flutter/material.dart';
import 'package:foresty/authentication/screens/register_page.dart';
import 'package:foresty/authentication/screens/welcome_page.dart';
import 'authentication/screens/login_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RegisterScreen(),
    );
  }
}
